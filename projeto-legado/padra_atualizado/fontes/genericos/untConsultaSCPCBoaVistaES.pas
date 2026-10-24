unit untConsultaSCPCBoaVistaES;

interface

uses
   Classes, XMLDoc, XMLIntf, System.SysUtils, System.Rtti, System.StrUtils,
   System.Generics.Collections, idHTTP, IdSSLOpenSSL, EditFocus, untConsultaSCPC,
   untQckConsultaSCPC, frxClass, UniClientDataSet, Data.DB, untConstantes,
   untFuncoesGenerica;

type
  TNodeInfo = class(TPersistent)
  public
    constructor Create; virtual;
    function fGetRelatorio: String; virtual; abstract;
    function fGetQtdProtestos: Integer; virtual;
    function fGetQtdCheques: Integer; virtual;
  end;

  TNodeInfoClass = class of TNodeInfo;

  TNodeInfoList = class(TObjectList<TNodeInfo>)
  private
    FstrChildClassName: String;
  public
    constructor Create(strChildClassName: String); reintroduce;
    function getChildClassName(): String;
  end;

  TIdentificacaoBasico = class(TNodeInfo)
  private
    Fcnpj: String;
    Frazao_social: String;
    Fdata_consulta_receita_federal: TDate;
    Framo_atividade_primario: String;
    Fnire: String;
    Fdata_fundacao: TDate;
    Fsituacao_cnpj: String;
    Finscricao_estadual: String;
    Fnatureza_juridica: String;
    Fnome_fantasia: String;
    Fmensagem: String;
    Fdata_situacao_cnpj: TDate;
  public
    function fGetRelatorio: String; override;
  published
    property cnpj                           : String read Fcnpj                           write Fcnpj;
    property razao_social                   : String read Frazao_social                   write Frazao_social;
    property nome_fantasia                  : String read Fnome_fantasia                  write Fnome_fantasia;
    property situacao_cnpj                  : String read Fsituacao_cnpj                  write Fsituacao_cnpj;
    property data_situacao_cnpj             : TDate  read Fdata_situacao_cnpj             write Fdata_situacao_cnpj;
    property data_consulta_receita_federal  : TDate  read Fdata_consulta_receita_federal  write Fdata_consulta_receita_federal;
    property nire                           : String read Fnire                           write Fnire;
    property inscricao_estadual             : String read Finscricao_estadual             write Finscricao_estadual;
    property data_fundacao                  : TDate  read Fdata_fundacao                  write Fdata_fundacao;
    property natureza_juridica              : String read Fnatureza_juridica              write Fnatureza_juridica;
    property ramo_atividade_primario        : String read Framo_atividade_primario        write Framo_atividade_primario;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
  end;

  TIdentificacaoCompleto = class(TNodeInfo)
  private
    Framo_atividade_primario_cnae: String;
    Fcapital_atual: String;
    Fquantidade_filiais: String;
    Fcnpj: String;
    Framo_atividade_secundario_cnae: String;
    Frazao_social_anterior: String;
    Fdata_situacao: TDate;
    Frazao_social: String;
    Fdata_encerramento: TDate;
    Fdata_consulta_receita_federal: TDate;
    Fsegmento: String;
    Fnire: String;
    Fdata_fundacao: TDate;
    Fdata_consulta_sintegra: TDate;
    Fsituacao_cnpj: String;
    Fcapital_inicial: String;
    Finscricao_estadual: String;
    Fdata_alteracao_capital: TDate;
    Fdata_situacao_sintegra: TDate;
    Fnatureza_juridica: String;
    Fnome_fantasia: String;
    Framo_atividade_terciario_cnae: String;
    Forgao: String;
    Fdata_registro: TDate;
    Ffiliais: String;
    Fmensagem: String;
    Forgao_atual: String;
    Fsituacao_sintegra: String;
    Fdata_alteracao_razao_social: TDate;
    Fdemais_ramos_atividade_cnae: String;
  public
    function fGetRelatorio: String; override;
  published
    property cnpj                           : String read Fcnpj                           write Fcnpj;
    property razao_social                   : String read Frazao_social                   write Frazao_social;
    property nome_fantasia                  : String read Fnome_fantasia                  write Fnome_fantasia;
    property situacao_cnpj                  : String read Fsituacao_cnpj                  write Fsituacao_cnpj;
    property data_situacao                  : TDate  read Fdata_situacao                  write Fdata_situacao;
    property data_consulta_receita_federal  : TDate  read Fdata_consulta_receita_federal  write Fdata_consulta_receita_federal;
    property nire                           : String read Fnire                           write Fnire;
    property razao_social_anterior          : String read Frazao_social_anterior          write Frazao_social_anterior;
    property data_alteracao_razao_social    : TDate  read Fdata_alteracao_razao_social    write Fdata_alteracao_razao_social;
    property inscricao_estadual             : String read Finscricao_estadual             write Finscricao_estadual;
    property data_fundacao                  : TDate  read Fdata_fundacao                  write Fdata_fundacao;
    property data_encerramento              : TDate  read Fdata_encerramento              write Fdata_encerramento;
    property situacao_sintegra              : String read Fsituacao_sintegra              write Fsituacao_sintegra;
    property data_situacao_sintegra         : TDate  read Fdata_situacao_sintegra         write Fdata_situacao_sintegra;
    property data_consulta_sintegra         : TDate  read Fdata_consulta_sintegra         write Fdata_consulta_sintegra;
    property natureza_juridica              : String read Fnatureza_juridica              write Fnatureza_juridica;
    property segmento                       : String read Fsegmento                       write Fsegmento;
    property capital_inicial                : String read Fcapital_inicial                write Fcapital_inicial;
    property data_registro                  : TDate  read Fdata_registro                  write Fdata_registro;
    property orgao                          : String read Forgao                          write Forgao;
    property capital_atual                  : String read Fcapital_atual                  write Fcapital_atual;
    property data_alteracao_capital         : TDate  read Fdata_alteracao_capital         write Fdata_alteracao_capital;
    property orgao_atual                    : String read Forgao_atual                    write Forgao_atual;
    property ramo_atividade_primario_cnae   : String read Framo_atividade_primario_cnae   write Framo_atividade_primario_cnae;
    property ramo_atividade_secundario_cnae : String read Framo_atividade_secundario_cnae write Framo_atividade_secundario_cnae;
    property ramo_atividade_terciario_cnae  : String read Framo_atividade_terciario_cnae  write Framo_atividade_terciario_cnae;
    property demais_ramos_atividade_cnae    : String read Fdemais_ramos_atividade_cnae    write Fdemais_ramos_atividade_cnae;
    property quantidade_filiais             : String read Fquantidade_filiais             write Fquantidade_filiais;
    property filiais                        : String read Ffiliais                        write Ffiliais;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
  end;

  TLocalizacaoBasico = Class(TNodeInfo)
  private
    Flogradouro: String;
    Fbairro: String;
    Fuf: String;
    Ftipo_endereco: String;
    Fcep: String;
    Fnumero: String;
    Fcomplemento: String;
    Fmensagem: String;
    Fcidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property tipo_endereco                  : String read Ftipo_endereco                  write Ftipo_endereco;
    property logradouro                     : String read Flogradouro                     write Flogradouro;
    property numero                         : String read Fnumero                         write Fnumero;
    property complemento                    : String read Fcomplemento                    write Fcomplemento;
    property bairro                         : String read Fbairro                         write Fbairro;
    property cep                            : String read Fcep                            write Fcep;
    property cidade                         : String read Fcidade                         write Fcidade;
    property uf                             : String read Fuf                             write Fuf;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
  end;

  TMatriz = Class(TNodeInfo)
  private
    Fcidade_matriz: String;
    Fendereco_matriz: String;
    Ftelefone_matriz: TStrings;
    Fcodigo_ibge_matriz: String;
    Fbairro_matriz: String;
    Fuf_matriz: String;
    Fcep_matriz: String;
    Fcomplemento_matriz: String;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property endereco_matriz                : String   read Fendereco_matriz              write Fendereco_matriz;
    property complemento_matriz             : String   read Fcomplemento_matriz           write Fcomplemento_matriz;
    property codigo_ibge_matriz             : String   read Fcodigo_ibge_matriz           write Fcodigo_ibge_matriz;
    property bairro_matriz                  : String   read Fbairro_matriz                write Fbairro_matriz;
    property cep_matriz                     : String   read Fcep_matriz                   write Fcep_matriz;
    property cidade_matriz                  : String   read Fcidade_matriz                write Fcidade_matriz;
    property uf_matriz                      : String   read Fuf_matriz                    write Fuf_matriz;
    property telefone_matriz                : TStrings read Ftelefone_matriz              write Ftelefone_matriz;
  End;

  TFilial = Class(TNodeInfo)
  private
    Fuf_filial: String;
    Fcep_filial: String;
    Fcomplemento_filial: String;
    Fcidade_filial: String;
    Fendereco_filial: String;
    Ftelefone_filial: TStrings;
    Fcodigo_ibge_filial: String;
    Fbairro_filial: String;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property endereco_filial                : String   read Fendereco_filial              write Fendereco_filial;
    property complemento_filial             : String   read Fcomplemento_filial           write Fcomplemento_filial;
    property codigo_ibge_filial             : String   read Fcodigo_ibge_filial           write Fcodigo_ibge_filial;
    property bairro_filial                  : String   read Fbairro_filial                write Fbairro_filial;
    property cep_filial                     : String   read Fcep_filial                   write Fcep_filial;
    property cidade_filial                  : String   read Fcidade_filial                write Fcidade_filial;
    property uf_filial                      : String   read Fuf_filial                    write Fuf_filial;
    property telefone_filial                : TStrings read Ftelefone_filial              write Ftelefone_filial;
  End;

  TLocalizacaoCompleto = Class(TNodeInfo)
  private
    Ffilial: TFilial;
    Fmatriz: TMatriz;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property matriz                         : TMatriz read Fmatriz                        write Fmatriz;
    property filial                         : TFilial read Ffilial                        write Ffilial;
  End;

  TAlertaFraudes  = Class(TNodeInfo)
  private
    Fmensagem: String;
    Fdata: TDate;
  public
    function fGetRelatorio: String; override;
  published
    property data                           : TDate  read Fdata                           write Fdata;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
  End;

  TChequeSemFundo = Class(TNodeInfo)
  private
    Fbanco: String;
    Fmotivo: String;
    Fquantidade: String;
    Fagencia: String;
    Fnome: String;
    Fdata_ultimo: TDate;
  public
    function fGetRelatorio: String; override;
  published
    property nome                           : String read Fnome                           write Fnome;
    property data_ultimo                    : TDate  read Fdata_ultimo                    write Fdata_ultimo;
    property banco                          : String read Fbanco                          write Fbanco;
    property agencia                        : String read Fagencia                        write Fagencia;
    property motivo                         : String read Fmotivo                         write Fmotivo;
    property quantidade                     : String read Fquantidade                     write Fquantidade;
  End;

  TChequesSemFundo = Class(TNodeInfo)
  private
    Ftotal_cheques_sem_fundos: String;
    Ftotal_nomes_relacionados: String;
    Fmensagem: String;
    Fultimas_ocorrencias: TNodeInfoList;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
    function fGetQtdCheques: Integer; override;
    function fGetDataSet(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSetOcor(AOwner: TComponent): TUniClientDataSet;
    function fGetDataSetOcor(AOwner: TComponent): TUniClientDataSet;
  published
    property total_cheques_sem_fundos       : String read Ftotal_cheques_sem_fundos       write Ftotal_cheques_sem_fundos;
    property total_nomes_relacionados       : String read Ftotal_nomes_relacionados       write Ftotal_nomes_relacionados;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_ocorrencias: TNodeInfoList      read Fultimas_ocorrencias            write Fultimas_ocorrencias;
  End;

  TChequeSustado = Class(TNodeInfo)
  private
    Fdata_da_ocorrencia: TDate;
    Fbanco: String;
    Fcheques: String;
    Fagencia: String;
    Fdata: String;
    Fmensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property data                           : String read Fdata                           write Fdata;
    property banco                          : String read Fbanco                          write Fbanco;
    property agencia                        : String read Fagencia                        write Fagencia;
    property cheques                        : String read Fcheques                        write Fcheques;
    property data_da_ocorrencia             : TDate  read Fdata_da_ocorrencia             write Fdata_da_ocorrencia;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
  End;

  TChequesSustados = Class(TNodeInfo)
  private
    Fultimas_ocorrencias: TNodeInfoList;
    Ftotal: String;
    Fperiodo: String;
    Fmensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
    function fGetDataSet(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
    function fGetDataSetOcor(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSetOcor(AOwner: TComponent): TUniClientDataSet;
  published
    property total                          : String read Ftotal                          write Ftotal;
    property periodo                        : String read Fperiodo                        write Fperiodo;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_ocorrencias: TNodeInfoList      read Fultimas_ocorrencias            write Fultimas_ocorrencias;
  End;

  TChequeDevolvido = Class(TNodeInfo)
  private
    Finformante: String;
    Fbanco: String;
    Fagencia: String;
    Fcheques : String;
    Fdata_ocorrencia: TDate;
    Fdata_registro: TDate;
    Fmotivo: String;
    Fcidade_uf: String;
  public
    function fGetRelatorio: String; override;
  published
    property informante                     : String read Finformante                     write Finformante;
    property banco                          : String read Fbanco                          write Fbanco;
    property agencia                        : String read Fagencia                        write Fagencia;
    property cheques                        : String read Fcheques                        write Fcheques;
    property data_ocorrencia                : TDate  read Fdata_ocorrencia                write Fdata_ocorrencia;
    property data_registro                  : TDate  read Fdata_registro                  write Fdata_registro;
    property motivo                         : String read Fmotivo                         write Fmotivo;
    property cidade_uf                      : String read Fcidade_uf                      write Fcidade_uf;
  End;

  TChequesDevolvidos = Class(TNodeInfo)
  private
    Fultimas_ocorrencias: TNodeInfoList;
    Fquantidade_total: String;
    Fperiodo: String;
    Fmensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
    function fGetDataSet(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
    function fGetDataSetOcor(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSetOcor(AOwner: TComponent): TUniClientDataSet;
  published
    property quantidade_total               : String read Fquantidade_total               write Fquantidade_total;
    property periodo                        : String read Fperiodo                        write Fperiodo;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_ocorrencias: TNodeInfoList      read Fultimas_ocorrencias            write Fultimas_ocorrencias;
  End;

  TProtesto = Class(TNodeInfo)
  private
    Fvalor: String;
    Fcartorio: String;
    Fvencimento: String;
    Fcidade: String;
    Festado: String;
    Fdata: TDate;
  public
    function fGetRelatorio: String; override;
  published
    property data                           : TDate  read Fdata                           write Fdata;
    property vencimento                     : String read Fvencimento                     write Fvencimento;
    property cartorio                       : String read Fcartorio                       write Fcartorio;
    property cidade                         : String read Fcidade                         write Fcidade;
    property estado                         : String read Festado                         write Festado;
    property valor                          : String read Fvalor                          write Fvalor;
  End;

  TProtestos = Class(TNodeInfo)
  private
    Fvalor_maior: String;
    Fvalor_total: String;
    Ftotal_protestos: String;
    Fdata_primeiro: TDate;
    Fultimas_ocorrencias: TNodeInfoList;
    Fmensagem: String;
    Fvalor_primeiro: String;
    Fdata_maior: TDate;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetDataSet(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
    function fGetDataSetOcor(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSetOcor(AOwner: TComponent): TUniClientDataSet;
  published
    property total_protestos                : String read Ftotal_protestos                write Ftotal_protestos;
    property valor_total                    : String read Fvalor_total                    write Fvalor_total;
    property data_primeiro                  : TDate  read Fdata_primeiro                  write Fdata_primeiro;
    property valor_primeiro                 : String read Fvalor_primeiro                 write Fvalor_primeiro;
    property data_maior                     : TDate  read Fdata_maior                     write Fdata_maior;
    property valor_maior                    : String read Fvalor_maior                    write Fvalor_maior;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_ocorrencias: TNodeInfoList      read Fultimas_ocorrencias            write Fultimas_ocorrencias;
  End;

  TScore = Class(TNodeInfo)
  private
    Ftexto_explicativo: String;
    Fdescricao_natureza: String;
    Fcodigo_natureza_modelo: String;
    Fprobabilidade: String;
    Fscore: String;
    Fmodelo_score: String;
    Fplano_execucao: String;
    Fmodelo_plano: String;
    Fclassificacao_numerica: String;
    Fnome_score: String;
    Ftipo_score: String;
    Fclassificacao_alfabetica: String;
    Ftexto: String;
    Fnome_plano: String;
  public
    function fGetRelatorio: String; override;
  published
    property tipo_score                     : String read Ftipo_score                     write Ftipo_score;
    property score                          : String read Fscore                          write Fscore;
    property plano_execucao                 : String read Fplano_execucao                 write Fplano_execucao;
    property modelo_plano                   : String read Fmodelo_plano                   write Fmodelo_plano;
    property nome_plano                     : String read Fnome_plano                     write Fnome_plano;
    property modelo_score                   : String read Fmodelo_score                   write Fmodelo_score;
    property nome_score                     : String read Fnome_score                     write Fnome_score;
    property classificacao_numerica         : String read Fclassificacao_numerica         write Fclassificacao_numerica;
    property classificacao_alfabetica       : String read Fclassificacao_alfabetica       write Fclassificacao_alfabetica;
    property probabilidade                  : String read Fprobabilidade                  write Fprobabilidade;
    property texto                          : String read Ftexto                          write Ftexto;
    property codigo_natureza_modelo         : String read Fcodigo_natureza_modelo         write Fcodigo_natureza_modelo;
    property descricao_natureza             : String read Fdescricao_natureza             write Fdescricao_natureza;
    property texto_explicativo              : String read Ftexto_explicativo              write Ftexto_explicativo;
  End;

  TScores = Class(TNodeInfo)
  private
    Fscore_pj: TNodeInfoList;
    Fmensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property score_pj: TNodeInfoList                 read Fscore_pj                       write Fscore_pj;
  End;

  TPendenciaRestricao = Class(TNodeInfo)
  private
    Fdocumento_origem: String;
    Flocal: String;
    Fvalor: String;
    Finformante: String;
    Fdata_debito: TDate;
    Ftipo: String;
    Fdisponivel_em: String;
  public
    function fGetRelatorio: String; override;
  published
    property informante                     : String read Finformante                     write Finformante;
    property tipo                           : String read Ftipo                           write Ftipo;
    property local                          : String read Flocal                          write Flocal;
    property documento_origem               : String read Fdocumento_origem               write Fdocumento_origem;
    property data_debito                    : TDate  read Fdata_debito                    write Fdata_debito;
    property disponivel_em                  : String read Fdisponivel_em                  write Fdisponivel_em;
    property valor                          : String read Fvalor                          write Fvalor;
  End;

  TPendenciasRestricoes = Class(TNodeInfo)
  private
    Fvalor: String;
    Fvalor_maior: String;
    Fdata_primeiro: TDate;
    Fperiodo: String;
    Ftotal_pendencias: String;
    Fultimas_ocorrencias: TNodeInfoList;
    Fmensagem: String;
    Fvalor_primeiro: String;
    Ftotal_credores: String;
    Fdata_maior: TDate;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
    function fGetDataSet(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSetOcor(AOwner: TComponent): TUniClientDataSet;
    function fGetDataSetOcor(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
  published
    property total_pendencias               : String read Ftotal_pendencias               write Ftotal_pendencias;
    property total_credores                 : String read Ftotal_credores                 write Ftotal_credores;
    property valor                          : String read Fvalor                          write Fvalor;
    property periodo                        : String read Fperiodo                        write Fperiodo;
    property valor_primeiro                 : String read Fvalor_primeiro                 write Fvalor_primeiro;
    property data_primeiro                  : TDate  read Fdata_primeiro                  write Fdata_primeiro;
    property valor_maior                    : String read Fvalor_maior                    write Fvalor_maior;
    property data_maior                     : TDate  read Fdata_maior                     write Fdata_maior;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_ocorrencias: TNodeInfoList      read Fultimas_ocorrencias            write Fultimas_ocorrencias;
  End;

  TAcaoCivil = Class(TNodeInfo)
  private
    Fautor: String;
    Facao: String;
    Fvalor: String;
    Fvara: String;
    Fforo_uf: String;
    Fdocumento: String;
    Frequerido: String;
    Fdistribuicao: String;
    Fprocesso: String;
  public
    function fGetRelatorio: String; override;
  published
    property requerido                      : String read Frequerido                      write Frequerido;
    property acao                           : String read Facao                           write Facao;
    property documento                      : String read Fdocumento                      write Fdocumento;
    property foro_uf                        : String read Fforo_uf                        write Fforo_uf;
    property vara                           : String read Fvara                           write Fvara;
    property autor                          : String read Fautor                          write Fautor;
    property processo                       : String read Fprocesso                       write Fprocesso;
    property distribuicao                   : String read Fdistribuicao                   write Fdistribuicao;
    property valor                          : String read Fvalor                          write Fvalor;
  End;

  TAcoesCiveis = Class(TNodeInfo)
  private
    Fvalor_maior: String;
    Fvalor_total: String;
    Fdata_primeiro: TDate;
    Fultimas_ocorrencias: TNodeInfoList;
    Fmensagem: String;
    Fvalor_primeiro: String;
    Ftotal_acoes: String;
    Fdata_maior: TDate;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property total_acoes                    : String read Ftotal_acoes                    write Ftotal_acoes;
    property valor_total                    : String read Fvalor_total                    write Fvalor_total;
    property valor_primeiro                 : String read Fvalor_primeiro                 write Fvalor_primeiro;
    property data_primeiro                  : TDate  read Fdata_primeiro                  write Fdata_primeiro;
    property valor_maior                    : String read Fvalor_maior                    write Fvalor_maior;
    property data_maior                     : TDate  read Fdata_maior                     write Fdata_maior;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_ocorrencias: TNodeInfoList      read Fultimas_ocorrencias            write Fultimas_ocorrencias;
  End;

  TConsulta = Class(TNodeInfo)
  private
    Fcnpj: String;
    Frazao_social: String;
    Fdata: TDate;
  public
    function fGetRelatorio: String; override;
  published
    property data                           : TDate  read Fdata                           write Fdata;
    property razao_social                   : String read Frazao_social                   write Frazao_social;
    property cnpj                           : String read Fcnpj                           write Fcnpj;
  End;

  TConsultas = Class(TNodeInfo)
  private
    Fultimas_consultas: TNodeInfoList;
    Fperiodo: String;
    Fquantidade_total: String;
    Fmensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property quantidade_total               : String read Fquantidade_total               write Fquantidade_total;
    property periodo                        : String read Fperiodo                        write Fperiodo;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_consultas: TNodeInfoList        read Fultimas_consultas              write Fultimas_consultas;
  End;

  TParticipacaoOutrasEmpresas = Class(TNodeInfo)
  private
    Fentrada: TDate;
    Findicador_fraude: String;
    Findicador_debito: String;
    Fsituacao_cnpj: String;
    Fcnpj_participada: String;
    Frazao_social_participada: String;
    Fparticipacao: String;
  public
    function fGetRelatorio: String; override;
  published
    property razao_social_participada       : String read Frazao_social_participada       write Frazao_social_participada;
    property cnpj_participada               : String read Fcnpj_participada               write Fcnpj_participada;
    property situacao_cnpj                  : String read Fsituacao_cnpj                  write Fsituacao_cnpj;
    property participacao                   : String read Fparticipacao                   write Fparticipacao;
    property entrada                        : TDate  read Fentrada                        write Fentrada;
    property indicador_debito               : String read Findicador_debito               write Findicador_debito;
    property indicador_fraude               : String read Findicador_fraude               write Findicador_fraude;
  End;

  TFalenciaRecuperacaoJudicial = Class(TNodeInfo)
  private
    Fvara: String;
    Fuf: String;
    Ftipo_ocorrencia: String;
    Fcidade: String;
    Fdata: TDate;
  public
    function fGetRelatorio: String; override;
  published
    property tipo_ocorrencia                : String read Ftipo_ocorrencia                write Ftipo_ocorrencia;
    property data                           : TDate  read Fdata                           write Fdata;
    property cidade                         : String read Fcidade                         write Fcidade;
    property uf                             : String read Fuf                             write Fuf;
    property vara                           : String read Fvara                           write Fvara;
  End;

  TFalenciasRecuperacaoJudicial = Class(TNodeInfo)
  private
    Fperiodo: String;
    Fquantidade_total: String;
    Fultimas_ocorrencias: TNodeInfoList;
    Fmensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property quantidade_total               : String read Fquantidade_total               write Fquantidade_total;
    property periodo                        : String read Fperiodo                        write Fperiodo;
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultimas_ocorrencias: TNodeInfoList      read Fultimas_ocorrencias            write Fultimas_ocorrencias;
  End;

  TSocioCompleto = Class(TNodeInfo)
  private
    Fcpf_cnpj: String;
    Fnome_empresa: String;
    Findicador_fraude: String;
    Findicador_debito: String;
    Fassina_empresa: String;
    Fdata_entrada: TDate;
    Fsituacao_documento: String;
    Fparticipacao: String;
  public
    function fGetRelatorio: String; override;
  published
    property nome_empresa                   : String read Fnome_empresa                   write Fnome_empresa;
    property cpf_cnpj                       : String read Fcpf_cnpj                       write Fcpf_cnpj;
    property situacao_documento             : String read Fsituacao_documento             write Fsituacao_documento;
    property participacao                   : String read Fparticipacao                   write Fparticipacao;
    property data_entrada                   : TDate  read Fdata_entrada                   write Fdata_entrada;
    property assina_empresa                 : String read Fassina_empresa                 write Fassina_empresa;
    property indicador_debito               : String read Findicador_debito               write Findicador_debito;
    property indicador_fraude               : String read Findicador_fraude               write Findicador_fraude;
  End;

  TSocios = Class(TNodeInfo)
  private
    Fmensagem: String;
    Fsocio_completo: TSocioCompleto;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property socio_completo : TSocioCompleto         read Fsocio_completo                 write Fsocio_completo;
  End;

  TRestricaoDocumento = Class(TNodeInfo)
  private
    Fvalor: String;
    Fultima: TDate;
    Fquantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property quantidade                     : String read Fquantidade                     write Fquantidade;
    property valor                          : String read Fvalor                          write Fvalor;
    property ultima                         : TDate  read Fultima                         write Fultima;
  End;

  TRestricoesDocumento = Class(TNodeInfo)
  private
    Foutras_participacoes: TRestricaoDocumento;
    Fcheques_sem_fundo: TRestricaoDocumento;
    Ftitulos_vencer: TRestricaoDocumento;
    Fpagamentos: TRestricaoDocumento;
    Fconsultas: TRestricaoDocumento;
    Facoes_judiciais: TRestricaoDocumento;
    Fpendencias_restricoes: TRestricaoDocumento;
    Fprotestos: TRestricaoDocumento;
    Fcheques_sustado_motivo_21: TRestricaoDocumento;
    Frecuperacao_falencias: TRestricaoDocumento;
    Fregistro_debitos: TRestricaoDocumento;
    Ffalencias_empresariais: TRestricaoDocumento;
    Fsocios_administradores: TRestricaoDocumento;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property consultas                 : TRestricaoDocumento read Fconsultas                 write Fconsultas;
    property titulos_vencer            : TRestricaoDocumento read Ftitulos_vencer            write Ftitulos_vencer;
    property pagamentos                : TRestricaoDocumento read Fpagamentos                write Fpagamentos;
    property registro_debitos          : TRestricaoDocumento read Fregistro_debitos          write Fregistro_debitos;
    property cheques_sem_fundo         : TRestricaoDocumento read Fcheques_sem_fundo         write Fcheques_sem_fundo;
    property cheques_sustado_motivo_21 : TRestricaoDocumento read Fcheques_sustado_motivo_21 write Fcheques_sustado_motivo_21;
    property protestos                 : TRestricaoDocumento read Fprotestos                 write Fprotestos;
    property pendencias_restricoes     : TRestricaoDocumento read Fpendencias_restricoes     write Fpendencias_restricoes;
    property recuperacao_falencias     : TRestricaoDocumento read Frecuperacao_falencias     write Frecuperacao_falencias;
    property falencias_empresariais    : TRestricaoDocumento read Ffalencias_empresariais    write Ffalencias_empresariais;
    property acoes_judiciais           : TRestricaoDocumento read Facoes_judiciais           write Facoes_judiciais;
    property socios_administradores    : TRestricaoDocumento read Fsocios_administradores    write Fsocios_administradores;
    property outras_participacoes      : TRestricaoDocumento read Foutras_participacoes      write Foutras_participacoes;
  End;

  TAdministrador = Class(TNodeInfo)
  private
    Fentrada: TDate;
    Findicador_fraude: String;
    Findicador_debito: String;
    Frestricoes_documento: TRestricoesDocumento;
    Fmandato: String;
    Fcpf: String;
    Fsituacao_cpf: String;
    Fcargo: String;
    Fnome: String;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property nome                           : String read Fnome                           write Fnome;
    property cpf                            : String read Fcpf                            write Fcpf;
    property entrada                        : TDate  read Fentrada                        write Fentrada;
    property mandato                        : String read Fmandato                        write Fmandato;
    property cargo                          : String read Fcargo                          write Fcargo;
    property situacao_cpf                   : String read Fsituacao_cpf                   write Fsituacao_cpf;
    property indicador_debito               : String read Findicador_debito               write Findicador_debito;
    property indicador_fraude               : String read Findicador_fraude               write Findicador_fraude;
    property restricoes_documento : TRestricoesDocumento read Frestricoes_documento       write Frestricoes_documento;
  End;

  TReferencialNegocio = Class(TNodeInfo)
  private
    Fvalor: String;
    Fmedia: String;
    Fdata: String;
  public
    function fGetRelatorio: String; override;
  published
    property data                           : String read Fdata                           write Fdata;
    property valor                          : String read Fvalor                          write Fvalor;
    property media                          : String read Fmedia                          write Fmedia;
  End;

  TReferenciaisNegocios = Class(TNodeInfo)
  private
    Fmaior_fatura: TReferencialNegocio;
    Fultima_compra: TReferencialNegocio;
    Fmensagem: String;
    Fmaior_credito: TReferencialNegocio;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property mensagem                       : String read Fmensagem                       write Fmensagem;
    property ultima_compra     : TReferencialNegocio read Fultima_compra                  write Fultima_compra;
    property maior_fatura      : TReferencialNegocio read Fmaior_fatura                   write Fmaior_fatura;
    property maior_credito     : TReferencialNegocio read Fmaior_credito                  write Fmaior_credito;
  End;

  TItemPainelControle = Class(TNodeInfo)
  private
    Fdata_ultima: TDate;
    Fflag_decisao: String;
    Fvalor_total: String;
    Fquantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property quantidade                     : String read Fquantidade                     write Fquantidade;
    property data_ultima                    : TDate  read Fdata_ultima                    write Fdata_ultima;
    property valor_total                    : String read Fvalor_total                    write Fvalor_total;
    property flag_decisao                   : String read Fflag_decisao                   write Fflag_decisao;
  End;

  TPainelControle = Class(TNodeInfo)
  private
    Frecuperacao: TItemPainelControle;
    Fcheque_informado_usuario: TItemPainelControle;
    Fcheque_sem_fundo: TItemPainelControle;
    Falerta_fraude: TItemPainelControle;
    Fcheque_sustado: TItemPainelControle;
    Fprotesto: TItemPainelControle;
    Fregistro_debito: TItemPainelControle;
    Facoes_civeis: TItemPainelControle;
    Ffalencia: TItemPainelControle;
    Fpendencias_restricoes: TItemPainelControle;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
    function fGetDataSet(AOwner: TComponent): TUniClientDataSet;
    function fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
  published
    property registro_debito   : TItemPainelControle read Fregistro_debito                write Fregistro_debito;
    property protesto          : TItemPainelControle read Fprotesto                       write Fprotesto;
    property cheque_sem_fundo  : TItemPainelControle read Fcheque_sem_fundo               write Fcheque_sem_fundo;
    property cheque_sustado    : TItemPainelControle read Fcheque_sustado                 write Fcheque_sustado;
    property cheque_informado_usuario: TItemPainelControle read Fcheque_informado_usuario write Fcheque_informado_usuario;
    property acoes_civeis      : TItemPainelControle read Facoes_civeis                   write Facoes_civeis;
    property recuperacao       : TItemPainelControle read Frecuperacao                    write Frecuperacao;
    property falencia          : TItemPainelControle read Ffalencia                       write Ffalencia;
    property alerta_fraude     : TItemPainelControle read Falerta_fraude                  write Falerta_fraude;
    property pendencias_restricoes   : TItemPainelControle read Fpendencias_restricoes    write Fpendencias_restricoes;
  End;

  TItemValidacao = Class(TNodeInfo)
  private
    Fflag_decisao: String;
    Fquantidade: String;
    Fvalidacao: String;
  public
    function fGetRelatorio: String; override;
  published
    property quantidade                     : String read Fquantidade                     write Fquantidade;
    property validacao                      : String read Fvalidacao                      write Fvalidacao;
    property flag_decisao                   : String read Fflag_decisao                   write Fflag_decisao;
  End;

  TValidacoes = Class(TNodeInfo)
  private
    Fsocios: TItemValidacao;
    Fadministradores: TItemValidacao;
    Fdata_fundacao: TItemValidacao;
    Fsituacao_cnpj: TItemValidacao;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property situacao_cnpj          : TItemValidacao read Fsituacao_cnpj                  write Fsituacao_cnpj;
    property data_fundacao          : TItemValidacao read Fdata_fundacao                  write Fdata_fundacao;
    property socios                 : TItemValidacao read Fsocios                         write Fsocios;
    property administradores        : TItemValidacao read Fadministradores                write Fadministradores;
  End;

  TPreciso = Class(TNodeInfo)
  private
    Fidentificacao_basico: TIdentificacaoBasico;
    Fidentificacao_completo: TIdentificacaoCompleto;
    Flocalizacao_basico: TLocalizacaoBasico;
    Flocalizacao_completo: TLocalizacaoCompleto;
    Falerta_faudes: TAlertaFraudes;
    Fcheques_sem_fundo: TChequesSemFundo;
    Fcheques_sustados: TChequesSustados;
    Fprotestos: TProtestos;
    Fscore: TScores;
    Fpendencias_restricoes: TPendenciasRestricoes;
    Facoes_civeis: TAcoesCiveis;
    Fconsultas: TConsultas;
    Fparticipacoes_em_outras_empresas: TParticipacaoOutrasEmpresas;
    Ffalencias_recuperacao_judicial: TFalenciasRecuperacaoJudicial;
    Fpainel_controle: TPainelControle;
    Fvalidacoes: TValidacoes;
    Frestricoes_documento: TRestricoesDocumento;
    Fsocios: TSocios;
    Fadministradores: TNodeInfoList;
    Freferenciais_negocios: TReferenciaisNegocios;
    Fcheques_devolvidos_informados_usuario: TChequesDevolvidos;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetQtdCheques: Integer; override;
  published
    property identificacao_basico  : TIdentificacaoBasico   read Fidentificacao_basico   write Fidentificacao_basico;
    property identificacao_completo: TIdentificacaoCompleto read Fidentificacao_completo write Fidentificacao_completo;
    property localizacao_basico    : TLocalizacaoBasico     read Flocalizacao_basico     write Flocalizacao_basico;
    property localizacao_completo  : TLocalizacaoCompleto   read Flocalizacao_completo   write Flocalizacao_completo;
    property alerta_fraudes        : TAlertaFraudes         read Falerta_faudes          write Falerta_faudes;
    property cheques_sem_fundo     : TChequesSemFundo       read Fcheques_sem_fundo      write Fcheques_sem_fundo;
    property cheques_sustados      : TChequesSustados       read Fcheques_sustados       write Fcheques_sustados;
    property protestos             : TProtestos             read Fprotestos              write Fprotestos;
    property score                 : TScores                read Fscore                  write Fscore;
    property pendencias_restricoes : TPendenciasRestricoes  read Fpendencias_restricoes  write Fpendencias_restricoes;
    property acoes_civeis          : TAcoesCiveis           read Facoes_civeis           write Facoes_civeis;
    property consultas             : TConsultas             read Fconsultas              write Fconsultas;
    property participacoes_em_outras_empresas: TParticipacaoOutrasEmpresas read Fparticipacoes_em_outras_empresas write Fparticipacoes_em_outras_empresas;
    property falencias_recuperacao_judicial: TFalenciasRecuperacaoJudicial read Ffalencias_recuperacao_judicial   write Ffalencias_recuperacao_judicial;
    property socios                : TSocios                read Fsocios                 write Fsocios;
    property administradores       : TNodeInfoList          read Fadministradores        write Fadministradores;
    property referenciais_negocios : TReferenciaisNegocios  read Freferenciais_negocios  write Freferenciais_negocios;
    property painel_controle       : TPainelControle        read Fpainel_controle        write Fpainel_controle;
    property validacoes            : TValidacoes            read Fvalidacoes             write Fvalidacoes;
    property restricoes_documento  : TRestricoesDocumento   read Frestricoes_documento   write Frestricoes_documento;
    property cheques_devolvidos_informados_usuario : TChequesDevolvidos read Fcheques_devolvidos_informados_usuario write Fcheques_devolvidos_informados_usuario;
  End;

  TConsultaSCPCBoaVistaES = class(TConsultaSCPC)
  private
    FHTTP: TidHTTP;
    FPreciso: TPreciso;
    FErros: TStringList;
    FXmlRetorno: TXMLDocument;
    FDocConsulta: String;
    FNomeEmpresa: String;
    FCidadeUF: String;
    FConsulta: String;
    FLogin: String;
    FSenha: String;
    FLoginAutomatico: Boolean;
    function fConsultaServico(strDocumento: String): Boolean;
    function fParseErros(node: IXmlNode): Boolean;
    function fFindChildNode(node: IXmlNode; strChildNodeName: String): IXmlNode;
    function fParseNode(strNomeClasse: String; node: IXmlNode): TNodeInfo;
    procedure pAddChildNodes(lstList: TNodeInfoList; node: IXmlNode);
    procedure pSaveToPDF(Const strFileName: String);
  protected
    function fGetMsgErro: String; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetQtdCheques: Integer; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean; override;
    procedure pSaveToFile(Const strFileName: String); override;
  end;

implementation

uses untFuncoes, untFuncoesSimples;

{ TNodeInfo }

constructor TNodeInfo.Create;
begin
  inherited Create;
end;

function TNodeInfo.fGetQtdCheques: Integer;
begin
  Result := 0;
end;

function TNodeInfo.fGetQtdProtestos: Integer;
begin
  Result := 0;
end;

{ TNodeInfoList }

constructor TNodeInfoList.Create(strChildClassName: String);
begin
  inherited Create();
  FstrChildClassName := strChildClassName;
end;

function TNodeInfoList.getChildClassName: String;
begin
  Result := FstrChildClassName;
end;

{ TIdentificacaoBasico }

function TIdentificacaoBasico.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '               IDENTIFICAÇÃO BÁSICO               ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Cnpj:                    ' + Fcnpj + #13#10;
  Result := Result + 'Razão social:            ' + Frazao_social + #13#10;
  Result := Result + 'Nome fantasia:           ' + Fnome_fantasia + #13#10;
  Result := Result + 'Situação Cnpj:           ' + Fsituacao_cnpj + #13#10;
  Result := Result + 'Data sit. Cnpj:          ' + DateToStr(Fdata_situacao_cnpj) + #13#10;
  Result := Result + 'Data da cons. rec. fed.: ' + DateToStr(Fdata_consulta_receita_federal) + #13#10;
  Result := Result + 'Nire:                    ' + Fnire + #13#10;
  Result := Result + 'Inscrição estadual:      ' + Finscricao_estadual + #13#10;
  Result := Result + 'Data da fundação:        ' + DateToStr(Fdata_fundacao) + #13#10;
  Result := Result + 'Natureza Jurídica:       ' + Fnatureza_juridica + #13#10;
  Result := Result + 'Ramo atividade prim.:    ' + Framo_atividade_primario + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TIdentificacaoCompleto }

function TIdentificacaoCompleto.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '              IDENTIFICAÇÃO COMPLETO              ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Cnpj:                    ' + Fcnpj + #13#10;
  Result := Result + 'Razão social:            ' + Frazao_social + #13#10;
  Result := Result + 'Nome fantasia:           ' + Fnome_fantasia + #13#10;
  Result := Result + 'Situação Cnpj:           ' + Fsituacao_cnpj + #13#10;
  Result := Result + 'Data sit. Cnpj:          ' + DateToStr(Fdata_situacao) + #13#10;
  Result := Result + 'Data da cons. rec. fed.: ' + DateToStr(Fdata_consulta_receita_federal) + #13#10;
  Result := Result + 'Nire:                    ' + Fnire + #13#10;
  Result := Result + 'Razão social anterior:   ' + Frazao_social_anterior + #13#10;
  Result := Result + 'Data alt. razão social:  ' + DateToStr(Fdata_alteracao_razao_social) + #13#10;
  Result := Result + 'Inscrição estadual:      ' + Finscricao_estadual + #13#10;
  Result := Result + 'Data da fundação:        ' + DateToStr(Fdata_fundacao) + #13#10;
  Result := Result + 'Data do encerramento:    ' + DateToStr(Fdata_encerramento) + #13#10;
  Result := Result + 'Data do encerramento:    ' + Fsituacao_sintegra + #13#10;
  Result := Result + 'Data do encerramento:    ' + DateToStr(Fdata_situacao_sintegra) + #13#10;
  Result := Result + 'Data do encerramento:    ' + DateToStr(Fdata_consulta_sintegra) + #13#10;
  Result := Result + 'Natureza Jurídica:       ' + Fnatureza_juridica + #13#10;
  Result := Result + 'Segmento:                ' + Fsegmento + #13#10;
  Result := Result + 'Capital inicial:         ' + Fcapital_inicial + #13#10;
  Result := Result + 'Data do registro:        ' + DateToStr(Fdata_registro) + #13#10;
  Result := Result + 'Órgão:                   ' + Forgao + #13#10;
  Result := Result + 'Capital atual:           ' + Fcapital_atual + #13#10;
  Result := Result + 'Data alt. capital:       ' + DateToStr(Fdata_alteracao_capital) + #13#10;
  Result := Result + 'Órgão atual:             ' + Forgao_atual + #13#10;
  Result := Result + 'Ramo ativ. primário:     ' + Framo_atividade_primario_cnae + #13#10;
  Result := Result + 'Ramo ativ. secundário:   ' + Framo_atividade_secundario_cnae + #13#10;
  Result := Result + 'Ramo ativ. terceário:    ' + Framo_atividade_terciario_cnae + #13#10;
  Result := Result + 'Demais ramos ativ.:      ' + Fdemais_ramos_atividade_cnae + #13#10;
  Result := Result + 'Quantidade de filiais:   ' + Fquantidade_filiais + #13#10;
  Result := Result + 'Filiais:                 ' + Ffiliais + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TLocalizacaoBasico }

function TLocalizacaoBasico.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                LOCALIZAÇÃO BÁSICO                ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Tipo de endereço:        ' + Ftipo_endereco + #13#10;
  Result := Result + 'Logradouro:              ' + Flogradouro + #13#10;
  Result := Result + 'Número:                  ' + Fnumero + #13#10;
  Result := Result + 'Complemento:             ' + Fcomplemento + #13#10;
  Result := Result + 'Bairro:                  ' + Fbairro + #13#10;
  Result := Result + 'Cep:                     ' + Fcep + #13#10;
  Result := Result + 'Cidade:                  ' + Fcidade + #13#10;
  Result := Result + 'Estado:                  ' + Fuf + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TMatriz }

destructor TMatriz.Destroy;
begin
  FreeAndNil(Ftelefone_matriz);
  inherited;
end;

function TMatriz.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := Result + 'Endereço:                ' + Fendereco_matriz + #13#10;
  Result := Result + 'Complemento:             ' + Fcomplemento_matriz + #13#10;
  Result := Result + 'Código Ibge:             ' + Fcodigo_ibge_matriz + #13#10;
  Result := Result + 'Bairro:                  ' + Fbairro_matriz + #13#10;
  Result := Result + 'Cep:                     ' + Fcep_matriz + #13#10;
  Result := Result + 'Cidade:                  ' + Fcidade_matriz + #13#10;
  Result := Result + 'Estado:                  ' + Fuf_matriz + #13#10;
  If (Ftelefone_matriz <> nil) And (Ftelefone_matriz.Count > 0) Then
  Begin
    Result := Result + 'Telefones:               ' + Ftelefone_matriz.Strings[0] + #13#10;
    For intIdx := 1 To Ftelefone_matriz.Count - 1 Do
      Result := Result + '                         ' + Ftelefone_matriz.Strings[intIdx] + #13#10;
  End;
end;

{ TFilial }

destructor TFilial.Destroy;
begin
  FreeAndNil(Ftelefone_filial);
  inherited;
end;

function TFilial.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := Result + 'Endereço:                ' + Fendereco_filial + #13#10;
  Result := Result + 'Complemento:             ' + Fcomplemento_filial + #13#10;
  Result := Result + 'Código Ibge:             ' + Fcodigo_ibge_filial + #13#10;
  Result := Result + 'Bairro:                  ' + Fbairro_filial + #13#10;
  Result := Result + 'Cep:                     ' + Fcep_filial + #13#10;
  Result := Result + 'Cidade:                  ' + Fcidade_filial + #13#10;
  Result := Result + 'Estado:                  ' + Fuf_filial + #13#10;
  If (Ftelefone_filial <> nil) And (Ftelefone_filial.Count > 0) Then
  Begin
    Result := Result + 'Telefones:               ' + Ftelefone_filial.Strings[0] + #13#10;
    For intIdx := 1 To Ftelefone_filial.Count - 1 Do
      Result := Result + '                         ' + Ftelefone_filial.Strings[intIdx] + #13#10;
  End;
end;

{ TLocalizacaoCompleto }

destructor TLocalizacaoCompleto.Destroy;
begin
  FreeAndNil(Ffilial);
  FreeAndNil(Fmatriz);
  inherited;
end;

function TLocalizacaoCompleto.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '               LOCALIZAÇÃO COMPLETO               ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  If (Fmatriz <> nil) Then
  Begin
    Result := Result + #13#10;
    Result := Result + '                      MATRIZ                      ' + #13#10;
    Result := Result + #13#10;
    Result := Result + Fmatriz.fGetRelatorio();
  End;
  If (Ffilial <> nil) Then
  Begin
    Result := Result + #13#10;
    Result := Result + '                      FILIAL                      ' + #13#10;
    Result := Result + #13#10;
    Result := Result + Ffilial.fGetRelatorio();
  End;
end;

{ TAlertaFraudes }

function TAlertaFraudes.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                ALERTA DE FRAUDES                 ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Data:                    ' + DateToStr(Fdata) + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TChequeSemFundo }

function TChequeSemFundo.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Nome:                     ' + Fnome + #13#10;
  Result := Result + 'Data último:              ' + DateToStr(Fdata_ultimo) + #13#10;
  Result := Result + 'Banco:                    ' + Fbanco + #13#10;
  Result := Result + 'Agência:                  ' + Fagencia + #13#10;
  Result := Result + 'Motivo:                   ' + Fmotivo + #13#10;
  Result := Result + 'Quantidade:               ' + Fquantidade + #13#10;
end;

{ TChequesSemFundo }

constructor TChequesSemFundo.Create;
begin
  inherited Create;
  Fultimas_ocorrencias := TNodeInfoList.Create('TChequeSemFundo');
end;

destructor TChequesSemFundo.Destroy;
begin
  FreeAndNil(Fultimas_ocorrencias);
  inherited;
end;

function TChequesSemFundo.fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'total_cheques_sem_fundos';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'total_nomes_relacionados';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'mensagem';
    DataType := ftString;
    Size     := 120;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TChequesSemFundo.fCriaDataSetOcor(
  AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'banco';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'motivo';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'quantidade';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'agencia';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_ultimo';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'nome';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TChequesSemFundo.fGetDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := fCriaDataSet(AOwner);

  Result.Insert;
  Result.FieldByName('total_cheques_sem_fundos').AsString := Ftotal_cheques_sem_fundos;
  Result.FieldByName('total_nomes_relacionados').AsString := Ftotal_nomes_relacionados;
  Result.FieldByName('mensagem').AsString                 := Fmensagem;
  Result.Post;
end;

function TChequesSemFundo.fGetDataSetOcor(
  AOwner: TComponent): TUniClientDataSet;
var
  intIdx: Integer;
begin
  Result := fCriaDataSetOcor(AOwner);

  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
  Begin
    Result.Insert;
    Result.FieldByName('banco').AsString         := TChequeSemFundo(Fultimas_ocorrencias.Items[intIdx]).Fbanco;
    Result.FieldByName('motivo').AsString        := TChequeSemFundo(Fultimas_ocorrencias.Items[intIdx]).Fmotivo;
    Result.FieldByName('quantidade').AsString    := TChequeSemFundo(Fultimas_ocorrencias.Items[intIdx]).Fquantidade;
    Result.FieldByName('agencia').AsString       := TChequeSemFundo(Fultimas_ocorrencias.Items[intIdx]).Fagencia;
    Result.FieldByName('nome').AsString          := TChequeSemFundo(Fultimas_ocorrencias.Items[intIdx]).Fnome;
    Result.FieldByName('data_ultimo').AsString   := IIF(TChequeSemFundo(Fultimas_ocorrencias.Items[intIdx]).Fdata_ultimo=0,'-',DateToStr(TChequeSemFundo(Fultimas_ocorrencias.Items[intIdx]).Fdata_ultimo));
    Result.Post;
  End;
end;

function TChequesSemFundo.fGetQtdCheques: Integer;
begin
  Result := StrToIntDef(Ftotal_cheques_sem_fundos,0);
end;

function TChequesSemFundo.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                CHEQUES SEM FUNDO                 ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Total cheques sem fundos: ' + Ftotal_cheques_sem_fundos + #13#10;
  Result := Result + 'Total nomes relacionados: ' + Ftotal_nomes_relacionados + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '               ÚLTIMAS OCORRÊNCIAS                ' + #13#10;
  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
    Result := Result + Fultimas_ocorrencias.Items[intIdx].fGetRelatorio();
end;

{ TChequeSustado }

function TChequesSustados.fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'total';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'periodo';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'mensagem';
    DataType := ftString;
    Size     := 120;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TChequesSustados.fCriaDataSetOcor(
  AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'banco';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'agencia';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'cheques';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_da_ocorrencia';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TChequesSustados.fGetDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := fCriaDataSet(AOwner);

  Result.Insert;
  Result.FieldByName('total').AsString    := Ftotal;
  Result.FieldByName('periodo').AsString  := Fperiodo;
  Result.FieldByName('mensagem').AsString := Fmensagem;
  Result.Post;
end;

function TChequesSustados.fGetDataSetOcor(
  AOwner: TComponent): TUniClientDataSet;
var
  intIdx: Integer;
begin
  Result := fCriaDataSetOcor(AOwner);

  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
  Begin
    Result.Insert;
    Result.FieldByName('banco').AsString              := TChequeSustado(Fultimas_ocorrencias.Items[intIdx]).Fbanco;
    Result.FieldByName('agencia').AsString            := TChequeSustado(Fultimas_ocorrencias.Items[intIdx]).Fagencia;
    Result.FieldByName('cheques').AsString            := TChequeSustado(Fultimas_ocorrencias.Items[intIdx]).Fcheques;
    Result.FieldByName('data_da_ocorrencia').AsString := IIF(TChequeSustado(Fultimas_ocorrencias.Items[intIdx]).Fdata_da_ocorrencia=0,'-',DateToStr(TChequeSustado(Fultimas_ocorrencias.Items[intIdx]).Fdata_da_ocorrencia));
    Result.FieldByName('data').AsString               := TChequeSustado(Fultimas_ocorrencias.Items[intIdx]).Fdata;
    Result.Post;
  End;
end;

function TChequeSustado.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Data:                     ' + Fdata + #13#10;
  Result := Result + 'Banco:                    ' + Fbanco + #13#10;
  Result := Result + 'Agência:                  ' + Fagencia + #13#10;
  Result := Result + 'Cheques:                  ' + Fcheques + #13#10;
  Result := Result + 'Data da ocorrência:       ' + DateToStr(Fdata_da_ocorrencia) + #13#10;
end;

{ TChequesSustados }

constructor TChequesSustados.Create;
begin
  inherited Create;
  Fultimas_ocorrencias := TNodeInfoList.Create('TChequeSustado');
end;

destructor TChequesSustados.Destroy;
begin
  FreeAndNil(Fultimas_ocorrencias);
  inherited;
end;

function TChequesSustados.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                 CHEQUES SUSTADOS                 ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Total:                    ' + Ftotal + #13#10;
  Result := Result + 'Período:                  ' + Fperiodo + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '               ÚLTIMAS OCORRÊNCIAS                ' + #13#10;
  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
    Result := Result + Fultimas_ocorrencias.Items[intIdx].fGetRelatorio();
end;

{ TProtesto }

function TProtesto.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Data:                     ' + DateToStr(Fdata) + #13#10;
  Result := Result + 'Vencimento:               ' + Fvencimento + #13#10;
  Result := Result + 'Cartório:                 ' + Fcartorio + #13#10;
  Result := Result + 'Cidade:                   ' + Fcidade + #13#10;
  Result := Result + 'Estado:                   ' + Festado + #13#10;
  Result := Result + 'Valor:                    ' + Fvalor + #13#10;
end;

{ TProtestos }

constructor TProtestos.Create;
begin
  inherited Create;
  Fultimas_ocorrencias := TNodeInfoList.Create('TProtesto');
end;

destructor TProtestos.Destroy;
begin
  FreeAndNil(Fultimas_ocorrencias);
  inherited;
end;

function TProtestos.fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'total_protestos';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor_total';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor_primeiro';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor_maior';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_primeiro';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_maior';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'mensagem';
    DataType := ftString;
    Size     := 120;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TProtestos.fCriaDataSetOcor(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'cartorio';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'cidade';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'estado';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'vencimento';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TProtestos.fGetDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := fCriaDataSet(AOwner);

  Result.Insert;
  Result.FieldByName('total_protestos').AsString := Ftotal_protestos;
  Result.FieldByName('valor_total').AsString     := Fvalor_total;
  Result.FieldByName('valor_primeiro').AsString  := Fvalor_primeiro;
  Result.FieldByName('valor_maior').AsString     := Fvalor_maior;
  Result.FieldByName('mensagem').AsString        := Fmensagem;
  Result.FieldByName('data_primeiro').AsString   := IIF(Fdata_primeiro=0,'-',DateToStr(Fdata_primeiro));
  Result.FieldByName('data_maior').AsString      := IIF(Fdata_maior=0,'-',DateToStr(Fdata_maior));
  Result.Post;
end;

function TProtestos.fGetDataSetOcor(AOwner: TComponent): TUniClientDataSet;
var
  intIdx: Integer;
begin
  Result := fCriaDataSetOcor(AOwner);

  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
  Begin
    Result.Insert;
    Result.FieldByName('cartorio').AsString   := TProtesto(Fultimas_ocorrencias.Items[intIdx]).Fcartorio;
    Result.FieldByName('cidade').AsString     := TProtesto(Fultimas_ocorrencias.Items[intIdx]).Fcidade;
    Result.FieldByName('estado').AsString     := TProtesto(Fultimas_ocorrencias.Items[intIdx]).Festado;
    Result.FieldByName('vencimento').AsString := TProtesto(Fultimas_ocorrencias.Items[intIdx]).Fvencimento;
    Result.FieldByName('valor').AsString      := TProtesto(Fultimas_ocorrencias.Items[intIdx]).Fvalor;
    Result.FieldByName('data').AsString       := IIF(TProtesto(Fultimas_ocorrencias.Items[intIdx]).Fdata=0,'-',DateToStr(TProtesto(Fultimas_ocorrencias.Items[intIdx]).Fdata));
    Result.Post;
  End;
end;

function TProtestos.fGetQtdProtestos: Integer;
begin
  Result := StrToIntDef(Ftotal_protestos,0);
end;

function TProtestos.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                    PROTESTOS                     ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Total protestos:          ' + Ftotal_protestos + #13#10;
  Result := Result + 'Valor total:              ' + Fvalor_total + #13#10;
  Result := Result + 'Data primeiro:            ' + IIF(Fdata_primeiro=0,'-',DateToStr(Fdata_primeiro)) + #13#10;
  Result := Result + 'Valor primeiro:           ' + Fvalor_primeiro + #13#10;
  Result := Result + 'Data maior:               ' + IIF(Fdata_maior=0,'-',DateToStr(Fdata_maior)) + #13#10;
  Result := Result + 'Valor maior:              ' + Fvalor_maior + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '               ÚLTIMAS OCORRÊNCIAS                ' + #13#10;
  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
    Result := Result + Fultimas_ocorrencias.Items[intIdx].fGetRelatorio();
end;

{ TScore }

function TScore.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Tipo de score:            ' + Ftipo_score + #13#10;
  Result := Result + 'Score:                    ' + Fscore + #13#10;
  Result := Result + 'Plano de execução:        ' + Fplano_execucao + #13#10;
  Result := Result + 'Modelo do plano:          ' + Fmodelo_plano + #13#10;
  Result := Result + 'Nome do plano:            ' + Fnome_plano + #13#10;
  Result := Result + 'Modelo de score:          ' + Fmodelo_score + #13#10;
  Result := Result + 'Nome do score:            ' + Fnome_score + #13#10;
  Result := Result + 'Classificação numérica:   ' + Fclassificacao_numerica + #13#10;
  Result := Result + 'Classificação alfabética: ' + Fclassificacao_alfabetica + #13#10;
  Result := Result + 'Probabilidade:            ' + Fprobabilidade + #13#10;
  Result := Result + 'Texto:                    ' + Ftexto + #13#10;
  Result := Result + 'Código natureza modelo:   ' + Fcodigo_natureza_modelo + #13#10;
  Result := Result + 'Descrição natureza:       ' + Fdescricao_natureza + #13#10;
  Result := Result + 'Texto explicativo:        ' + Ftexto_explicativo + #13#10;
end;

{ TScores }

constructor TScores.Create;
begin
  inherited Create;
  Fscore_pj := TNodeInfoList.Create('TScore');
end;

destructor TScores.Destroy;
begin
  FreeAndNil(Fscore_pj);
  inherited;
end;

function TScores.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      SCORE                       ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '                     SCORE PJ                     ' + #13#10;
  For intIdx := 0 To Fscore_pj.Count - 1 Do
    Result := Result + Fscore_pj.Items[intIdx].fGetRelatorio();
end;

{ TPendenciaRestricao }

function TPendenciaRestricao.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Informante:               ' + Finformante + #13#10;
  Result := Result + 'Tipo:                     ' + Ftipo + #13#10;
  Result := Result + 'Local:                    ' + Flocal + #13#10;
  Result := Result + 'Documento origem:         ' + Fdocumento_origem + #13#10;
  Result := Result + 'Data débito:              ' + DateToStr(Fdata_debito) + #13#10;
  Result := Result + 'Disponível em:            ' + Fdisponivel_em + #13#10;
  Result := Result + 'Valor:                    ' + Fvalor + #13#10;
end;

{ TPendenciasRestricoes }

constructor TPendenciasRestricoes.Create;
begin
  inherited Create;
  Fultimas_ocorrencias := TNodeInfoList.Create('TPendenciaRestricao');
end;

destructor TPendenciasRestricoes.Destroy;
begin
  FreeAndNil(Fultimas_ocorrencias);
  inherited;
end;

function TPendenciasRestricoes.fGetDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := fCriaDataSet(AOwner);

  Result.Insert;
  Result.FieldByName('total_pendencias').AsString := Ftotal_pendencias;
  Result.FieldByName('total_credores').AsString   := Ftotal_credores;
  Result.FieldByName('valor').AsString            := Fvalor;
  Result.FieldByName('periodo').AsString          := Fperiodo;
  Result.FieldByName('valor_primeiro').AsString   := Fvalor_primeiro;
  Result.FieldByName('data_primeiro').AsString    := IIF(Fdata_primeiro=0,'-',DateToStr(Fdata_primeiro));
  Result.FieldByName('data_maior').AsString       := IIF(Fdata_maior=0,'-',DateToStr(Fdata_maior));
  Result.FieldByName('valor_maior').AsString      := Fvalor_maior;
  Result.FieldByName('mensagem').AsString         := Fmensagem;
  Result.Post;
end;

function TPendenciasRestricoes.fGetDataSetOcor(AOwner: TComponent): TUniClientDataSet;
var
  intIdx: Integer;
begin
  Result := fCriaDataSetOcor(AOwner);

  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
  Begin
    Result.Insert;
    Result.FieldByName('documento_origem').AsString := TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Fdocumento_origem;
    Result.FieldByName('local').AsString            := TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Flocal;
    Result.FieldByName('valor').AsString            := TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Fvalor;
    Result.FieldByName('informante').AsString       := TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Finformante;
    Result.FieldByName('data_debito').AsString      := IIF(TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Fdata_debito=0,'-',DateToStr(TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Fdata_debito));
    Result.FieldByName('tipo').AsString             := TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Ftipo;
    Result.FieldByName('disponivel_em').AsString    := TPendenciaRestricao(Fultimas_ocorrencias.Items[intIdx]).Fdisponivel_em;
    Result.Post;
  End;
end;

function TPendenciasRestricoes.fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor_maior';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_primeiro';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'periodo';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'total_pendencias';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor_primeiro';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'total_credores';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_maior';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'mensagem';
    DataType := ftString;
    Size     := 120;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TPendenciasRestricoes.fCriaDataSetOcor(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'documento_origem';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'local';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'informante';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_debito';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'tipo';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'disponivel_em';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TPendenciasRestricoes.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '             PENDÊNCIAS E RESTRIÇÕES              ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Total de pendências:      ' + Ftotal_pendencias + #13#10;
  Result := Result + 'Total de credores:        ' + Ftotal_credores + #13#10;
  Result := Result + 'Valor:                    ' + Fvalor + #13#10;
  Result := Result + 'Período:                  ' + Fperiodo + #13#10;
  Result := Result + 'Valor do primeiro:        ' + Fvalor_primeiro + #13#10;
  Result := Result + 'Data do primeiro:         ' + IIF(Fdata_primeiro=0,'-',DateToStr(Fdata_primeiro)) + #13#10;
  Result := Result + 'Valor do maior:           ' + Fvalor_maior + #13#10;
  Result := Result + 'Data do maior:            ' + IIF(Fdata_maior=0,'-',DateToStr(Fdata_maior)) + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '               ÚLTIMAS OCORRÊNCIAS                ' + #13#10;
  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
    Result := Result + Fultimas_ocorrencias.Items[intIdx].fGetRelatorio();
end;

{ TAcaoCivil }

function TAcaoCivil.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Requerido:                ' + Frequerido + #13#10;
  Result := Result + 'Ação:                     ' + Facao + #13#10;
  Result := Result + 'Documento:                ' + Fdocumento + #13#10;
  Result := Result + 'Foro UF:                  ' + Fforo_uf + #13#10;
  Result := Result + 'Vara:                     ' + Fvara + #13#10;
  Result := Result + 'Autor:                    ' + Fautor + #13#10;
  Result := Result + 'Processo:                 ' + Fprocesso + #13#10;
  Result := Result + 'Distribuição:             ' + Fdistribuicao + #13#10;
  Result := Result + 'Valor:                    ' + Fvalor + #13#10;
end;

{ TAcoesCiveis }

constructor TAcoesCiveis.Create;
begin
  inherited Create;
  Fultimas_ocorrencias := TNodeInfoList.Create('TAcaoCivil');
end;

destructor TAcoesCiveis.Destroy;
begin
  FreeAndNil(Fultimas_ocorrencias);
  inherited;
end;

function TAcoesCiveis.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                   AÇÕES CÍVEIS                   ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Total de ações:           ' + Ftotal_acoes + #13#10;
  Result := Result + 'Valor total:              ' + Fvalor_total + #13#10;
  Result := Result + 'Valor do primeiro:        ' + Fvalor_primeiro + #13#10;
  Result := Result + 'Data do primeiro:         ' + DateToStr(Fdata_primeiro) + #13#10;
  Result := Result + 'Valor do maior:           ' + Fvalor_maior + #13#10;
  Result := Result + 'Data do maior:            ' + DateToStr(Fdata_maior) + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '               ÚLTIMAS OCORRÊNCIAS                ' + #13#10;
  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
    Result := Result + Fultimas_ocorrencias.Items[intIdx].fGetRelatorio();
end;

{ TConsulta }

function TConsulta.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Data:                     ' + DateToStr(Fdata) + #13#10;
  Result := Result + 'Razão social:             ' + Frazao_social + #13#10;
  Result := Result + 'Cnpj:                     ' + Fcnpj + #13#10;
end;

{ TConsultas }

constructor TConsultas.Create;
begin
  inherited Create;
  Fultimas_consultas := TNodeInfoList.Create('TConsulta');
end;

destructor TConsultas.Destroy;
begin
  FreeAndNil(Fultimas_consultas);
  inherited;
end;

function TConsultas.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                    CONSULTAS                     ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Quantidade total:         ' + Fquantidade_total + #13#10;
  Result := Result + 'Período:                  ' + Fperiodo + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '                ÚLTIMAS CONSULTAS                 ' + #13#10;
  For intIdx := 0 To Fultimas_consultas.Count - 1 Do
    Result := Result + Fultimas_consultas.Items[intIdx].fGetRelatorio();
end;

{ TParticipacaoOutrasEmpresas }

function TParticipacaoOutrasEmpresas.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '         PARTICIPAÇÕES EM OUTRAS EMPRESAS         ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Razão social participada: ' + Frazao_social_participada + #13#10;
  Result := Result + 'Cnpj participada:         ' + Fcnpj_participada + #13#10;
  Result := Result + 'Situação Cnpj:            ' + Fsituacao_cnpj + #13#10;
  Result := Result + 'Participação:             ' + Fparticipacao + #13#10;
  Result := Result + 'Entrada:                  ' + DateToStr(Fentrada) + #13#10;
  Result := Result + 'Indicador de débito:      ' + Findicador_debito + #13#10;
  Result := Result + 'Indicador de fraude:      ' + Findicador_fraude + #13#10;
end;

{ TFalenciaRecuperacaoJudicial }

function TFalenciaRecuperacaoJudicial.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Tipo de ocorrência:       ' + Ftipo_ocorrencia + #13#10;
  Result := Result + 'Data:                     ' + DateToStr(Fdata) + #13#10;
  Result := Result + 'Cidade:                   ' + Fcidade + #13#10;
  Result := Result + 'Estado:                   ' + Fuf + #13#10;
  Result := Result + 'Vara:                     ' + Fvara + #13#10;
end;

{ TFalenciasRecuperacaoJudicial }

constructor TFalenciasRecuperacaoJudicial.Create;
begin
  inherited Create;
  Fultimas_ocorrencias := TNodeInfoList.Create('TFalenciaRecuperacaoJudicial');
end;

destructor TFalenciasRecuperacaoJudicial.Destroy;
begin
  FreeAndNil(Fultimas_ocorrencias);
  inherited;
end;

function TFalenciasRecuperacaoJudicial.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '        FALÊNCIAS E RECUPERAÇÕES JUDICIAIS        ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Quantidade total:         ' + Fquantidade_total + #13#10;
  Result := Result + 'Período:                  ' + Fperiodo + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '               ÚLTIMAS OCORRÊNCIAS                ' + #13#10;
  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
    Result := Result + Fultimas_ocorrencias.Items[intIdx].fGetRelatorio();
end;

{ TSocioCompleto }

function TSocioCompleto.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Nome da empresa:          ' + Fnome_empresa + #13#10;
  Result := Result + 'Cpf ou Cnpj:              ' + Fcpf_cnpj + #13#10;
  Result := Result + 'Situação do documento:    ' + Fsituacao_documento + #13#10;
  Result := Result + 'Participação:             ' + Fparticipacao + #13#10;
  Result := Result + 'Data da entrada:          ' + DateToStr(Fdata_entrada) + #13#10;
  Result := Result + 'Assina pela empresa:      ' + Fassina_empresa + #13#10;
  Result := Result + 'Indicador de débito:      ' + Findicador_debito + #13#10;
  Result := Result + 'Indicador de fraude:      ' + Findicador_fraude + #13#10;
end;

{ TSocios }

destructor TSocios.Destroy;
begin
  FreeAndNil(Fsocio_completo);
  inherited;
end;

function TSocios.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      SÓCIOS                      ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;

  If Fsocio_completo <> nil Then
  Begin
    Result := Result + '                  SÓCIO COMPLETO                  ' + #13#10;
    Result := Result + Fsocio_completo.fGetRelatorio();
  End;
end;

{ TRestricaoDocumento }

function TRestricaoDocumento.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Quantidade:               ' + Fquantidade + #13#10;
  Result := Result + 'Valor:                    ' + Fvalor + #13#10;
  Result := Result + 'Última:                   ' + DateToStr(Fultima) + #13#10;
end;

{ TRestricoesDocumento }

destructor TRestricoesDocumento.Destroy;
begin
  FreeAndNil(Fconsultas);
  FreeAndNil(Ftitulos_vencer);
  FreeAndNil(Fpagamentos);
  FreeAndNil(Fregistro_debitos);
  FreeAndNil(Fcheques_sem_fundo);
  FreeAndNil(Fcheques_sustado_motivo_21);
  FreeAndNil(Fprotestos);
  FreeAndNil(Fpendencias_restricoes);
  FreeAndNil(Frecuperacao_falencias);
  FreeAndNil(Ffalencias_empresariais);
  FreeAndNil(Facoes_judiciais);
  FreeAndNil(Fsocios_administradores);
  FreeAndNil(Foutras_participacoes);
  inherited;
end;

function TRestricoesDocumento.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '              RESTRIÇÕES DOCUMENTOS               ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  If Fconsultas <> nil Then
  Begin
    Result := Result + '                    CONSULTAS                     ' + #13#10;
    Result := Result + Fconsultas.fGetRelatorio();
  End;

  If Ftitulos_vencer <> nil Then
  Begin
    Result := Result + '                 TÍTULOS A VENCER                 ' + #13#10;
    Result := Result + Ftitulos_vencer.fGetRelatorio();
  End;

  If Fpagamentos <> nil Then
  Begin
    Result := Result + '                    PAGAMENTOS                    ' + #13#10;
    Result := Result + Fpagamentos.fGetRelatorio();
  End;

  If Fregistro_debitos <> nil Then
  Begin
    Result := Result + '               REGISTRO DE DÉBITOS                ' + #13#10;
    Result := Result + Fregistro_debitos.fGetRelatorio();
  End;

  If Fcheques_sem_fundo <> nil Then
  Begin
    Result := Result + '                CHEQUES SEM FUNDO                 ' + #13#10;
    Result := Result + Fcheques_sem_fundo.fGetRelatorio();
  End;

  If Fcheques_sustado_motivo_21 <> nil Then
  Begin
    Result := Result + '            CHEQUES SUSTADOS MOTIVO 21            ' + #13#10;
    Result := Result + Fcheques_sustado_motivo_21.fGetRelatorio();
  End;

  If Fprotestos <> nil Then
  Begin
    Result := Result + '                    PROTESTOS                     ' + #13#10;
    Result := Result + Fprotestos.fGetRelatorio();
  End;

  If Fpendencias_restricoes <> nil Then
  Begin
    Result := Result + '             PENDÊNCIAS E RESTRIÇÕES              ' + #13#10;
    Result := Result + Fpendencias_restricoes.fGetRelatorio();
  End;

  If Frecuperacao_falencias <> nil Then
  Begin
    Result := Result + '             RECUPERAÇÃO E FALÊNCIAS              ' + #13#10;
    Result := Result + Frecuperacao_falencias.fGetRelatorio();
  End;

  If Ffalencias_empresariais <> nil Then
  Begin
    Result := Result + '              FALÊNCIAS EMPRESARIAIS              ' + #13#10;
    Result := Result + Ffalencias_empresariais.fGetRelatorio();
  End;

  If Facoes_judiciais <> nil Then
  Begin
    Result := Result + '                 AÇÕES JUDICIAIS                  ' + #13#10;
    Result := Result + Facoes_judiciais.fGetRelatorio();
  End;

  If Fsocios_administradores <> nil Then
  Begin
    Result := Result + '             SÓCIOS E ADMINISTRADORES             ' + #13#10;
    Result := Result + Fsocios_administradores.fGetRelatorio();
  End;

  If Foutras_participacoes <> nil Then
  Begin
    Result := Result + '               OUTRAS PARTICIPAÇÕES               ' + #13#10;
    Result := Result + Foutras_participacoes.fGetRelatorio();
  End;
end;

{ TAdministrador }

destructor TAdministrador.Destroy;
begin
  FreeAndNil(Frestricoes_documento);
  inherited;
end;

function TAdministrador.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Nome:                     ' + Fnome + #13#10;
  Result := Result + 'Cpf:                      ' + Fcpf + #13#10;
  Result := Result + 'Data de entrada:          ' + DateToStr(Fentrada) + #13#10;
  Result := Result + 'Mandato:                  ' + Fmandato + #13#10;
  Result := Result + 'Cargo:                    ' + Fcargo + #13#10;
  Result := Result + 'Situação do Cpf:          ' + Fsituacao_cpf + #13#10;
  Result := Result + 'Indicador de débito:      ' + Findicador_debito + #13#10;
  Result := Result + 'Indicador de fraude:      ' + Findicador_fraude + #13#10;
  If (Frestricoes_documento <> nil) Then
    Result := Result + Frestricoes_documento.fGetRelatorio();
end;

{ TReferencialNegocio }

function TReferencialNegocio.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Data:                     ' + Fdata + #13#10;
  Result := Result + 'Valor:                    ' + Fvalor + #13#10;
  Result := Result + 'Média:                    ' + Fmedia + #13#10;
end;

{ TReferenciaisNegocios }

destructor TReferenciaisNegocios.Destroy;
begin
  FreeAndNil(Fultima_compra);
  FreeAndNil(Fmaior_fatura);
  FreeAndNil(Fmaior_credito);
  inherited;
end;

function TReferenciaisNegocios.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '             REFERENCIAIS DE NEGÓCIOS             ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  If Fultima_compra <> nil Then
  Begin
    Result := Result + '                  ÚLTIMA COMPRA                   ' + #13#10;
    Result := Result + Fultima_compra.fGetRelatorio();
  End;

  If Fmaior_fatura <> nil Then
  Begin
    Result := Result + '                   MAIOR FATURA                   ' + #13#10;
    Result := Result + Fmaior_fatura.fGetRelatorio();
  End;

  If Fmaior_credito <> nil Then
  Begin
    Result := Result + '                  MAIOR CRÉDITO                   ' + #13#10;
    Result := Result + Fmaior_credito.fGetRelatorio();
  End;
end;

{ TItemPainelControle }

function TItemPainelControle.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Quantidade:               ' + Fquantidade + #13#10;
  Result := Result + 'Data da última:           ' + IIF(Fdata_ultima=0,'-',DateToStr(Fdata_ultima)) + #13#10;
  Result := Result + 'Valor total:              ' + Fvalor_total + #13#10;
  Result := Result + 'flag decisão:             ' + Fflag_decisao + #13#10;
end;

{ TPainelControle }

destructor TPainelControle.Destroy;
begin
  FreeAndNil(Fregistro_debito);
  FreeAndNil(Fprotesto);
  FreeAndNil(Fcheque_sem_fundo);
  FreeAndNil(Fcheque_sustado);
  FreeAndNil(Fcheque_informado_usuario);
  FreeAndNil(Facoes_civeis);
  FreeAndNil(Frecuperacao);
  FreeAndNil(Ffalencia);
  FreeAndNil(Falerta_fraude);
  FreeAndNil(Fpendencias_restricoes);
  inherited;
end;

function TPainelControle.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                PAINEL DE CONTROLE                ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  If Fregistro_debito <> nil Then
  Begin
    Result := Result + '                REGISTRO DE DÉBITO                ' + #13#10;
    Result := Result + Fregistro_debito.fGetRelatorio();
  End;

  If protesto <> nil Then
  Begin
    Result := Result + '                     PROTESTO                     ' + #13#10;
    Result := Result + Fprotesto.fGetRelatorio();
  End;

  If cheque_sem_fundo <> nil Then
  Begin
    Result := Result + '                CHEQUES SEM FUNDO                 ' + #13#10;
    Result := Result + Fcheque_sem_fundo.fGetRelatorio();
  End;

  If cheque_sustado <> nil Then
  Begin
    Result := Result + '                 CHEQUES SUSTADOS                 ' + #13#10;
    Result := Result + Fcheque_sustado.fGetRelatorio();
  End;

  If cheque_informado_usuario <> nil Then
  Begin
    Result := Result + '             CHEQUE INFORMADO USUÁRIO             ' + #13#10;
    Result := Result + Fcheque_informado_usuario.fGetRelatorio();
  End;

  If acoes_civeis <> nil Then
  Begin
    Result := Result + '                   AÇÕES CÍVEIS                   ' + #13#10;
    Result := Result + Facoes_civeis.fGetRelatorio();
  End;

  If recuperacao <> nil Then
  Begin
    Result := Result + '                   RECUPERAÇÃO                    ' + #13#10;
    Result := Result + Frecuperacao.fGetRelatorio();
  End;

  If falencia <> nil Then
  Begin
    Result := Result + '                     FALÊNCIA                     ' + #13#10;
    Result := Result + Ffalencia.fGetRelatorio();
  End;

  If alerta_fraude <> nil Then
  Begin
    Result := Result + '                 ALERTA DE FRAUDE                 ' + #13#10;
    Result := Result + Falerta_fraude.fGetRelatorio();
  End;

  If pendencias_restricoes <> nil Then
  Begin
    Result := Result + '        PENDÊNCIAS E RESTRIÇÕES FINANCEIRAS       ' + #13#10;
    Result := Result + Fpendencias_restricoes.fGetRelatorio();
  End;
end;

function TPainelControle.fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'descricao';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'quantidade';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_ultima';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'valor_total';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'flag_decisao';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;

end;

function TPainelControle.fGetDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := fCriaDataSet(AOwner);

  If registro_debito <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Registros de Débito';
    Result.FieldByName('data_ultima').AsString  := IIF(Fregistro_debito.data_ultima=0,'-',DateToStr(Fregistro_debito.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Fregistro_debito.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Fregistro_debito.valor_total;
    Result.FieldByName('quantidade').AsString   := Fregistro_debito.quantidade;
    Result.Post;
  End;

  If protesto <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Protestos';
    Result.FieldByName('data_ultima').AsString  := IIF(Fprotesto.data_ultima=0,'-',DateToStr(Fprotesto.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Fprotesto.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Fprotesto.valor_total;
    Result.FieldByName('quantidade').AsString   := Fprotesto.quantidade;
    Result.Post;
  End;

  If cheque_sem_fundo <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Cheques sem fundo';
    Result.FieldByName('data_ultima').AsString  := IIF(Fcheque_sem_fundo.data_ultima=0,'-',DateToStr(Fcheque_sem_fundo.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Fcheque_sem_fundo.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Fcheque_sem_fundo.valor_total;
    Result.FieldByName('quantidade').AsString   := Fcheque_sem_fundo.quantidade;
    Result.Post;
  End;

  If cheque_sustado <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Cheques Sustados';
    Result.FieldByName('data_ultima').AsString  := IIF(Fcheque_sustado.data_ultima=0,'-',DateToStr(Fcheque_sustado.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Fcheque_sustado.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Fcheque_sustado.valor_total;
    Result.FieldByName('quantidade').AsString   := Fcheque_sustado.quantidade;
    Result.Post;
  End;

  If cheque_informado_usuario <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Cheques Informado Usuário';
    Result.FieldByName('data_ultima').AsString  := IIF(Fcheque_informado_usuario.data_ultima=0,'-',DateToStr(Fcheque_informado_usuario.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Fcheque_informado_usuario.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Fcheque_informado_usuario.valor_total;
    Result.FieldByName('quantidade').AsString   := Fcheque_informado_usuario.quantidade;
    Result.Post;
  End;

  If acoes_civeis <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Ações Cíveis';
    Result.FieldByName('data_ultima').AsString  := IIF(Facoes_civeis.data_ultima=0,'-',DateToStr(Facoes_civeis.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Facoes_civeis.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Facoes_civeis.valor_total;
    Result.FieldByName('quantidade').AsString   := Facoes_civeis.quantidade;
    Result.Post;
  End;

  If recuperacao <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Recuperação Judicial';
    Result.FieldByName('data_ultima').AsString  := IIF(Frecuperacao.data_ultima=0,'-',DateToStr(Frecuperacao.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Frecuperacao.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Frecuperacao.valor_total;
    Result.FieldByName('quantidade').AsString   := Frecuperacao.quantidade;
    Result.Post;
  End;

  If falencia <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Falências';
    Result.FieldByName('data_ultima').AsString  := IIF(Ffalencia.data_ultima=0,'-',DateToStr(Ffalencia.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Ffalencia.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Ffalencia.valor_total;
    Result.FieldByName('quantidade').AsString   := Ffalencia.quantidade;
    Result.Post;
  End;

  If alerta_fraude <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Falências';
    Result.FieldByName('data_ultima').AsString  := IIF(Falerta_fraude.data_ultima=0,'-',DateToStr(Falerta_fraude.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Falerta_fraude.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Falerta_fraude.valor_total;
    Result.FieldByName('quantidade').AsString   := Falerta_fraude.quantidade;
    Result.Post;
  End;

  If pendencias_restricoes <> nil Then
  Begin
    Result.Insert;
    Result.FieldByName('descricao').AsString    := 'Pendências e Restrições Financeiras';
    Result.FieldByName('data_ultima').AsString  := IIF(Fpendencias_restricoes.data_ultima=0,'-',DateToStr(Fpendencias_restricoes.data_ultima));
    Result.FieldByName('flag_decisao').AsString := Fpendencias_restricoes.flag_decisao;
    Result.FieldByName('valor_total').AsString  := Fpendencias_restricoes.valor_total;
    Result.FieldByName('quantidade').AsString   := Fpendencias_restricoes.quantidade;
    Result.Post;
  End;
end;

{ TItemValidacao }

function TItemValidacao.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Quantidade:               ' + Fquantidade + #13#10;
  Result := Result + 'Validação:                ' + Fvalidacao + #13#10;
  Result := Result + 'Flag decisão:             ' + Fflag_decisao + #13#10;
end;

{ TValidacoes }

destructor TValidacoes.Destroy;
begin
  FreeAndNil(Fsituacao_cnpj);
  FreeAndNil(Fdata_fundacao);
  FreeAndNil(Fsocios);
  FreeAndNil(Fadministradores);
  inherited;
end;

function TValidacoes.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                    VALIDAÇÕES                    ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  If Fsituacao_cnpj <> nil Then
  Begin
    Result := Result + '                  SITUACAO CNPJ                   ' + #13#10;
    Result := Result + Fsituacao_cnpj.fGetRelatorio();
  End;

  If Fdata_fundacao <> nil Then
  Begin
    Result := Result + '                  DATA FUNDAÇÃO                   ' + #13#10;
    Result := Result + Fdata_fundacao.fGetRelatorio();
  End;

  If Fsocios <> nil Then
  Begin
    Result := Result + '                      SÓCIOS                      ' + #13#10;
    Result := Result + Fsocios.fGetRelatorio();
  End;

  If Fadministradores <> nil Then
  Begin
    Result := Result + '                 ADMINISTRADORES                  ' + #13#10;
    Result := Result + Fadministradores.fGetRelatorio();
  End;

end;

{ TPreciso }

constructor TPreciso.Create;
begin
  inherited Create;
  Fadministradores := TNodeInfoList.Create('TAdministrador');
end;

destructor TPreciso.Destroy;
begin
  FreeAndNil(Fidentificacao_basico);
  FreeAndNil(Fidentificacao_completo);
  FreeAndNil(Flocalizacao_basico);
  FreeAndNil(Flocalizacao_completo);
  FreeAndNil(Falerta_faudes);
  FreeAndNil(Fcheques_sem_fundo);
  FreeAndNil(Fcheques_sustados);
  FreeAndNil(Fprotestos);
  FreeAndNil(Fscore);
  FreeAndNil(Fpendencias_restricoes);
  FreeAndNil(Facoes_civeis);
  FreeAndNil(Fconsultas);
  FreeAndNil(Fparticipacoes_em_outras_empresas);
  FreeAndNil(Ffalencias_recuperacao_judicial);
  FreeAndNil(Fsocios);
  FreeAndNil(Fadministradores);
  FreeAndNil(Freferenciais_negocios);
  FreeAndNil(Fpainel_controle);
  FreeAndNil(Fvalidacoes);
  FreeAndNil(Frestricoes_documento);
  inherited;
end;

function TPreciso.fGetQtdCheques: Integer;
var
  intIdx: Integer;
begin
  Result := 0;

  If (Fidentificacao_basico <> nil) Then
    Result := Result + Fidentificacao_basico.fGetQtdCheques();

  If (Fidentificacao_completo <> nil) Then
    Result := Result + Fidentificacao_completo.fGetQtdCheques();

  If (Flocalizacao_basico <> nil) Then
    Result := Result + Flocalizacao_basico.fGetQtdCheques();

  If (Flocalizacao_completo <> nil) Then
    Result := Result + Flocalizacao_completo.fGetQtdCheques();

  If (Falerta_faudes <> nil) Then
    Result := Result + Falerta_faudes.fGetQtdCheques();

  If (Fcheques_sem_fundo <> nil) Then
    Result := Result + Fcheques_sem_fundo.fGetQtdCheques();

  If (Fcheques_sustados <> nil) Then
    Result := Result + Fcheques_sustados.fGetQtdCheques();

  If (Fprotestos <> nil) Then
    Result := Result + Fprotestos.fGetQtdCheques();

  If (Fscore <> nil) Then
    Result := Result + Fscore.fGetQtdCheques();

  If (Fpendencias_restricoes <> nil) Then
    Result := Result + Fpendencias_restricoes.fGetQtdCheques();

  If (Facoes_civeis <> nil) Then
    Result := Result + Facoes_civeis.fGetQtdCheques();

  If (Fconsultas <> nil) Then
    Result := Result + Fconsultas.fGetQtdCheques();

  If (Fparticipacoes_em_outras_empresas <> nil) Then
    Result := Result + Fparticipacoes_em_outras_empresas.fGetQtdCheques();

  If (Ffalencias_recuperacao_judicial <> nil) Then
    Result := Result + Ffalencias_recuperacao_judicial.fGetQtdCheques();

  If (Fsocios <> nil) Then
    Result := Result + Fsocios.fGetQtdCheques();

  For intIdx := 0 To Fadministradores.Count - 1 Do
    Result := Result + Fadministradores.Items[intIdx].fGetQtdCheques();

  If (Freferenciais_negocios <> nil) Then
    Result := Result + Freferenciais_negocios.fGetQtdCheques();

  If (Fpainel_controle <> nil) Then
    Result := Result + Fpainel_controle.fGetQtdCheques();

  If (Fvalidacoes <> nil) Then
    Result := Result + Fvalidacoes.fGetQtdCheques();

  If (Frestricoes_documento <> nil) Then
    Result := Result + Frestricoes_documento.fGetQtdCheques();
end;

function TPreciso.fGetQtdProtestos: Integer;
var
  intIdx: Integer;
begin
  Result := 0;

  If (Fidentificacao_basico <> nil) Then
    Result := Result + Fidentificacao_basico.fGetQtdProtestos();

  If (Fidentificacao_completo <> nil) Then
    Result := Result + Fidentificacao_completo.fGetQtdProtestos();

  If (Flocalizacao_basico <> nil) Then
    Result := Result + Flocalizacao_basico.fGetQtdProtestos();

  If (Flocalizacao_completo <> nil) Then
    Result := Result + Flocalizacao_completo.fGetQtdProtestos();

  If (Falerta_faudes <> nil) Then
    Result := Result + Falerta_faudes.fGetQtdProtestos();

  If (Fcheques_sem_fundo <> nil) Then
    Result := Result + Fcheques_sem_fundo.fGetQtdProtestos();

  If (Fcheques_sustados <> nil) Then
    Result := Result + Fcheques_sustados.fGetQtdProtestos();

  If (Fprotestos <> nil) Then
    Result := Result + Fprotestos.fGetQtdProtestos();

  If (Fscore <> nil) Then
    Result := Result + Fscore.fGetQtdProtestos();

  If (Fpendencias_restricoes <> nil) Then
    Result := Result + Fpendencias_restricoes.fGetQtdProtestos();

  If (Facoes_civeis <> nil) Then
    Result := Result + Facoes_civeis.fGetQtdProtestos();

  If (Fconsultas <> nil) Then
    Result := Result + Fconsultas.fGetQtdProtestos();

  If (Fparticipacoes_em_outras_empresas <> nil) Then
    Result := Result + Fparticipacoes_em_outras_empresas.fGetQtdProtestos();

  If (Ffalencias_recuperacao_judicial <> nil) Then
    Result := Result + Ffalencias_recuperacao_judicial.fGetQtdProtestos();

  If (Fsocios <> nil) Then
    Result := Result + Fsocios.fGetQtdProtestos();

  For intIdx := 0 To Fadministradores.Count - 1 Do
    Result := Result + Fadministradores.Items[intIdx].fGetQtdProtestos();

  If (Freferenciais_negocios <> nil) Then
    Result := Result + Freferenciais_negocios.fGetQtdProtestos();

  If (Fpainel_controle <> nil) Then
    Result := Result + Fpainel_controle.fGetQtdProtestos();

  If (Fvalidacoes <> nil) Then
    Result := Result + Fvalidacoes.fGetQtdProtestos();

  If (Frestricoes_documento <> nil) Then
    Result := Result + Frestricoes_documento.fGetQtdProtestos();
end;

function TPreciso.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';

  If (Fidentificacao_basico <> nil) Then
    Result := Result + Fidentificacao_basico.fGetRelatorio();

  If (Fidentificacao_completo <> nil) Then
    Result := Result + Fidentificacao_completo.fGetRelatorio();

  If (Flocalizacao_basico <> nil) Then
    Result := Result + Flocalizacao_basico.fGetRelatorio();

  If (Flocalizacao_completo <> nil) Then
    Result := Result + Flocalizacao_completo.fGetRelatorio();

  If (Falerta_faudes <> nil) Then
    Result := Result + Falerta_faudes.fGetRelatorio();

  If (Fcheques_sem_fundo <> nil) Then
    Result := Result + Fcheques_sem_fundo.fGetRelatorio();

  If (Fcheques_sustados <> nil) Then
    Result := Result + Fcheques_sustados.fGetRelatorio();

  If (Fcheques_devolvidos_informados_usuario <> nil) Then
    Result := Result + Fcheques_devolvidos_informados_usuario.fGetRelatorio();

  If (Fprotestos <> nil) Then
    Result := Result + Fprotestos.fGetRelatorio();

  If (Fscore <> nil) Then
    Result := Result + Fscore.fGetRelatorio();

  If (Fpendencias_restricoes <> nil) Then
    Result := Result + Fpendencias_restricoes.fGetRelatorio();

  If (Facoes_civeis <> nil) Then
    Result := Result + Facoes_civeis.fGetRelatorio();

  If (Fconsultas <> nil) Then
    Result := Result + Fconsultas.fGetRelatorio();

  If (Fparticipacoes_em_outras_empresas <> nil) Then
    Result := Result + Fparticipacoes_em_outras_empresas.fGetRelatorio();

  If (Ffalencias_recuperacao_judicial <> nil) Then
    Result := Result + Ffalencias_recuperacao_judicial.fGetRelatorio();

  If (Fsocios <> nil) Then
    Result := Result + Fsocios.fGetRelatorio();

  If Fadministradores.Count > 0 Then
  Begin
    Result := Result + '--------------------------------------------------' + #13#10;
    Result := Result + '                 ADMINISTRADORES                  ' + #13#10;
    Result := Result + '--------------------------------------------------' + #13#10;
    For intIdx := 0 To Fadministradores.Count - 1 Do
      Result := Result + Fadministradores.Items[intIdx].fGetRelatorio();
  End;

  If (Freferenciais_negocios <> nil) Then
    Result := Result + Freferenciais_negocios.fGetRelatorio();

  If (Fpainel_controle <> nil) Then
    Result := Result + Fpainel_controle.fGetRelatorio();

  If (Fvalidacoes <> nil) Then
    Result := Result + Fvalidacoes.fGetRelatorio();

  If (Frestricoes_documento <> nil) Then
    Result := Result + Frestricoes_documento.fGetRelatorio();
end;

{ TConsultaSCPCBoaVistaES }

constructor TConsultaSCPCBoaVistaES.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FHTTP := TidHTTP.Create(Self);
  FHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
  FXmlRetorno := TXMLDocument.Create(Self);
  FErros      := TStringList.Create;
  FConsulta   := fCfgSis('INTBOV');
  If fEmptyStr(FConsulta) Then
    FConsulta := 'cadastral';

  FLogin := fCfgSis('LOGBVE');
  FSenha := fCfgSis('SENBVE');
  FLoginAutomatico := False;
end;

destructor TConsultaSCPCBoaVistaES.Destroy;
begin
  FreeAndNil(FHTTP);
  FreeAndNil(FXmlRetorno);
  FreeAndNil(FPreciso);
  FreeAndNil(FErros);
  inherited;
end;

function TConsultaSCPCBoaVistaES.fConsultaServico(strDocumento: String): Boolean;
Var
  strURL: String;
  xmlEnvio: IXMLDocument;
  stmBody: TStream;
begin
  Result := False;

  If Not FLoginAutomatico Then
  Begin
    FLogin := '';
    FSenha := '';
  End;

  If fEmptyStr(FLogin) Or fEmptyStr(FSenha) Then
  Begin
    If Not fInputQueryTipo('Boa Vista Serviços', 'Login:', FLogin, ttInteiro) Then
      Exit;

    If Not fInputQueryTipo('Boa Vista Serviços', 'Senha:', FSenha, ttAlfanumerico, '*') Then
      Exit;
  End;

  stmBody := TMemoryStream.Create();
  Try
    xmlEnvio := TXMLDocument.Create(Self);
    xmlEnvio.Active := True;
    xmlEnvio.Version := '1.0';
    xmlEnvio.Encoding := 'UTF-8';
    xmlEnvio.DocumentElement := xmlEnvio.CreateElement('entrada:precisoContratoEntradaXml', 'http://boavistaservicos.com.br/preciso/entrada');
    xmlEnvio.DocumentElement.AddChild('usuario').Text := FLogin;
    xmlEnvio.DocumentElement.AddChild('senha').Text   := FSenha;
    xmlEnvio.DocumentElement.AddChild('cnpj').Text    := strDocumento;
    xmlEnvio.DocumentElement.AddChild('consultas').AddChild('consulta').Text := FConsulta;
    xmlEnvio.DocumentElement.AddChild('opcionais').Text := '';
    xmlEnvio.DocumentElement.AddChild('extras').Text := '';
    xmlEnvio.DocumentElement.AddChild('complementos').Text := '';

    xmlEnvio.SaveToStream(stmBody);

    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [hoNoProtocolErrorException];
    strURL := 'https://commercial.bvsnet.com.br/ModularPjXmlWeb/servicos/relatorio/modularpj';
    FHTTP.Request.ContentType := 'application/xml';
    FXmlRetorno.LoadFromXML(FHTTP.Post(strURL, stmBody));

    If FHTTP.ResponseCode = 200 Then
      Result := True
    Else
    Begin
      FErros.Add('Ocorreu um erro imprevisto na consulta!');
      FErros.Add('Código do erro: ' + IntToStr(FHTTP.ResponseCode));
      FErros.Add('Descrição do erro: ' + FHTTP.ResponseText);
    End;
  Finally
    FreeAndNil(stmBody);
  End;
end;

function TConsultaSCPCBoaVistaES.fFindChildNode(node: IXmlNode;
  strChildNodeName: String): IXmlNode;
var
  childNode: IXmlNode;
  intIndex: Integer;
begin
  Result := nil;

  For intIndex := 0 to node.ChildNodes.Count - 1 Do
  Begin
    childNode := node.ChildNodes.get(intIndex);

    If (strChildNodeName = childNode.NodeName) Or
       EndsStr(':' + strChildNodeName, childNode.NodeName) Then
    Begin
      Result := childNode;
      Break;
    End;
  End;
end;

function TConsultaSCPCBoaVistaES.fGetMsgErro: String;
begin
  Result := FErros.Text;
end;

function TConsultaSCPCBoaVistaES.fGetQtdCheques: Integer;
begin
  Result := FPreciso.fGetQtdCheques();
end;

function TConsultaSCPCBoaVistaES.fGetQtdProtestos: Integer;
begin
  Result := FPreciso.fGetQtdProtestos();
end;

function TConsultaSCPCBoaVistaES.fGetRelatorio: String;
begin
  Result := FPreciso.fGetRelatorio();
end;

function TConsultaSCPCBoaVistaES.fParseErros(node: IXmlNode): Boolean;
var
  childNode: IXmlNode;
  intIndex: Integer;
begin
  If (fFindChildNode(node, 'mensagem_erro') <> nil) Then
  Begin
    For intIndex := 0 to node.ChildNodes.Count - 1 Do
    Begin
      childNode := node.ChildNodes.get(intIndex);

      If ('mensagem_erro' = childNode.NodeName) Or
         EndsStr(':mensagem_erro', childNode.NodeName) Then
        FErros.Add(childNode.NodeValue);
    End;

    Result := True;
  End
  Else
    Result := False;
end;

function TConsultaSCPCBoaVistaES.fParseNode(strNomeClasse: String; node: IXmlNode): TNodeInfo;
var
  classe: TClass;
  ctx: TRttiContext;
  tipo: TRttiType;
  propriedades: TArray<TRttiProperty>;
  propriedade: TRttiProperty;
begin
  classe := findClass(strNomeClasse);

  If (classe = nil) Or (node = nil) Then
  Begin
    Result := nil;
    Exit;
  End;

  Result := TNodeInfoClass(classe).Create;

  Try
    ctx := TRttiContext.Create;
    tipo := ctx.GetType(classe.ClassInfo);
    propriedades := tipo.GetProperties();

    For propriedade In propriedades Do
    Begin
      Case propriedade.PropertyType.TypeKind Of
        tkClass:
          If (propriedade.PropertyType.Name = 'TStrings') Then
            propriedade.SetValue(Result, fGetXmlChildValoresEmTStrings(fFindChildNode(node, propriedade.Name)))
          Else If propriedade.PropertyType.Name = 'TNodeInfoList' Then
            pAddChildNodes(TNodeInfoList(propriedade.GetValue(Result).AsObject), fFindChildNode(node, propriedade.Name))
          Else
            propriedade.SetValue(Result, fParseNode(propriedade.PropertyType.Name, fFindChildNode(node, propriedade.Name)));

        tkUnknown,
        tkVariant: propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node, propriedade.Name)));

        tkInteger,
        tkInt64:   propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node, propriedade.Name, varInteger)));

        tkChar,
        tkString,
        tkWChar,
        tkLString,
        tkWString,
        tkUString: propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node, propriedade.Name, varString)));

        tkFloat:
          If (propriedade.PropertyType.Name = 'TDate') Or
             (propriedade.PropertyType.Name = 'TTime') Or
             (propriedade.PropertyType.Name = 'TDateTime') Then
            propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node, propriedade.Name, varDate, 'd/m/y', '/')))
          Else
            propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node, propriedade.Name, varDouble)));
      End;
    End;
  Finally
    ctx.Free;
  End;
end;

function TConsultaSCPCBoaVistaES.fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;
begin
  {pMensagemOk('Rotina de Consulta SCPC pela Boa Vista - ES precisa ser homologada. Por favor, entrar em contato com a Citel.');
  Result := False;
  Exit;}

  FDocConsulta := strDocumento;
  FNomeEmpresa := strNomeEmpresa;
  FCidadeUF    := strCidade+'/'+strUF;
  FLoginAutomatico := blnSCPCAutomatico;

  If fConsultaServico(strDocumento) Then
  Begin
    If Not fParseErros(FXmlRetorno.ChildNodes.FindNode('preciso')) Then
    Begin
      FPreciso := TPreciso(fParseNode('TPreciso', FXmlRetorno.ChildNodes.FindNode('preciso')));
      Result := True;
    End
    Else
      Result := False;
  End
  Else
    Result := False;
end;

procedure TConsultaSCPCBoaVistaES.pAddChildNodes(lstList: TNodeInfoList;
  node: IXmlNode);
var
  intIndex: Integer;
  childNode: IXmlNode;
  objChild: TNodeInfo;
begin
  If node = nil Then
    Exit;

  For intIndex := 0 to node.ChildNodes.Count - 1 Do
  Begin
    childNode := node.ChildNodes.get(intIndex);
    objChild := fParseNode(lstList.getChildClassName, childNode);
    lstList.Add(objChild);
  End;
end;

procedure TConsultaSCPCBoaVistaES.pSaveToFile(const strFileName: String);
var
  stlTexto: TStringList;
begin
  If Not DirectoryExists(ExtractFilePath(strFileName)) Then
    fCriaDiretorio(ExtractFilePath(strFileName));

  stlTexto := TStringList.Create;
  stlTexto.Text := Self.fGetRelatorio;
  stlTexto.SaveToFile(strFileName);
  FreeAndNil(stlTexto);

  FXmlRetorno.SaveToFile(AnsiReplaceStr(strFileName,
    ExtractFileExt(strFileName), '.xml'));

  pSaveToPDF(AnsiReplaceStr(strFileName,
    ExtractFileExt(strFileName), '.pdf'));
end;

procedure TConsultaSCPCBoaVistaES.pSaveToPDF(const strFileName: String);
var
  dtaData : TDateTime;
  intAno, intMes, intDia : Word;
  strData : String;
begin
  If FConsulta <> 'restritivo' Then
    Exit;

  pCriarFormularios(TfrmQckConsultaSCPC,frmQckConsultaSCPC);
  with frmQckConsultaSCPC do
  begin
    dtaData := VS_Date + fTime();
    DecodeDate(dtaData, intAno, intMes, intDia);
    strData := FormatDateTime('dd.'+String(Copy(arrMes[intMes],0,3))+'.yy hh:mm:ss', dtaData);

    frxReport.PrintOptions.ShowDialog := False;
    TfrxMemoView(frxReport.FindObject('memCNPJ')).Text        := fFormataCpfCgc(FDocConsulta, fSetaPais);
    TfrxMemoView(frxReport.FindObject('memRazaoSocial')).Text := FNomeEmpresa;
    TfrxMemoView(frxReport.FindObject('memInfConf')).Text     := 'INFORMAÇÕES CONFIDENCIAIS - ' + FCidadeUF + ', ' + strData;

    frxPainel.DataSet         := FPreciso.Fpainel_controle.fGetDataSet(Self);

    frxRestricoes.DataSet     := FPreciso.Fpendencias_restricoes.fGetDataSet(Self);
    frxRestricoesOcor.DataSet := FPreciso.Fpendencias_restricoes.fGetDataSetOcor(Self);

    frxReport.FindObject('mdRestricoes').Visible     := fEmptyStr(FPreciso.Fpendencias_restricoes.mensagem);
    frxReport.FindObject('mdRestricoesOcor').Visible := fEmptyStr(FPreciso.Fpendencias_restricoes.mensagem);
    frxReport.FindObject('mdSemRestricoes').Visible  := Not fEmptyStr(FPreciso.Fpendencias_restricoes.mensagem);

    frxChqSemF.DataSet     := FPreciso.Fcheques_sem_fundo.fGetDataSet(Self);
    frxChqSemFOcor.DataSet := FPreciso.Fcheques_sem_fundo.fGetDataSetOcor(Self);

    frxReport.FindObject('mdChequeSemF').Visible     := fEmptyStr(FPreciso.Fcheques_sem_fundo.mensagem);
    frxReport.FindObject('mdChequeSemFOcor').Visible := fEmptyStr(FPreciso.Fcheques_sem_fundo.mensagem);
    frxReport.FindObject('mdSemChequeSemF').Visible  := Not fEmptyStr(FPreciso.Fcheques_sem_fundo.mensagem);

    frxChqSust.DataSet     := FPreciso.Fcheques_sustados.fGetDataSet(Self);
    frxChqSustOcor.DataSet := FPreciso.Fcheques_sustados.fGetDataSetOcor(Self);

    frxReport.FindObject('mdChequesSustados').Visible     := fEmptyStr(FPreciso.Fcheques_sustados.mensagem);
    frxReport.FindObject('mdChequesSustadosOcor').Visible := fEmptyStr(FPreciso.Fcheques_sustados.mensagem);
    frxReport.FindObject('mdSemChequesSustados').Visible  := Not fEmptyStr(FPreciso.Fcheques_sustados.mensagem);

    frxChqDevol.DataSet     := FPreciso.Fcheques_devolvidos_informados_usuario.fGetDataSet(Self);
    frxChqDevolOcor.DataSet := FPreciso.Fcheques_devolvidos_informados_usuario.fGetDataSetOcor(Self);

    frxReport.FindObject('mdChequesDevolvidos').Visible     := fEmptyStr(FPreciso.Fcheques_devolvidos_informados_usuario.mensagem);
    frxReport.FindObject('mdChequesDevolvidosOcor').Visible := fEmptyStr(FPreciso.Fcheques_devolvidos_informados_usuario.mensagem);
    frxReport.FindObject('mdSemChequesDevolvidos').Visible  := Not fEmptyStr(FPreciso.Fcheques_devolvidos_informados_usuario.mensagem);

    frxProtestos.DataSet     := FPreciso.Fprotestos.fGetDataSet(Self);
    frxProtestosOcor.DataSet := FPreciso.Fprotestos.fGetDataSetOcor(Self);

    frxReport.FindObject('mdProtestos').Visible     := fEmptyStr(FPreciso.Fprotestos.mensagem);
    frxReport.FindObject('mdProtestosOcor').Visible := fEmptyStr(FPreciso.Fprotestos.mensagem);
    frxReport.FindObject('mdSemProtestos').Visible  := Not fEmptyStr(FPreciso.Fprotestos.mensagem);

    If frxReport.PrepareReport Then
    Begin
      frxExpPDF.FileName    := strFileName;
      frxExpPDF.DefaultPath := ExtractFilePath(strFileName);
      frxExpPDF.ShowDialog  := False;
      frxReport.Export(frxExpPDF);
    End;
  end;

  FreeAndNil(frmQckConsultaSCPC);
end;

{ TChequeDevolvido }

function TChequeDevolvido.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Informante:               ' + Finformante + #13#10;
  Result := Result + 'Banco:                    ' + Fbanco + #13#10;
  Result := Result + 'Agência:                  ' + Fagencia + #13#10;
  Result := Result + 'Cheques:                  ' + Fcheques + #13#10;
  Result := Result + 'Motivo:                   ' + Fmotivo + #13#10;
  Result := Result + 'Cidade/UF:                ' + Fcidade_uf + #13#10;
  Result := Result + 'Data da ocorrência:       ' + DateToStr(Fdata_ocorrencia) + #13#10;
  Result := Result + 'Data do registro:         ' + DateToStr(Fdata_registro) + #13#10;
end;

{ TChequesDevolvidos }

constructor TChequesDevolvidos.Create;
begin
  inherited Create;
  Fultimas_ocorrencias := TNodeInfoList.Create('TChequeDevolvido');
end;

destructor TChequesDevolvidos.Destroy;
begin
  FreeAndNil(Fultimas_ocorrencias);
  inherited;
end;

function TChequesDevolvidos.fCriaDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'quantidade_total';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'periodo';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'mensagem';
    DataType := ftString;
    Size     := 120;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TChequesDevolvidos.fCriaDataSetOcor(
  AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'informante';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'banco';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'agencia';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'cheques';
    DataType := ftString;
    Size     := 80;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_ocorrencia';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'data_registro';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'motivo';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'cidade_uf';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

function TChequesDevolvidos.fGetDataSet(AOwner: TComponent): TUniClientDataSet;
begin
  Result := fCriaDataSet(AOwner);

  Result.Insert;
  Result.FieldByName('quantidade_total').AsString := Fquantidade_total;
  Result.FieldByName('periodo').AsString          := Fperiodo;
  Result.FieldByName('mensagem').AsString         := Fmensagem;
  Result.Post;
end;

function TChequesDevolvidos.fGetDataSetOcor(
  AOwner: TComponent): TUniClientDataSet;
var
  intIdx: Integer;
begin
  Result := fCriaDataSetOcor(AOwner);

  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
  Begin
    Result.Insert;
    Result.FieldByName('banco').AsString           := TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fbanco;
    Result.FieldByName('agencia').AsString         := TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fagencia;
    Result.FieldByName('cheques').AsString         := TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fcheques;
    Result.FieldByName('informante').AsString      := TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Finformante;
    Result.FieldByName('motivo').AsString          := TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fmotivo;
    Result.FieldByName('cidade_uf').AsString       := TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fcidade_uf;
    Result.FieldByName('data_ocorrencia').AsString := IIF(TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fdata_ocorrencia=0,'-',DateToStr(TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fdata_ocorrencia));
    Result.FieldByName('data_registro').AsString   := IIF(TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fdata_registro=0,'-',DateToStr(TChequeDevolvido(Fultimas_ocorrencias.Items[intIdx]).Fdata_registro));
    Result.Post;
  End;
end;

function TChequesDevolvidos.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '    CHEQUES DEVOLVIDOS INFORMADOS PELO USUÁRIO    ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Total:                    ' + Fquantidade_total + #13#10;
  Result := Result + 'Período:                  ' + Fperiodo + #13#10;
  Result := Result + 'Mensagem:                 ' + Fmensagem + #13#10;
  Result := Result + '               ÚLTIMAS OCORRÊNCIAS                ' + #13#10;
  For intIdx := 0 To Fultimas_ocorrencias.Count - 1 Do
    Result := Result + Fultimas_ocorrencias.Items[intIdx].fGetRelatorio();
end;

initialization

  RegisterClasses([
    TIdentificacaoBasico,
    TIdentificacaoCompleto,
    TLocalizacaoBasico,
    TMatriz,
    TFilial,
    TLocalizacaoCompleto,
    TAlertaFraudes,
    TChequeSemFundo,
    TChequesSemFundo,
    TChequeSustado,
    TChequesSustados,
    TChequeDevolvido,
    TChequesDevolvidos,
    TProtesto,
    TProtestos,
    TScore,
    TScores,
    TPendenciaRestricao,
    TPendenciasRestricoes,
    TAcaoCivil,
    TAcoesCiveis,
    TConsulta,
    TConsultas,
    TParticipacaoOutrasEmpresas,
    TFalenciaRecuperacaoJudicial,
    TFalenciasRecuperacaoJudicial,
    TSocioCompleto,
    TSocios,
    TAdministrador,
    TItemPainelControle,
    TReferencialNegocio,
    TReferenciaisNegocios,
    TPainelControle,
    TItemValidacao,
    TValidacoes,
    TRestricaoDocumento,
    TRestricoesDocumento,
    TPreciso
  ]);

end.
