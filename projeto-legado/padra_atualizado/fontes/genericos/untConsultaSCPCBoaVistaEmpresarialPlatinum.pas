unit untConsultaSCPCBoaVistaEmpresarialPlatinum;

interface

uses
  Classes, XMLDoc, XMLIntf, System.SysUtils, System.Rtti, System.StrUtils, ShellAPi, Windows,
  System.Generics.Collections, idHTTP, IdSSLOpenSSL, EditFocus, untConsultaSCPC,
  untQckConsultaSCPCEmpresarialPlatinum, frxClass, UniClientDataSet, Data.DB, Vcl.Forms,
  System.DateUtils;

type
  TPNodeInfo = class(TPersistent)
  public
    constructor Create; virtual;
    function fGetRelatorio: String; virtual; abstract;
    function fGetQtdProtestos: Integer; virtual;
    function fGetQtdCheques: Integer; virtual;
  end;

  TPNodeInfoClass = class of TPNodeInfo;

  TPNodeInfoList = class(TObjectList<TPNodeInfo>)
  private
    FstrChildClassName: String;
  public
    constructor Create(strChildClassName: String); reintroduce;
    function getChildClassName(): String;
  end;

  TPNodeInfoLista = class(TPNodeInfoList)
  end;

  TPDataValor = Class(TPNodeInfo)
  private
    FData: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String  Read FData  Write FData;
    property valor: String Read FValor Write FValor;
  end;

  TPEmpresa = Class(TPNodeInfo)
  private
    FMarcador: String;
    FCnpj_participada: String;
    FRazao_social_participada: String;
    FParticipacao: String;
    FData_entrada: String;
    FCnpj_participante: String;
    FCpf_participante: String;
    FCapital: String;
  public
    function fGetRelatorio: String; override;
  published
    property Marcador: String                 Read FMarcador                 Write FMarcador;
    property Cnpj_participada: String         Read FCnpj_participada         Write FCnpj_participada;
    property Razao_social_participada: String Read FRazao_social_participada Write FRazao_social_participada;
    property Participacao: String             Read FParticipacao             Write FParticipacao;
    property Data_entrada: String             Read FData_entrada             Write FData_entrada;
    property Cnpj_participante: String        Read FCnpj_participante        Write FCnpj_participante;
    property Cpf_participante: String         Read FCpf_participante         Write FCpf_participante;
    property Capital: String                  Read FCapital                  Write FCapital;
  End;

  TPExtraParticipacoes = Class(TPNodeInfo)
  private
    FQtd_outras_participacoes: String;
    FEmpresa: TPNodeInfoList;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Qtd_outras_participacoes: String Read FQtd_outras_participacoes  Write FQtd_outras_participacoes;
    property Empresa: TPNodeInfoList          Read FEmpresa                   Write FEmpresa;
    property Mensagem: String                 Read FMensagem                  Write FMensagem;
  end;

  TPAnaliseSetorial = Class(TPNodeInfo)
  private
    Fsegmento: String;
    Fmensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property segmento: String Read Fsegmento Write Fsegmento;
    property mensagem: String Read Fmensagem Write Fmensagem;
  end;

  TPHistoricoSacado = Class(TPNodeInfo)
  private
    FMes_e_ano: String;
    FTitulo_maior_valor: String;
    FTitulo_maior_valor_atraso: String;
    FValor_medio_titulos: String;
    FValor_medio_titulos_atrasados: String;
    FDesvio_padrao_medio_titulos: String;
    FDesvio_padrao_medio_titulos_atrasados: String;
    FNumero_medio_papeis: String;
    FNumero_medio_papeis_atrasados: String;
    FResponsabilidade_media_global: String;
    FResponsabilidade_media_global_atrasada: String;
    FMaior_prazo_contratado_titulos: String;
    FMaior_atraso_titulos_vencidos: String;
    FPrazo_medio_titulos_ser: String;
    FAtraso_medio_titulos_vencidos: String;
    FNumero_factorings: String;
    FPrazo_medio_ponderado: String;
    FAtraso_medio_ponderado: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_e_ano: String                              Read FMes_e_ano                                  Write FMes_e_ano;
    property Titulo_maior_valor: String                     Read FTitulo_maior_valor                         Write FTitulo_maior_valor;
    property Titulo_maior_valor_atraso: String              Read FTitulo_maior_valor_atraso                  Write FTitulo_maior_valor_atraso;
    property Valor_medio_titulos: String                    Read FValor_medio_titulos                        Write FValor_medio_titulos;
    property Valor_medio_titulos_atrasados: String          Read FValor_medio_titulos_atrasados              Write FValor_medio_titulos_atrasados;
    property Desvio_padrao_medio_titulos: String            Read FDesvio_padrao_medio_titulos                Write FDesvio_padrao_medio_titulos;
    property Desvio_padrao_medio_titulos_atrasados: String  Read FDesvio_padrao_medio_titulos_atrasados      Write FDesvio_padrao_medio_titulos_atrasados;
    property Numero_medio_papeis: String                    Read FNumero_medio_papeis                        Write FNumero_medio_papeis;
    property Numero_medio_papeis_atrasados: String          Read FNumero_medio_papeis_atrasados              Write FNumero_medio_papeis_atrasados;
    property Responsabilidade_media_global: String          Read FResponsabilidade_media_global              Write FResponsabilidade_media_global;
    property Responsabilidade_media_global_atrasada: String Read FResponsabilidade_media_global_atrasada     Write FResponsabilidade_media_global_atrasada;
    property Maior_prazo_contratado_titulos: String         Read FMaior_prazo_contratado_titulos             Write FMaior_prazo_contratado_titulos;
    property Maior_atraso_titulos_vencidos: String          Read FMaior_atraso_titulos_vencidos              Write FMaior_atraso_titulos_vencidos;
    property Prazo_medio_titulos_ser: String                Read FPrazo_medio_titulos_ser                    Write FPrazo_medio_titulos_ser;
    property Atraso_medio_titulos_vencidos: String          Read FAtraso_medio_titulos_vencidos              Write FAtraso_medio_titulos_vencidos;
    property Numero_factorings: String                      Read FNumero_factorings                          Write FNumero_factorings;
    property Prazo_medio_ponderado: String                  Read FPrazo_medio_ponderado                      Write FPrazo_medio_ponderado;
    property Atraso_medio_ponderado: String                 Read FAtraso_medio_ponderado                     Write FAtraso_medio_ponderado;
  end;

  TPHistoricoCedente = Class(TPNodeInfo)
  private
    FMes_e_ano: String;
    FTitulo_maior_valor: String;
    FTitulo_maior_valor_atraso: String;
    FValor_medio_titulos: String;
    FValor_medio_titulos_atrasados: String;
    FDesvio_padrao_medio_titulos: String;
    FDesvio_padrao_medio_titulos_atrasados: String;
    FNumero_medio_papeis: String;
    FNumero_medio_papeis_atrasados: String;
    FResponsabilidade_media_global: String;
    FResponsabilidade_media_global_atrasada: String;
    FMaior_prazo_contratado_titulos: String;
    FMaior_atraso_titulos_vencidos: String;
    FPrazo_medio_titulos_ser: String;
    FAtraso_medio_titulos_vencidos: String;
    FNumero_factorings: String;
    FPrazo_medio_ponderado: String;
    FAtraso_medio_ponderado: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_e_ano: String                              Read FMes_e_ano                              Write FMes_e_ano;
    property Titulo_maior_valor: String                     Read FTitulo_maior_valor                     Write FTitulo_maior_valor;
    property Titulo_maior_valor_atraso: String              Read FTitulo_maior_valor_atraso              Write FTitulo_maior_valor_atraso;
    property Valor_medio_titulos: String                    Read FValor_medio_titulos                    Write FValor_medio_titulos;
    property Valor_medio_titulos_atrasados: String          Read FValor_medio_titulos_atrasados          Write FValor_medio_titulos_atrasados;
    property Desvio_padrao_medio_titulos: String            Read FDesvio_padrao_medio_titulos            Write FDesvio_padrao_medio_titulos;
    property Desvio_padrao_medio_titulos_atrasados: String  Read FDesvio_padrao_medio_titulos_atrasados  Write FDesvio_padrao_medio_titulos_atrasados;
    property Numero_medio_papeis: String                    Read FNumero_medio_papeis                    Write FNumero_medio_papeis;
    property Numero_medio_papeis_atrasados: String          Read FNumero_medio_papeis_atrasados          Write FNumero_medio_papeis_atrasados;
    property Responsabilidade_media_global: String          Read FResponsabilidade_media_global          Write FResponsabilidade_media_global;
    property Responsabilidade_media_global_atrasada: String Read FResponsabilidade_media_global_atrasada Write FResponsabilidade_media_global_atrasada;
    property Maior_prazo_contratado_titulos: String         Read FMaior_prazo_contratado_titulos         Write FMaior_prazo_contratado_titulos;
    property Naior_atraso_titulos_vencidos: String          Read FMaior_atraso_titulos_vencidos          Write FMaior_atraso_titulos_vencidos;
    property Prazo_medio_titulos_ser: String                Read FPrazo_medio_titulos_ser                Write FPrazo_medio_titulos_ser;
    property Atraso_medio_titulos_vencidos: String          Read FAtraso_medio_titulos_vencidos          Write FAtraso_medio_titulos_vencidos;
    property Numero_factorings: String                      Read FNumero_factorings                      Write FNumero_factorings;
    property Prazo_medio_ponderado: String                  Read FPrazo_medio_ponderado                  Write FPrazo_medio_ponderado;
    property Atraso_medio_ponderado: String                 Read FAtraso_medio_ponderado                 Write FAtraso_medio_ponderado;
  end;

  TPSacadoOutros = Class(TPNodeInfo)
  private
    FNumero_factorings_total: String;
    FNumero_titulos_total: String;
    FValor_total: String;
    FTotal_sacado_total: String;
    FNumero_factorings_a_vencer: String;
    FNumero_titulos_a_vencer: String;
    FValor_a_vencer: String;
    FTotal_sacado_a_vencer: String;
    FNumero_factorings_ate_10_dias: String;
    FNumero_titulos_ate_10_dias: String;
    FValor_ate_10_dias: String;
    FTotal_sacado_ate_10_dias: String;
    FNumero_factorings_ate_30_dias: String;
    FNumero_titulos_ate_30_dias: String;
    FValor_ate_30_dias: String;
    FTotal_sacado_ate_30_dias: String;
    FNumero_factorings_mais_30_dias: String;
    FNumero_titulos_mais_30_dias: String;
    FValor_mais_30_dias: String;
    FTotal_sacado_mais_30_dias: String;
  public
    function fGetRelatorio: String; override;
  published
    property Numero_factorings_total: String        Read FNumero_factorings_total        Write FNumero_factorings_total;
    property Numero_titulos_total: String           Read FNumero_titulos_total           Write FNumero_titulos_total;
    property Valor_total: String                    Read FValor_total                    Write FValor_total;
    property Total_sacado_total: String             Read FTotal_sacado_total             Write FTotal_sacado_total;
    property Numero_factorings_a_vencer: String     Read FNumero_factorings_a_vencer     Write FNumero_factorings_a_vencer;
    property Numero_titulos_a_vencer: String        Read FNumero_titulos_a_vencer        Write FNumero_titulos_a_vencer;
    property Valor_a_vencer: String                 Read FValor_a_vencer                 Write FValor_a_vencer;
    property Total_sacado_a_vencer: String          Read FTotal_sacado_a_vencer          Write FTotal_sacado_a_vencer;
    property Numero_factorings_ate_10_dias: String  Read FNumero_factorings_ate_10_dias  Write FNumero_factorings_ate_10_dias;
    property Numero_titulos_ate_10_dias: String     Read FNumero_titulos_ate_10_dias     Write FNumero_titulos_ate_10_dias;
    property Valor_ate_10_dias: String              Read FValor_ate_10_dias              Write FValor_ate_10_dias;
    property Total_sacado_ate_10_dias: String       Read FTotal_sacado_ate_10_dias       Write FTotal_sacado_ate_10_dias;
    property Numero_factorings_ate_30_dias: String  Read FNumero_factorings_ate_30_dias  Write FNumero_factorings_ate_30_dias;
    property Numero_titulos_ate_30_dias: String     Read FNumero_titulos_ate_30_dias     Write FNumero_titulos_ate_30_dias;
    property Valor_ate_30_dias: String              Read FValor_ate_30_dias              Write FValor_ate_30_dias;
    property Total_sacado_ate_30_dias: String       Read FTotal_sacado_ate_30_dias       Write FTotal_sacado_ate_30_dias;
    property Numero_factorings_mais_30_dias: String Read FNumero_factorings_mais_30_dias Write FNumero_factorings_mais_30_dias;
    property Numero_titulos_mais_30_dias: String    Read FNumero_titulos_mais_30_dias    Write FNumero_titulos_mais_30_dias;
    property Valor_mais_30_dias: String             Read FValor_mais_30_dias             Write FValor_mais_30_dias;
    property Total_sacado_mais_30_dias: String      Read FTotal_sacado_mais_30_dias      Write FTotal_sacado_mais_30_dias;
  end;

  TPSacadoCasa = Class(TPNodeInfo)
  private
    FNumero_titulos_total: String;
    FValor_total: String;
    FNumero_titulos_a_vencer: String;
    FValor_a_vencer: String;
    FNumero_titulos_ate_10_dias: String;
    FValor_ate_10_dias: String;
    FNumero_titulos_ate_30_dias: String;
    FValor_ate_30_dias: String;
    FNumero_titulos_mais_30_dias: String;
    FValor_mais_30_dias: String;
  public
    function fGetRelatorio: String; override;
  published
    property Numero_titulos_total: String        Read FNumero_titulos_total        Write FNumero_titulos_total;
    property Valor_total: String                 Read FValor_total                 Write FValor_total;
    property Numero_titulos_a_vencer: String     Read FNumero_titulos_a_vencer     Write FNumero_titulos_a_vencer;
    property Valor_a_vencer: String              Read FValor_a_vencer              Write FValor_a_vencer;
    property Numero_titulos_ate_10_dias: String  Read FNumero_titulos_ate_10_dias  Write FNumero_titulos_ate_10_dias;
    property Valor_ate_10_dias: String           Read FValor_ate_10_dias           Write FValor_ate_10_dias;
    property Numero_titulos_ate_30_dias: String  Read FNumero_titulos_ate_30_dias  Write FNumero_titulos_ate_30_dias;
    property Valor_ate_30_dias: String           Read FValor_ate_30_dias           Write FValor_ate_30_dias;
    property Numero_titulos_mais_30_dias: String Read FNumero_titulos_mais_30_dias Write FNumero_titulos_mais_30_dias;
    property Valor_mais_30_dias: String          Read FValor_mais_30_dias          Write FValor_mais_30_dias;
  end;

  TPCedenteOutros = Class(TPNodeInfo)
  private
    FNumero_factorings_total: String;
    FNumero_titulos_total: String;
    FValor_total: String;
    FTotal_cedente_total: String;
    FNumero_factorings_a_vencer: String;
    FNumero_titulos_a_vencer: String;
    FValor_a_vencer: String;
    FTotal_cedente_a_vencer: String;
    FNumero_factorings_ate_10_dias: String;
    FNumero_titulos_ate_10_dias: String;
    FValor_ate_10_dias: String;
    FTotal_cedente_ate_10_dias: String;
    FNumero_factorings_ate_30_dias: String;
    FNumero_titulos_ate_30_dias: String;
    FValor_ate_30_dias: String;
    FTotal_cedente_ate_30_dias: String;
    FNumero_factorings_mais_30_dias: String;
    FNumero_titulos_mais_30_dias: String;
    FValor_mais_30_dias: String;
    FTotal_cedente_mais_30_dias: String;
  public
    function fGetRelatorio: String; override;
  published
    property Numero_factorings_total: String        Read FNumero_factorings_total        Write FNumero_factorings_total;
    property Numero_titulos_total: String           Read FNumero_titulos_total           Write FNumero_titulos_total;
    property Valor_total: String                    Read FValor_total                    Write FValor_total;
    property Total_cedente_total: String            Read FTotal_cedente_total            Write FTotal_cedente_total;
    property Numero_factorings_a_vencer: String     Read FNumero_factorings_a_vencer     Write FNumero_factorings_a_vencer;
    property Numero_titulos_a_vencer: String        Read FNumero_titulos_a_vencer        Write FNumero_titulos_a_vencer;
    property Valor_a_vencer: String                 Read FValor_a_vencer                 Write FValor_a_vencer;
    property Total_cedente_a_vencer: String         Read FTotal_cedente_a_vencer         Write FTotal_cedente_a_vencer;
    property Numero_factorings_ate_10_dias: String  Read FNumero_factorings_ate_10_dias  Write FNumero_factorings_ate_10_dias;
    property Numero_titulos_ate_10_dias: String     Read FNumero_titulos_ate_10_dias     Write FNumero_titulos_ate_10_dias;
    property Valor_ate_10_dias: String              Read FValor_ate_10_dias              Write FValor_ate_10_dias;
    property Total_cedente_ate_10_dias: String      Read FTotal_cedente_ate_10_dias      Write FTotal_cedente_ate_10_dias;
    property Numero_factorings_ate_30_dias: String  Read FNumero_factorings_ate_30_dias  Write FNumero_factorings_ate_30_dias;
    property Numero_titulos_ate_30_dias: String     Read FNumero_titulos_ate_30_dias     Write FNumero_titulos_ate_30_dias;
    property Valor_ate_30_dias: String              Read FValor_ate_30_dias              Write FValor_ate_30_dias;
    property Total_cedente_ate_30_dias: String      Read FTotal_cedente_ate_30_dias      Write FTotal_cedente_ate_30_dias;
    property Numero_factorings_mais_30_dias: String Read FNumero_factorings_mais_30_dias Write FNumero_factorings_mais_30_dias;
    property Numero_titulos_mais_30_dias: String    Read FNumero_titulos_mais_30_dias    Write FNumero_titulos_mais_30_dias;
    property Valor_mais_30_dias: String             Read FValor_mais_30_dias             Write FValor_mais_30_dias;
    property Total_cedente_mais_30_dias: String     Read FTotal_cedente_mais_30_dias     Write FTotal_cedente_mais_30_dias;
  end;

  TPCedenteCasa = Class(TPNodeInfo)
  private
    FNumero_titulos_total: String;
    FValor_total: String;
    FNumero_titulos_a_vencer: String;
    FValor_a_vencer: String;
    FNumero_titulos_ate_10_dias: String;
    FValor_ate_10_dias: String;
    FNumero_titulos_ate_30_dias: String;
    FValor_ate_30_dias: String;
    FNumero_titulos_mais_30_dias: String;
    FValor_mais_30_dias: String;
  public
    function fGetRelatorio: String; override;
  published
    property Numero_titulos_total: String        Read FNumero_titulos_total        Write FNumero_titulos_total;
    property Valor_total: String                 Read FValor_total                 Write FValor_total;
    property Numero_titulos_a_vencer: String     Read FNumero_titulos_a_vencer     Write FNumero_titulos_a_vencer;
    property Valor_a_vencer: String              Read FValor_a_vencer              Write FValor_a_vencer;
    property Numero_titulos_ate_10_dias: String  Read FNumero_titulos_ate_10_dias  Write FNumero_titulos_ate_10_dias;
    property Valor_ate_10_dias: String           Read FValor_ate_10_dias           Write FValor_ate_10_dias;
    property Numero_titulos_ate_30_dias: String  Read FNumero_titulos_ate_30_dias  Write FNumero_titulos_ate_30_dias;
    property Valor_ate_30_dias: String           Read FValor_ate_30_dias           Write FValor_ate_30_dias;
    property Numero_titulos_mais_30_dias: String Read FNumero_titulos_mais_30_dias Write FNumero_titulos_mais_30_dias;
    property Valor_mais_30_dias: String          Read FValor_mais_30_dias          Write FValor_mais_30_dias;
  end;

  TPFactor = Class(TPNodeInfo)
  private
    FCedente_casa: TPCedenteCasa;
    FCedente_outros: TPCedenteOutros;
    FSacado_casa: TPSacadoCasa;
    FSacado_outros: TPSacadoOutros;
    FHistorico_como_cedente: TPHistoricoCedente;
    FHistorico_como_sacado: TPHistoricoSacado;
  public
    function fGetRelatorio: String; override;
  published
    property Cedente_casa: TPCedenteCasa                Read FCedente_casa           Write FCedente_casa;
    property Cedente_outros: TPCedenteOutros            Read FCedente_outros         Write FCedente_outros;
    property Sacado_casa: TPSacadoCasa                  Read FSacado_casa            Write FSacado_casa;
    property Sacado_outros: TPSacadoOutros              Read FSacado_outros          Write FSacado_outros;
    property Historico_como_cedente: TPHistoricoCedente Read FHistorico_como_cedente Write FHistorico_como_cedente;
    property Historico_como_sacado: TPHistoricoSacado   Read FHistorico_como_sacado  Write FHistorico_como_sacado;
  end;

  TPSegIdentificacao = Class(TPNodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FUltima_remessa_enviada: String;
    FUltimo_processamento_grupo: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cnpj: String                       Read FCnpj                       Write FCnpj;
    property Razao_social: String               Read FRazao_social               Write FRazao_social;
    property Ultima_remessa_enviada: String     Read FUltima_remessa_enviada     Write FUltima_remessa_enviada;
    property Ultimo_processamento_grupo: String Read FUltimo_processamento_grupo Write FUltimo_processamento_grupo;
  end;

  TPConsultasGrupo = Class(TPNodeInfo)
  private
    FTtotal_consultas: String;
    FMes_ate_dia_anterior: String;
    FTotal_1mes_atras: String;
    FTotal_2meses_atras: String;
    FTotal_3meses_atras: String;
    FTotal_4meses_atras: String;
    FTotal_5meses_atras: String;
    FTotal_6meses_atras: String;
    FTotal_7meses_atras: String;
    FTotal_8meses_atras: String;
    FTotal_9meses_atras: String;
    FTotal_10meses_atras: String;
    FTotal_11meses_atras: String;
  public
    function fGetRelatorio: String; override;
  published
    property Total_consultas: String      Read FTtotal_consultas     Write FTtotal_consultas;
    property Mes_ate_dia_anterior: String Read FMes_ate_dia_anterior Write FMes_ate_dia_anterior;
    property Total_1mes_atras: String     Read FTotal_1mes_atras     Write FTotal_1mes_atras;
    property Total_2meses_atras: String   Read FTotal_2meses_atras   Write FTotal_2meses_atras;
    property Total_3meses_atras: String   Read FTotal_3meses_atras   Write FTotal_3meses_atras;
    property Total_4meses_atras: String   Read FTotal_4meses_atras   Write FTotal_4meses_atras;
    property Total_5meses_atras: String   Read FTotal_5meses_atras   Write FTotal_5meses_atras;
    property Total_6meses_atras: String   Read FTotal_6meses_atras   Write FTotal_6meses_atras;
    property Total_7meses_atras: String   Read FTotal_7meses_atras   Write FTotal_7meses_atras;
    property Total_8meses_atras: String   Read FTotal_8meses_atras   Write FTotal_8meses_atras;
    property Total_9meses_atras: String   Read FTotal_9meses_atras   Write FTotal_9meses_atras;
    property Total_10meses_atras: String  Read FTotal_10meses_atras  Write FTotal_10meses_atras;
    property Total_11meses_atras: String  Read FTotal_11meses_atras  Write FTotal_11meses_atras;
  end;

  TPTitulosEmAberto = Class(TPNodeInfo)
  private
    FVencido: String;
    FA_vencer: String;
    FEm_aberto: String;
  public
    function fGetRelatorio: String; override;
  published
    property Vencido: String   Read FVencido   Write FVencido;
    property A_vencer: String  Read FA_vencer  Write FA_vencer;
    property Em_aberto: String Read FEm_aberto Write FEm_aberto;
  end;

  TPTitulosPagos = Class(TPNodeInfo)
  private
    FA_vista: String;
    FPontual: String;
    FAtraso: String;
  public
    function fGetRelatorio: String; override;
  published
    property A_vista: String Read FA_vista Write FA_vista;
    property Pontual: String Read FPontual Write FPontual;
    property Atraso: String  Read FAtraso  Write FAtraso;
  end;

  TPPagosEmAberto = Class(TPNodeInfo)
  private
    FTitulos_pagos: TPTitulosPagos;
    FTitulos_em_aberto: TPTitulosEmAberto;
    FMaior_compra: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_pagos: TPTitulosPagos        Read FTitulos_pagos     Write FTitulos_pagos;
    property Titulos_em_aberto: TPTitulosEmAberto Read FTitulos_em_aberto Write FTitulos_em_aberto;
    property Maior_compra: String                 Read FMaior_compra      Write FMaior_compra;
  end;

  TPClassificacaoRanking = Class(TPNodeInfo)
  private
    FTitulos_em_aberto_ranking: TPTitulosEmAberto;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_ranking: TPTitulosEmAberto Read FTitulos_em_aberto_ranking Write FTitulos_em_aberto_ranking;
  end;

  TPTitulosAbertoAV = Class(TPNodeInfo)
  private
    FTitulos_em_aberto_a_vencer: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_a_vencer: String Read FTitulos_em_aberto_a_vencer Write FTitulos_em_aberto_a_vencer;
  end;

  TPComprometimentoFuturo = Class(TPNodeInfo)
  private
    FTitulos_em_aberto_a_vencer: String;
    FTitulos_em_aberto_em_aberto: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_a_vencer: String  Read FTitulos_em_aberto_a_vencer  Write FTitulos_em_aberto_a_vencer;
    property Titulos_em_aberto_em_aberto: String Read FTitulos_em_aberto_em_aberto Write FTitulos_em_aberto_em_aberto;
  end;

  TPMediaCredito = Class(TPNodeInfo)
  private
    FTitulos_em_aberto_em_aberto: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_em_aberto: String Read FTitulos_em_aberto_em_aberto Write FTitulos_em_aberto_em_aberto;
  end;

  TPTotalComportamento = Class(TPNodeInfo)
  private
    FTitulos_pagos: TPTitulosPagos;
    FTitulos_em_aberto: TPTitulosEmAberto;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_pagos: TPTitulosPagos        Read FTitulos_pagos     Write FTitulos_pagos;
    property Titulos_em_aberto: TPTitulosEmAberto Read FTitulos_em_aberto Write FTitulos_em_aberto;
  end;

  TPMediaDiasComportamento = Class(TPNodeInfo)
  private
    FTitulos_pagos_atraso: String;
    FTitulos_aberto_vencido: String;
    FTitulos_aberto_a_vencer: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_pagos_atraso: String    Read FTitulos_pagos_atraso    Write FTitulos_pagos_atraso;
    property Titulos_aberto_vencido: String  Read FTitulos_aberto_vencido  Write FTitulos_aberto_vencido;
    property Titulos_aberto_a_vencer: String Read FTitulos_aberto_a_vencer Write FTitulos_aberto_a_vencer;
  end;

  TPComportamentoPagamentos = Class(TPNodeInfo)
  private
    FClassificacao_ranking: TPClassificacaoRanking;
    FTitulos_em_aberto_ranking: TPTitulosEmAberto;
    FDt_atual_menos_5m_1ano_dt_atual_menos_5m: TPPagosEmAberto;
    FData_atual_menos_4meses: TPPagosEmAberto;
    FData_atual_menos_3meses: TPPagosEmAberto;
    FData_atual_menos_2meses: TPPagosEmAberto;
    FData_atual_menos_1mes: TPPagosEmAberto;
    FData_atual: TPPagosEmAberto;
    FData_atual_mais_1mes: TPTitulosAbertoAV;
    FData_atual_mais_2meses: TPTitulosAbertoAV;
    FData_atual_mais_3meses: TPTitulosAbertoAV;
    FComprometimento_futuro: TPComprometimentoFuturo;
    FTotal_comportamento: TPTotalComportamento;
    FMedia_credito_concedido: TPMediaCredito;
    FTtotal_titulos_comportamento: TPPagosEmAberto;
    FMedia_titulos_comportamento: TPPagosEmAberto;
    FMedia_dias_comportamento: TPMediaDiasComportamento;
    FTipo_periodo: String;
  public
    function fGetRelatorio: String; override;
  published
    property Classificacao_ranking: TPClassificacaoRanking             Read FClassificacao_ranking                    Write FClassificacao_ranking;
    property Titulos_em_aberto_ranking: TPTitulosEmAberto             Read FTitulos_em_aberto_ranking                Write FTitulos_em_aberto_ranking;
    property Dt_atual_menos_5m_1ano_dt_atual_menos_5m: TPPagosEmAberto Read FDt_atual_menos_5m_1ano_dt_atual_menos_5m Write FDt_atual_menos_5m_1ano_dt_atual_menos_5m;
    property Data_atual_menos_4meses: TPPagosEmAberto                  Read FData_atual_menos_4meses                  Write FData_atual_menos_4meses;
    property Data_atual_menos_3meses: TPPagosEmAberto                  Read FData_atual_menos_3meses                  Write FData_atual_menos_3meses;
    property Data_atual_menos_2meses: TPPagosEmAberto                  Read FData_atual_menos_2meses                  Write FData_atual_menos_2meses;
    property Data_atual_menos_1mes: TPPagosEmAberto                    Read FData_atual_menos_1mes                    Write FData_atual_menos_1mes;
    property Data_atual: TPPagosEmAberto                               Read FData_atual                               Write FData_atual;
    property Data_atual_mais_1mes: TPTitulosAbertoAV                   Read FData_atual_mais_1mes                     Write FData_atual_mais_1mes;
    property Data_atual_mais_2meses: TPTitulosAbertoAV                 Read FData_atual_mais_2meses                   Write FData_atual_mais_2meses;
    property Data_atual_mais_3meses: TPTitulosAbertoAV                 Read FData_atual_mais_3meses                   Write FData_atual_mais_3meses;
    property Comprometimento_futuro: TPComprometimentoFuturo           Read FComprometimento_futuro                   Write FComprometimento_futuro;
    property Total_comportamento: TPTotalComportamento                 Read FTotal_comportamento                      Write FTotal_comportamento;
    property Media_credito_concedido: TPMediaCredito                   Read FMedia_credito_concedido                  Write FMedia_credito_concedido;
    property Total_titulos_comportamento: TPPagosEmAberto              Read FTtotal_titulos_comportamento             Write FTtotal_titulos_comportamento;
    property Media_titulos_comportamento: TPPagosEmAberto              Read FMedia_titulos_comportamento              Write FMedia_titulos_comportamento;
    property Media_dias_comportamento: TPMediaDiasComportamento        Read FMedia_dias_comportamento                 Write FMedia_dias_comportamento;
    property Tipo_periodo: String                                      Read FTipo_periodo                             Write FTipo_periodo;
  end;

  TPEmpresaGrupo = Class(TPNodeInfo)
  private
    FSegmento_grupo: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Segmento_grupo: String Read FSegmento_grupo Write FSegmento_grupo;
    property Quantidade: String     Read FQuantidade     Write FQuantidade;
  end;

  TPEmpresasGrupo = Class(TPNodeInfo)
  private
    FEmpresa_grupo: TPNodeInfoList; // TPEmpresaGrupo
    FQtd_total: String;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Empresa_grupo: TPNodeInfoList Read FEmpresa_grupo Write FEmpresa_grupo;
    property Qtd_total: String             Read FQtd_total     Write FQtd_total;
    property Mensagem: String              Read FMensagem      Write FMensagem;
  end;

  TPSegmentoEmpresarial = Class(TPNodeInfo)
  private
    FNomeGrupo: String;
    FIdentificacao: TPSegIdentificacao;
    FConsultas_grupo: TPConsultasGrupo;
    FComportamento_pagamentos_grupo: TPComportamentoPagamentos;
    FEmpresas_grupo_registrando_sobre_cnpj: TPEmpresasGrupo;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property NomeGrupo: String                                         Read FNomeGrupo                             Write FNomeGrupo;
    property Identificacao: TPSegIdentificacao                         Read FIdentificacao                         Write FIdentificacao;
    property Consultas_grupo: TPConsultasGrupo                         Read FConsultas_grupo                       Write FConsultas_grupo;
    property Comportamento_pagamentos_grupo: TPComportamentoPagamentos Read FComportamento_pagamentos_grupo        Write FComportamento_pagamentos_grupo;
    property Empresas_grupo_registrando_sobre_cnpj: TPEmpresasGrupo    Read FEmpresas_grupo_registrando_sobre_cnpj Write FEmpresas_grupo_registrando_sobre_cnpj;
    property Mensagem: String                                          Read FMensagem                              Write FMensagem;
  end;

  TPInformacao = Class(TPNodeInfo)
  private
    FMes_ano: String;
    FTipo_informacao: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_ano: String         Read FMes_ano         Write FMes_ano;
    property Tipo_informacao: String Read FTipo_informacao Write FTipo_informacao;
  end;

  TPInformacoesRecentes = Class(TPNodeInfo)
  private
    FInformacao: TPNodeInfoLista; // TPInformacao;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Informacao: TPNodeInfoLista Read FInformacao Write FInformacao;
    property Mensagem: String            Read FMensagem   Write FMensagem;
  end;

  TPInformacoesComplementares = Class(TPNodeInfo)
  private
    FInformacao: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Informacao: String Read FInformacao Write FInformacao;
    property Mensagem: String   Read FMensagem   Write FMensagem;
  end;

  TPInconsistencia = Class(TPNodeInfo)
  private
    FNome: String;
    FCpf: String;
    FRazao_social: String;
    FCnpj: String;
    FTipo_pessoa: String;
  public
    function fGetRelatorio: String; override;
  published
    property Nome: String         Read FNome         Write FNome;
    property Cpf: String          Read FCpf          Write FCpf;
    property Razao_social: String Read FRazao_social Write FRazao_social;
    property Cnpj: String         Read FCnpj         Write FCnpj;
    property Tipo_pessoa: String  Read FTipo_pessoa  Write FTipo_pessoa;
  end;

  TPInconsistencias = Class(TPNodeInfo)
  private
    FInconsistencia: TPNodeInfoLista; // TPInconsistencia
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Inconsistencia: TPNodeInfoLista Read FInconsistencia Write FInconsistencia;
    property Mensagem: String                Read FMensagem       Write FMensagem;
  end;

  TPInadimplencia = Class(TPNodeInfo)
  private
    FNome: String;
    FCpf: String;
    FRazao_social: String;
    FCnpj: String;
    FTipo_pessoa: String;
  published
    property Nome: String         Read FNome         Write FNome;
    property Cpf: String          Read FCpf          Write FCpf;
    property Razao_social: String Read FRazao_social Write FRazao_social;
    property Cnpj: String         Read FCnpj         Write FCnpj;
    property Tipo_pessoa: String  Read FTipo_pessoa  Write FTipo_pessoa;
  end;

  TPInadimplencias = Class(TPNodeInfo)
  private
    FInadimplencia: TPNodeInfoLista; // TPInadimplencia
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Inadimplencia: TPNodeInfoLista Read FInadimplencia  Write FInadimplencia;
    property Mensagem: String               Read FMensagem       Write FMensagem;
  end;

  TPVara = Class(TPNodeInfo)
  private
    FNumero: String;
    FUf: String;
    FCidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Numero: String Read FNumero Write FNumero;
    property Uf: String     Read FUf     Write FUf;
    property Cidade: String Read FCidade Write FCidade;
  end;

  TPRecuperacaoFalencia = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FTipo_acao: String;
    FData_ultima_ocorrencia: String;
    FVara: TPVara;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String             Read FQuantidade             Write FQuantidade;
    property Tipo_acao: String              Read FTipo_acao              Write FTipo_acao;
    property Data_ultima_ocorrencia: String Read FData_ultima_ocorrencia Write FData_ultima_ocorrencia;
    property Vara: TPVara                   Read FVara                   Write FVara;
    property Mensagem: String               Read FMensagem               Write FMensagem;
  end;

  TPRecuperacoesFalencias = Class(TPNodeInfo)
  private
    FRecuperacaoFalenciaAcao: TPNodeInfoList; // TPRecuperacaoFalencia;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Recuperacao_Falencia_Acao: TPNodeInfoList  Read FRecuperacaoFalenciaAcao Write FRecuperacaoFalenciaAcao;
  end;

  TPExtraProtestos = Class(TPNodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FProtestos: TPNodeInfoList;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Cnpj: String              Read FCnpj         Write FCnpj;
    property Razao_social: String      Read FRazao_social Write FRazao_social;
    property Protestos: TPNodeInfoList Read FProtestos    Write FProtestos;
  end;

  TPTotalProtesto = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Valor: String      Read FValor      Write FValor;
  end;

  TPCartorio = Class(TPNodeInfo)
  private
    FNumero_cartorio: String;
    FCidade: String;
    FEstado: String;
  public
    function fGetRelatorio: String; override;
  published
    property numero_cartorio: String Read FNumero_cartorio Write FNumero_cartorio;
    property cidade: String          Read FCidade          Write FCidade;
    property estado: String          Read FEstado          Write FEstado;
  end;

  TPProtesto = Class(TPNodeInfo)
  private
    FData: String;
    FCartorio: TPCartorio;
    FValor: String;
    FCartorioDet: String;

    function fGetCartorio: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String         Read FData        Write FData;
    property Cartorio: TPCartorio Read FCartorio    Write FCartorio;
    property CartorioDet: String  Read fGetCartorio Write FCartorioDet;
    property Valor: String        Read FValor       Write FValor;
  end;

  TPProtestoPF = Class(TPNodeInfo)
  private
    FData: String;
    FCartorio: String;
    FCidade: String;
    FUF: String;
    FValor: String;
  public

  published
    property Data: String         Read FData        Write FData;
    property Cartorio: String     Read FCartorio    Write FCartorio;
    property Cidade: String       Read FCidade      Write FCidade;
    property UF: String           Read FUF          Write FUF;
    property Valor: String        Read FValor       Write FValor;
  end;

  TPResumoPF = Class(TPNodeInfo)
  private
    FQtdTotal: String;
    FDataUltimo: String;
    FValorTotal: String;
  public

  published
    property qtd_total: String         Read FQtdTotal        Write FQtdTotal;
    property data_ultimo: String       Read FDataUltimo      Write FDataUltimo;
    property valor_total: String       Read FValorTotal      Write FValorTotal;
  end;

  TPProtestosPF = Class(TPNodeInfo)
  private
    FResumo: TPResumoPF;
    FTotal: TPTotalProtesto;
    FPrimeiro: TPDataValor;
    FMaior: TPDataValor;
    FUltimasOcorrencias: TPNodeInfoList; // TPProtestoPF
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Resumo: TPResumoPF                   Read FResumo              Write FResumo;
    property Total: TPTotalProtesto               Read FTotal               Write FTotal;
    property Primeiro: TPDataValor                Read FPrimeiro            Write FPrimeiro;
    property Maior: TPDataValor                   Read FMaior               Write FMaior;
    property Ultimas_Ocorrencias: TPNodeInfoList  Read FUltimasOcorrencias  Write FUltimasOcorrencias;
    property Mensagem: String                     Read FMensagem            Write FMensagem;
  End;

  TPProtestos = Class(TPNodeInfo)
  private
    FTotal: TPTotalProtesto;
    FPrimeiro_protesto: TPDataValor;
    FMaior_protesto: TPDataValor;
    FLista_protestos: TPNodeInfoList; // TPProtesto
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total: TPTotalProtesto          Read FTotal             Write FTotal;
    property Primeiro_protesto: TPDataValor  Read FPrimeiro_protesto Write FPrimeiro_protesto;
    property Maior_protesto: TPDataValor     Read FMaior_protesto    Write FMaior_protesto;
    property Lista_protestos: TPNodeInfoList Read FLista_protestos   Write FLista_protestos;
    property Mensagem: String                Read FMensagem          Write FMensagem;
  End;

  TPChequeSemFundo = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FData: String;
    FNome_banco: String;
    FAgencia: String;
    FMotivo: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Data: String       Read FData       Write FData;
    property Nome_banco: String Read FNome_banco Write FNome_banco;
    property Agencia: String    Read FAgencia    Write FAgencia;
    property Motivo: String     Read FMotivo     Write FMotivo;
  End;

  TResumoCF = Class(TPNodeInfo)
  private
    FQtdTotal: String;
    FDataUltimo: String;
  public
  published
    property Qtd_Total: String        Read FQtdTotal   Write FQtdTotal;
    property Data_Ultimo: String      Read FDataUltimo Write FDataUltimo;
  End;

  TPChequeSemFundoPF = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FDataUltimo: String;
    FBanco: String;
    FAgencia: String;
    FMotivo: String;
  public
  published
    property Quantidade:  String Read FQuantidade Write FQuantidade;
    property Data_ultimo: String Read FDataUltimo Write FDataUltimo;
    property Banco:       String Read FBanco      Write FBanco;
    property Agencia:     String Read FAgencia    Write FAgencia;
    property Motivo:      String Read FMotivo     Write FMotivo;
  end;

  TPChequesSemFundoPF = Class(TPNodeInfo)
  private
    FResumo: TResumoCF;
    FTotalCheques: String;
    FDataUltimo: String;
    FUltimasOcorrencias: TPNodeInfoList; // TPChequeSemFundoPF
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Resumo: TResumoCF                    Read FResumo              Write FResumo;
    property Total_Cheques: String                Read FTotalCheques        Write FTotalCheques;
    property Data_Ultimo: String                  Read FDataUltimo          Write FDataUltimo;
    property Ultimas_Ocorrencias: TPNodeInfoList  Read FUltimasOcorrencias  Write FUltimasOcorrencias;
    property Mensagem_Informativa: String         Read FMensagem            Write FMensagem;
  End;

  TPChequesSemFundo = Class(TPNodeInfo)
  private
    FTotal_cheques: String;
    FCheque_sem_fundo: TPNodeInfoLista; // TPChequeSemFundo
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total_cheques: String             Read FTotal_cheques    Write FTotal_cheques;
    property Cheque_sem_fundo: TPNodeInfoLista Read FCheque_sem_fundo Write FCheque_sem_fundo;
    property Mensagem: String                  Read FMensagem         Write FMensagem;
  End;

  TPChequeSustado = Class(TPNodeInfo)
  private
    FData: String;
    FNome_banco: String;
    FAgencia: String;
    FCheques: String;
    FDataOcorrencia: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String           Read FData           Write FData;
    property Nome_banco: String     Read FNome_banco     Write FNome_banco;
    property Agencia: String        Read FAgencia        Write FAgencia;
    property Cheques: String        Read FCheques        Write FCheques;
    property DataOcorrencia: String Read FDataOcorrencia Write FDataOcorrencia;
    property Mensagem: String       Read FMensagem       Write FMensagem;
  End;

  TPChequesSustados = Class(TPNodeInfo)
  private
    FTotal_cheques: String;
    FCheque_sustado: TPNodeInfoLista; // TPChequeSustado
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total_cheques: String           Read FTotal_cheques  Write FTotal_cheques;
    property Cheque_sustado: TPNodeInfoLista Read FCheque_sustado Write FCheque_sustado;
    property Mensagem: String                Read FMensagem       Write FMensagem;
  End;

  TPPendencia = Class(TPNodeInfo)
  private
    FData: String;
    FCredor: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String   Read FData   Write FData;
    property Credor: String Read FCredor Write FCredor;
    property Valor: String  Read FValor  Write FValor;
  end;

  TPTotalPendencias = Class(TPNodeInfo)
  private
    FQtd_pendencias: String;
    FQtd_credores: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Qtd_pendencias: String Read FQtd_pendencias Write FQtd_pendencias;
    property Qtd_credores: String   Read FQtd_credores   Write FQtd_credores;
    property Valor: String          Read FValor          Write FValor;
  end;

  TPPendenciasRestricoes = Class(TPNodeInfo)
  private
    FTotal_pendencias: TPTotalPendencias;
    FPrimeira_pendencia: TPDataValor;
    FMaior_pendencia: TPDataValor;
    FLista_pendencias_restricoes: TPNodeInfoList; // TPPendencia
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total_pendencias: TPTotalPendencias         Read FTotal_pendencias            Write FTotal_pendencias;
    property Primeira_pendencia: TPDataValor             Read FPrimeira_pendencia          Write FPrimeira_pendencia;
    property Maior_pendencia: TPDataValor                Read FMaior_pendencia             Write FMaior_pendencia;
    property Lista_pendencias_restricoes: TPNodeInfoList Read FLista_pendencias_restricoes Write FLista_pendencias_restricoes;
    property Mensagem: String                            Read FMensagem                    Write FMensagem;
  end;

  TPExtraPendencias = Class(TPNodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FPendencias_restricoes: TPPendenciasRestricoes;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cnpj: String                                  Read FCnpj                  Write FCnpj;
    property Razao_social: String                          Read FRazao_social          Write FRazao_social;
    property Pendencias_restricoes: TPPendenciasRestricoes Read FPendencias_restricoes Write FPendencias_restricoes;
    property Mensagem: String                              Read FMensagem              Write FMensagem;
  end;

  TPCnae = Class(TPNodeInfo)
  private
    FDescricao: String;
    FCodigo: String;
  public
    function fGetRelatorio: String; override;
  published
    property Descricao: String Read FDescricao Write FDescricao;
    property Codigo: String    Read FCodigo    Write FCodigo;
  end;

  TPFornecedor = Class(TPNodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FCnae: TPCnae;
  public
    function fGetRelatorio: String; override;
  published
    property Cnpj: String         Read FCnpj         Write FCnpj;
    property Razao_social: String Read FRazao_social Write FRazao_social;
    property Cnae: TPCnae         Read FCnae         Write FCnae;
  end;

  TPPrincipaisFornecedores = Class(TPNodeInfo)
  private
    FData: String;
    FFornecedor: TPNodeInfoLista;
    FMensagem: String;
  public
    constructor Create; override; //TPFornecedor
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Data: String                Read FData       Write FData;
    property Fornecedor: TPNodeInfoLista Read FFornecedor Write FFornecedor;
    property Mensagem: String            Read FMensagem   Write FMensagem;
  end;

  TPReferencialNegocio = Class(TPNodeInfo)
  private
    FData: String;
    FValor: String;
    FMedia: String;
    FDescricao: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String  Read FData  Write FData;
    property Valor: String Read FValor Write FValor;
    property Media: String Read FMedia Write FMedia;
    property Descricao: String Read FDescricao Write FDescricao;
  end;

  TPReferenciaisNegocios = Class(TPNodeInfo)
  private
    FUltima_compra: TPReferencialNegocio;
    FMaior_fatura: TPReferencialNegocio;
    FMaior_credito: TPReferencialNegocio;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property ultima_compra: TPReferencialNegocio Read FUltima_compra  Write FUltima_compra;
    property maior_fatura: TPReferencialNegocio  Read FMaior_fatura   Write FMaior_fatura;
    property maior_credito: TPReferencialNegocio Read FMaior_credito  Write FMaior_credito;
    property mensagem: String                    Read FMensagem       Write FMensagem;
  End;

  TPItemHistorico = Class(TPNodeInfo)
  private
    FTotal: String;
    FFornecedores: String;
    FTitulos: String;
    FValor_total: String;
    FA_vista: String;
    FPontual: String;
    FDias_atraso_1: String;
    FDias_atraso_2: String;
    FDias_atraso_3: String;
    Fdias_atraso_4: String;
    FAtraso_medio: String;
  public
    function fGetRelatorio: String; override;
  published
    property Total: String         Read FTotal         Write FTotal;
    property Fornecedores: String  Read FFornecedores  Write FFornecedores;
    property Titulos: String       Read FTitulos       Write FTitulos;
    property Valor_total: String   Read FValor_total   Write FValor_total;
    property A_vista: String       Read FA_vista       Write FA_vista;
    property Pontual: String       Read FPontual       Write FPontual;
    property Dias_atraso_1: String Read FDias_atraso_1 Write FDias_atraso_1;
    property Dias_atraso_2: String Read FDias_atraso_2 Write FDias_atraso_2;
    property Dias_atraso_3: String Read FDias_atraso_3 Write FDias_atraso_3;
    property Dias_atraso_4: String Read Fdias_atraso_4 Write Fdias_atraso_4;
    property Atraso_medio: String  Read FAtraso_medio  Write FAtraso_medio;
  End;

  TPHistoricoPagamentos = Class(TPNodeInfo)
  private
    FItem: TPNodeInfoLista; //TPItemHistorico
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Item: TPNodeInfoLista Read FItem     Write FItem;
    property Mensagem: String      Read FMensagem Write FMensagem;
  End;

  TPTempoRelFornecedores = Class(TPNodeInfo)
  private
    FQtd_fontes_consultadas: String;
    FQtd_ate_6_meses: String;
    FQtd_de_7_a_12_meses: String;
    FQtd_de_1_a_2_anos: String;
    FQtd_de_3_a_5_anos: String;
    FQtd_de_6_a_10_anos: String;
    FQtd_mais_de_10_anos: String;
  public
    function fGetRelatorio: String; override;
  published
    property Qtd_fontes_consultadas: String Read FQtd_fontes_consultadas  Write FQtd_fontes_consultadas;
    property Qtd_ate_6_meses: String        Read FQtd_ate_6_meses         Write FQtd_ate_6_meses;
    property Qtd_de_7_a_12_meses: String    Read FQtd_de_7_a_12_meses     Write FQtd_de_7_a_12_meses;
    property Qtd_de_1_a_2_anos: String      Read FQtd_de_1_a_2_anos       Write FQtd_de_1_a_2_anos;
    property Qtd_de_3_a_5_anos: String      Read FQtd_de_3_a_5_anos       Write FQtd_de_3_a_5_anos;
    property Qtd_de_6_a_10_anos: String     Read FQtd_de_6_a_10_anos      Write FQtd_de_6_a_10_anos;
    property Qtd_mais_de_10_anos: String    Read FQtd_mais_de_10_anos     Write FQtd_mais_de_10_anos;
  End;

  TPTituloAVencer = Class(TPNodeInfo)
  private
    FPeriodo: String;
    FQtd_fornecedores: String;
    FQtd_titulos: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Periodo: String          Read FPeriodo          Write FPeriodo;
    property Qtd_fornecedores: String Read FQtd_fornecedores Write FQtd_fornecedores;
    property Qtd_titulos: String      Read FQtd_titulos      Write FQtd_titulos;
    property Valor: String            Read FValor            Write FValor;
  End;

  TPConsulta = Class(TPNodeInfo)
  private
    FData: String;
    FEmpresa: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String       Read FData       Write FData;
    property Empresa: String    Read FEmpresa    Write FEmpresa;
    property Quantidade: String Read FQuantidade Write FQuantidade;
  End;

  TPConsultaMes = Class(TPNodeInfo)
  private
    FMes_ano: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_ano: String    Read FMes_ano    Write FMes_ano;
    property Quantidade: String Read FQuantidade Write FQuantidade;
  End;

  TPAteDataAnterior = Class(TPNodeInfo)
  private
    FData_anterior: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data_anterior: String Read FData_anterior Write FData_anterior;
    property Quantidade: String    Read FQuantidade    Write FQuantidade;
  End;

  TPConsultas = Class(TPNodeInfo)
  private
    FQuantidade_total: String;
    FAte_data_anterior: TPAteDataAnterior;
    Fconsultas_mes: TPNodeInfoLista; // TPConsultaMes
    FUltimas_consultas: TPNodeInfoList; // TPConsulta
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Quantidade_total: String             Read Fquantidade_total  Write Fquantidade_total;
    property Ate_data_anterior: TPAteDataAnterior Read FAte_data_anterior Write FAte_data_anterior;
    property Consultas_mes: TPNodeInfoLista       Read Fconsultas_mes     Write Fconsultas_mes;
    property Ultimas_consultas: TPNodeInfoList    Read FUltimas_consultas Write FUltimas_consultas;
    property Mensagem: String                     Read FMensagem          Write FMensagem;
  End;

  TPTitulosAVencer = Class(TPNodeInfo)
  private
    FTitulos_a_vencer_periodo: TPNodeInfoLista; //TPTituloAVencer
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Titulos_a_vencer_periodo: TPNodeInfoLista Read FTitulos_a_vencer_periodo Write FTitulos_a_vencer_periodo;
    property Mensagem: String                          Read FMensagem                 Write FMensagem;
  End;

  TPParticipacoes = Class(TPNodeInfo)
  private
    FQtd_outras_participacoes: String;
    FEmpresa: TPNodeInfoLista; // TPEmpresa
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Qtd_outras_participacoes: String Read FQtd_outras_participacoes Write FQtd_outras_participacoes;
    property Empresa: TPNodeInfoLista         Read FEmpresa                  Write FEmpresa;
    property Mensagem: String                 Read FMensagem                 Write FMensagem;
  End;

  TPRepresentanteLegal = Class(TPNodeInfo)
  private
    FCpf: String;
    FNome: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cpf: String      Read FCpf      Write FCpf;
    property Nome: String     Read FNome     Write FNome;
    property Mensagem: String Read FMensagem Write FMensagem;
  End;

  TPMercado = Class(TPNodeInfo)
  private
    FTipo: String;
    FQtde_tit_vencer: String;
    FValor_vencer: String;
    FQtde_tit_pagos: String;
    FValor_pagos: String;
    FQtde_tit_vencidos: String;
    FValor_vencidos: String;
  public
    function fGetRelatorio: String; override;
  published
    property Tipo: String              Read FTipo              Write FTipo;
    property Qtde_tit_vencer: String   Read FQtde_tit_vencer   Write FQtde_tit_vencer;
    property Valor_vencer: String      Read FValor_vencer      Write FValor_vencer;
    property Qtde_tit_pagos: String    Read FQtde_tit_pagos    Write FQtde_tit_pagos;
    property Valor_pagos: String       Read FValor_pagos       Write FValor_pagos;
    property Qtde_tit_vencidos: String Read FQtde_tit_vencidos Write FQtde_tit_vencidos;
    property Valor_vencidos: String Read FValor_vencidos       Write FValor_vencidos;
  End;

  TPSegmento = Class(TPNodeInfo)
  private
    FTipo: String;
    FQtde_tit_vencer: String;
    FValor_vencer: String;
    FQtde_tit_pagos: String;
    FValor_pagos: String;
    FQtde_tit_vencidos: String;
    FValor_vencidos: String;
  public
    function fGetRelatorio: String; override;
  published
    property Tipo: String              Read FTipo              Write FTipo;
    property Qtde_tit_vencer: String   Read FQtde_tit_vencer   Write FQtde_tit_vencer;
    property Valor_vencer: String      Read FValor_vencer      Write FValor_vencer;
    property Qtde_tit_pagos: String    Read FQtde_tit_pagos    Write FQtde_tit_pagos;
    property Valor_pagos: String       Read FValor_pagos       Write FValor_pagos;
    property Qtde_tit_vencidos: String Read FQtde_tit_vencidos Write FQtde_tit_vencidos;
    property Valor_vencidos: String    Read FValor_vencidos    Write FValor_vencidos;
  End;

  TPConsultante = Class(TPNodeInfo)
  private
    FTipo: String;
    FQtde_tit_vencer: String;
    FValor_vencer: String;
    FQtde_tit_pagos: String;
    FValor_pagos: String;
    FQtde_tit_vencidos: String;
    FValor_vencidos: String;
    FPago_a_vista: String;
    FPago_pontual: String;
    FDias_atraso_1: String;
    FDias_atraso_2: String;
    FDias_atraso_3: String;
    FDias_atraso_4: String;
    FAtraso_medio: String;
  public
    function fGetRelatorio: String; override;
  published
    property Tipo: String              Read FTipo              Write FTipo;
    property Qtde_tit_vencer: String   Read FQtde_tit_vencer   Write FQtde_tit_vencer;
    property Valor_vencer: String      Read FValor_vencer      Write FValor_vencer;
    property Qtde_tit_pagos: String    Read FQtde_tit_pagos    Write FQtde_tit_pagos;
    property Valor_pagos: String       Read FValor_pagos       Write FValor_pagos;
    property Qtde_tit_vencidos: String Read FQtde_tit_vencidos Write FQtde_tit_vencidos;
    property Valor_vencidos: String    Read FValor_vencidos    Write FValor_vencidos;
    property Pago_a_vista: String      Read FPago_a_vista      Write FPago_a_vista;
    property Pago_pontual: String      Read FPago_pontual      Write FPago_pontual;
    property Dias_atraso_1: String     Read FDias_atraso_1     Write FDias_atraso_1;
    property Dias_atraso_2: String     Read FDias_atraso_2     Write FDias_atraso_2;
    property Dias_atraso_3: String     Read FDias_atraso_3     Write FDias_atraso_3;
    property Dias_atraso_4: String     Read FDias_atraso_4     Write FDias_atraso_4;
    property Atraso_medio: String      Read FAtraso_medio      Write FAtraso_medio;
  End;


  TPTipoComportamento = Class(TPNodeInfo)
  private
    FTipo: String;
    FQtde_tit_vencer: String;
    FValor_vencer: String;
    FQtde_tit_pagos: String;
    FValor_pagos: String;
    FQtde_tit_vencidos: String;
    FValor_vencidos: String;
    FPago_a_vista: String;
    FPago_pontual: String;
    FDias_atraso_1: String;
    FDias_atraso_2: String;
    FDias_atraso_3: String;
    FDias_atraso_4: String;
    FAtraso_medio: String;
  published
    property Tipo: String               Read FTipo                Write FTipo;
    property Qtde_tit_vencer: String    Read FQtde_tit_vencer     Write FQtde_tit_vencer;
    property Valor_vencer: String       Read FValor_vencer        Write FValor_vencer;
    property Qtde_tit_pagos: String     Read FQtde_tit_pagos      Write FQtde_tit_pagos;
    property Valor_pagos: String        Read FValor_pagos         Write FValor_pagos;
    property Qtde_tit_vencidos: String  Read FQtde_tit_vencidos   Write FQtde_tit_vencidos;
    property Valor_vencidos: String     Read FValor_vencidos      Write FValor_vencidos;
    property Pago_a_vista: String       Read FPago_a_vista        Write FPago_a_vista;
    property Pago_pontual: String       Read FPago_pontual        Write FPago_pontual;
    property Dias_atraso_1: String      Read FDias_atraso_1       Write FDias_atraso_1;
    property Dias_atraso_2: String      Read FDias_atraso_2       Write FDias_atraso_2;
    property Dias_atraso_3: String      Read FDias_atraso_3       Write FDias_atraso_3;
    property Dias_atraso_4: String      Read FDias_atraso_4       Write FDias_atraso_4;
    property Atraso_medio: String       Read FAtraso_medio        Write FAtraso_medio;
  End;

  TPComportamentoEmpresa = Class(TPNodeInfo)
  private
    FConsultante: TPConsultante;
    FSegmento: TPSegmento;
    FMercado: TPMercado;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Consultante: TPConsultante Read FConsultante Write FConsultante;
    property Segmento: TPSegmento       Read FSegmento    Write FSegmento;
    property Mercado: TPMercado         Read FMercado     Write FMercado;
    property Mensagem: String           Read FMensagem    Write FMensagem;
  End;

  TPPainelControle = Class(TPNodeInfo)
  private
    FDescricao: String;
    FQuantidade: String;
    FUltima: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Descricao: String  Read FDescricao  Write FDescricao;
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Ultima: String     Read FUltima     Write FUltima;
    property Valor: String      Read FValor      Write FValor;
  End;

  TPFaturamentoPresumido = Class(TPNodeInfo)
  private
    FDescricao_natureza: String;
    FDescricao_modelo: String;
    FFaixa: String;
    FFaturamento_anual: String;
    FTexto: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Descricao_natureza: String Read FDescricao_natureza Write FDescricao_natureza;
    property Descricao_modelo: String   Read FDescricao_modelo   Write FDescricao_modelo;
    property Faixa: String              Read FFaixa              Write FFaixa;
    property Faturamento_anual: String  Read FFaturamento_anual  Write FFaturamento_anual;
    property Texto: String              Read FTexto              Write FTexto;
    property Mensagem: String           Read FMensagem           Write FMensagem;
  End;

  TPModeloScore = Class(TPNodeInfo)
  private
    FNatureza_score: String;
    FDescricao_score: String;
    FValor: String;
    FProbabilidade: String;
    FRisco: String;
    FGrupo: String;
    FTexto_explicativo: String;
    FTexto_fixo: String;
  public
    function fGetRelatorio: String; override;
  published
    property Natureza_score: String    Read FNatureza_score    Write FNatureza_score;
    property Descricao_score: String   Read FDescricao_score   Write FDescricao_score;
    property Valor: String             Read FValor             Write FValor;
    property Probabilidade: String     Read FProbabilidade     Write FProbabilidade;
    property Risco: String             Read FRisco             Write FRisco;
    property Grupo: String             Read FGrupo             Write FGrupo;
    property Texto_explicativo: String Read FTexto_explicativo Write FTexto_explicativo;
    property Texto_fixo: String        Read FTexto_fixo        Write FTexto_fixo;
  End;

  TPScore = Class(TPNodeInfo)
  private
    FModelo_score: TPModeloScore;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Modelo_score: TPModeloScore Read FModelo_score Write FModelo_score;
    property Mensagem: String            Read FMensagem     Write FMensagem;
  End;

  TPAlerta = Class(TPNodeInfo)
  private
    FData: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String     Read FData     Write FData;
    property Mensagem: String Read FMensagem Write FMensagem;
  End;

  TPAutorizacao = Class(TPNodeInfo)
  private
    FAutorizacao: String;
    FSituacao: String;
    FData_autorizacao: String;
    FNum_processo: String;
    FTipo_autorizacao: String;
    FTipo_autorizacao2: String;
    FClasse_atividade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Autorizacao: String       Read FAutorizacao        Write FAutorizacao;
    property Situacao: String          Read FSituacao           Write FSituacao;
    property Data_autorizacao: String  Read FData_autorizacao   Write FData_autorizacao;
    property Num_processo: String      Read FNum_processo       Write FNum_processo;
    property Tipo_autorizacao: String  Read FTipo_autorizacao   Write FTipo_autorizacao;
    property Tipo_autorizacao2: String Read FTipo_autorizacao2  Write FTipo_autorizacao2;
    property Classe_atividade: String  Read FClasse_atividade   Write FClasse_atividade;
  End;

  TPDistribuidores = Class(TPNodeInfo)
  private
    FResp_legal: String;
    FResp_tecnico: String;
    FSegundo_resp_legal: String;
    FSegundo_resp_tecnico: String;
    FTerceiro_resp_legal: String;
    FTerceiro_resp_tecnico: String;
    FAutorizacoes: TPNodeInfoList; // TPAutorizacao
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Resp_legal: String            Read FResp_legal            Write FResp_legal;
    property Resp_tecnico: String          Read FResp_tecnico          Write FResp_tecnico;
    property Segundo_resp_legal: String    Read FSegundo_resp_legal    Write FSegundo_resp_legal;
    property Segundo_resp_tecnico: String  Read FSegundo_resp_tecnico  Write FSegundo_resp_tecnico;
    property Terceiro_resp_legal: String   Read FTerceiro_resp_legal   Write FTerceiro_resp_legal;
    property Terceiro_resp_tecnico: String Read FTerceiro_resp_tecnico Write FTerceiro_resp_tecnico;
    property Autorizacoes: TPNodeInfoList  Read FAutorizacoes          Write FAutorizacoes;
  End;

  TPFarmaciaDrogaria = Class(TPNodeInfo)
  private
    FResp_legal: String;
    FResp_tecnico: String;
    FSegundo_resp_legal: String;
    FSegundo_resp_tecnico: String;
    FTerceiro_resp_legal: String;
    FTerceiro_resp_tecnico: String;
    FAutorizacoes: TPNodeInfoList; //TPAutorizacao
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Resp_legal: String            Read FResp_legal            Write FResp_legal;
    property Resp_tecnico: String          Read FResp_tecnico          Write FResp_tecnico;
    property Segundo_resp_legal: String    Read FSegundo_resp_legal    Write FSegundo_resp_legal;
    property Segundo_resp_tecnico: String  Read FSegundo_resp_tecnico  Write FSegundo_resp_tecnico;
    property Terceiro_resp_legal: String   Read FTerceiro_resp_legal   Write FTerceiro_resp_legal;
    property Terceiro_resp_tecnico: String Read FTerceiro_resp_tecnico Write FTerceiro_resp_tecnico;
    property Autorizacoes: TPNodeInfoList  Read FAutorizacoes          Write FAutorizacoes;
  End;

  TPMatriz = Class(TPNodeInfo)
  private
    FEndereco: String;
    FBairro: String;
    FCidade: String;
    FUf: String;
    FCep: String;
  public
    function fGetRelatorio: String; override;
  published
    property Endereco: String Read FEndereco Write FEndereco;
    property Bairro: String   Read FBairro   Write FBairro;
    property Cidade: String   Read FCidade   Write FCidade;
    property Uf: String       Read FUf       Write FUf;
    property Cep: String      Read FCep      Write FCep;
  End;

  TPLocalizacao = class(TPNodeInfo)
  private
    FEndereco: String;
    FBairro: String;
    FCidade: String;
    FUf: String;
    FCep: String;
    FMensagem: String;
    FMatriz: TPMatriz;
    FTelefones: TStrings;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Endereco: String    Read FEndereco  Write FEndereco;
    property Bairro: String      Read FBairro    Write FBairro;
    property Cidade: String      Read FCidade    Write FCidade;
    property Uf: String          Read FUf        Write FUf;
    property Cep: String         Read FCep       Write FCep;
    property Mensagem: String    Read FMensagem  Write FMensagem;
    property Matriz: TPMatriz    Read FMatriz    Write FMatriz;
    property Telefones: TStrings Read FTelefones Write FTelefones;
  end;

  TPPrincipaisProdutos = class(TPNodeInfo)
  private
    FProduto: String;
  public
    function fGetRelatorio: String; override;
  published
    property Produto: String Read FProduto Write FProduto;
  end;

  TPRamoAtividadeSecundario = class(TPNodeInfo)
  private
    FAtividade: String;
    FCnae: String;
  public
    function fGetRelatorio: String; override;
  published
    property Atividade: String Read FAtividade Write FAtividade;
    property Cnae: String      Read FCnae Write FCnae;
  end;

  TPRamoAtividade = class(TPNodeInfo)
  private
    FAtividade: String;
    FCnae: String;
  public
    function fGetRelatorio: String; override;
  published
    property Atividade: String Read FAtividade Write FAtividade;
    property Cnae: String      Read FCnae      Write FCnae;
  end;

  TPNire = class(TPNodeInfo)
  private
    FNumero: String;
    FUf: String;
  public
    function fGetRelatorio: String; override;
  published
    property Numero: String Read FNumero Write FNumero;
    property Uf: String     Read FUf     Write FUf;
  end;

  TPFiliais = class(TPNodeInfo)
  private
    FQuantidade: String;
    FCidades: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Cidades: String    Read FCidades    Write FCidades;
  end;

  TPInscricaoEstadual = class(TPNodeInfo)
  private
    FUf: String;
    FCadastro: String;
  public
    function fGetRelatorio: String; override;
  published
    property Uf: String       Read FUf       Write FUf;
    property Cadastro: String Read FCadastro Write FCadastro;
  end;

  TPSintegra = class(TPNodeInfo)
  private
    FSituacao: String;
    FData: String;
    FData_consulta: String;
  public
    function fGetRelatorio: String; override;
  published
    property Situacao: String      Read FSituacao      Write FSituacao;
    property Data: String          Read FData          Write FData;
    property Data_consulta: String Read FData_consulta Write FData_consulta;
  end;

  TPIdentificacao = class(TPNodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FRazao_social_anterior: String;
    FData_razao_anterior: String;
    FNome_fantasia: String;
    FData_fundacao: String;
    FData_encerramento: String;
    FSituacao_cnpj: String;
    FData_situacao_cnpj: String;
    FData_consulta_cnpj: String;
    FSintegra: TPSintegra;
    FInscricao_estadual: TPInscricaoEstadual;
    FNatureza_juridica: String;
    FFaixa_funcionarios: String;
    FFiliais: TPFiliais;
    FNire: TPNire;
    FRamo_atividade: TPRamoAtividade;
    FRamo_atividade_secundario: TPRamoAtividadeSecundario;
    FPrincipais_produtos: TStrings;
    FMensagem: String;
  public
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Cnpj: String                                         Read FCnpj                      Write FCnpj;
    property Razao_social: String                                 Read FRazao_social              Write FRazao_social;
    property Razao_social_anterior: String                        Read FRazao_social_anterior     Write FRazao_social_anterior;
    property Data_razao_anterior: String                          Read FData_razao_anterior       Write FData_razao_anterior;
    property Nome_fantasia: String                                Read FNome_fantasia             Write FNome_fantasia;
    property Data_fundacao: String                                Read FData_fundacao             Write FData_fundacao;
    property Data_encerramento: String                            Read FData_encerramento         Write FData_encerramento;
    property Situacao_cnpj: String                                Read FSituacao_cnpj             Write FSituacao_cnpj;
    property Data_situacao_cnpj: String                           Read FData_situacao_cnpj        Write FData_situacao_cnpj;
    property Data_consulta_cnpj: String                           Read FData_consulta_cnpj        Write FData_consulta_cnpj;
    property Sintegra: TPSintegra                                 Read FSintegra                  Write FSintegra;
    property Inscricao_estadual: TPInscricaoEstadual              Read FInscricao_estadual        Write FInscricao_estadual;
    property Natureza_juridica: String                            Read FNatureza_juridica         Write FNatureza_juridica;
    property Faixa_funcionarios: String                           Read FFaixa_funcionarios        Write FFaixa_funcionarios;
    property Filiais: TPFiliais                                   Read FFiliais                   Write FFiliais;
    property Nire: TPNire                                         Read FNire                      Write FNire;
    property Ramo_atividade: TPRamoAtividade                      Read FRamo_atividade            Write FRamo_atividade;
    property Ramo_atividade_secundario: TPRamoAtividadeSecundario Read FRamo_atividade_secundario Write FRamo_atividade_secundario;
    property Mensagem: String                                     Read FMensagem                  Write FMensagem;
    property Principais_produtos: TStrings                        Read FPrincipais_produtos       Write FPrincipais_produtos;
  end;

  TPImportantesInformacoes = Class(TPNodeInfo)
  private
    FData: String;
    FMensagem_informativa: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String                 Read FData                 Write FData;
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TPReceita = Class(TPNodeInfo)
  private
    FSituacao: String;
  published
    property Situacao: String             Read FSituacao             Write FSituacao;
  end;

  TPIdentificacaoPF = Class(TPNodeInfo)
  private
    FCpf: String;
    FNome: String;
    FNome_mae: String;
    FReceita: TPReceita;
    FData_nascimento: String;
    FMensagem_informativa: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cpf: String                  Read FCpf                  Write FCpf;
    property Nome: String                 Read FNome                 Write FNome;
    property Nome_mae: String             Read FNome_mae             Write FNome_mae;
    property Receita: TPReceita           Read FReceita              Write FReceita;
    property Data_nascimento: String      Read FData_nascimento      Write FData_nascimento;
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TPEmpresaParticipacao = Class(TPNodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FTipo: String;
    FPercentual_participacao: String;
    FCargo: String;
    FData_entrada: String;
    FData_saida: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cnpj: String                    Read FCnpj                    Write FCnpj;
    property Razao_social: String            Read FRazao_social            Write FRazao_social;
    property Tipo: String                    Read FTipo                    Write FTipo;
    property Percentual_participacao: String Read FPercentual_participacao Write FPercentual_participacao;
    property Cargo: String                   Read FCargo                   Write FCargo;
    property Data_entrada: String            Read FData_entrada            Write FData_entrada;
    property Data_saida: String              Read FData_saida              Write FData_saida;
  end;

  TPResumo = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FData_ultima: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String  Read FQuantidade  Write FQuantidade;
    property Data_ultima: String Read FData_ultima Write FData_ultima;
  end;

  TPParticipacoesEmEmpresas = Class(TPNodeInfo)
  private
    FResumo: TPResumo;
    FEmpresas: TPNodeInfoList; // TPEmpresaParticipacao
    FMensagem_informativa: String;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Resumo: TPResumo             Read FResumo               Write FResumo;
    property Empresas: TPNodeInfoList     Read FEmpresas             Write FEmpresas;
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TPResumoConsulta = Class(TPNodeInfo)
  private
    FQtd_total: String;
    FData_ultima: String;
  public
    function fGetRelatorio: String; override;
  published
    property Qtd_total: String   Read FQtd_total   Write FQtd_total;
    property Data_ultima: String Read FData_ultima Write FData_ultima;
  end;

  TPTotalConsulta = Class(TPNodeInfo)
  private
    FConsulta: String;
    FCredito: String;
    FCheque: String;
  public
    function fGetRelatorio: String; override;
  published
    property Consulta: String Read FConsulta Write FConsulta;
    property Credito: String  Read FCredito  Write FCredito;
    property Cheque: String   Read FCheque   Write FCheque;
  end;

  TPConsultaMesVigente = Class(TPNodeInfo)
  private
    FData: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String       Read FData       Write FData;
    property Quantidade: String Read FQuantidade Write FQuantidade;
  end;

  TPConsultasMes = Class(TPNodeInfo)
  private
    FMes_ano: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_ano: String    Read FMes_ano    Write FMes_ano;
    property Quantidade: String Read FQuantidade Write FQuantidade;
  end;

  TPConsultasPF = Class(TPNodeInfo)
  private
    FResumo: TPResumoConsulta;
    FTotais: TPTotalConsulta;
    FConsulta_mes_vigente: TPConsultaMesVigente;
    FConsultas_mes: TPNodeInfoLista; // TPConsultasMes;
    FUltimos: TPNodeInfoList; // TPConsulta;
    FMensagem_informativa: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Resumo: TPResumoConsulta                   Read FResumo               Write FResumo;
    property Totais: TPTotalConsulta                    Read FTotais               Write FTotais;
    property Consulta_mes_vigente: TPConsultaMesVigente Read FConsulta_mes_vigente Write FConsulta_mes_vigente;
    property Consultas_mes: TPNodeInfoLista             Read FConsultas_mes        Write FConsultas_mes;
    property Ultimos: TPNodeInfoList                    Read FUltimos              Write FUltimos;
    property Mensagem_informativa: String               Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TPQtdeTotal = Class(TPNodeInfo)
  private
    FQtd_total: String;
    FValor_total: String;
  public
  published
    property Qtd_total: String   Read FQtd_total Write FQtd_total;
    property Valor_total: String Read FValor_total Write FValor_total;
  end;

  TPRegDebResumo = Class(TPNodeInfo)
  private
    FQtd_total: String;
    FData_ultimo: String;
    FValor_total: String;
  public
  published
    property Qtd_total: String   Read FQtd_total   Write FQtd_total;
    property Data_ultimo: String Read FData_ultimo Write FData_ultimo;
    property Valor_total: String Read FValor_total Write FValor_total;
  end;

  TPPrimeiro = Class(TPNodeInfo)
  private
    FData: String;
    FInformante: String;
    FValor: String;
  public
  published
    property Data: String        Read FData      Write FData;
    property Informante: String  Read FInformante Write FInformante;
    property Valor: String       Read FValor      Write FValor;
  end;

  TPRegistroDebito = Class(TPNodeInfo)
  private
    FData_ocorrencia: String;
    FInformante: String;
    FContrato: String;
    FCidade: String;
    FUf: String;
    FSituacao: String;
    FValor: String;
  public
  published
    property Data_ocorrencia: String Read FData_ocorrencia Write FData_ocorrencia;
    property Informante: String      Read FInformante      Write FInformante;
    property contrato: String        Read FContrato        Write FContrato;
    property cidade: String          Read FCidade          Write FCidade;
    property uf: String              Read FUf              Write FUf;
    property situacao: String        Read FSituacao        Write FSituacao;
    property valor: String           Read FValor           Write FValor;
  end;

  TPRegistroDebitos = Class(TPNodeInfo)
  private
    FResumo: TPRegDebResumo;
    FComprador: TPQtdeTotal;
    FAvalista: TPQtdeTotal;
    FPrimeiro: TPPrimeiro;
    FUltimasOcorrencias: TPNodeInfoList; // TPRegistroDebito
    FMensagem_informativa: String;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Resumo: TPRegDebResumo              Read FResumo               Write FResumo;
    property Comprador: TPQtdeTotal              Read FComprador            Write FComprador;
    property Avalista: TPQtdeTotal               Read FAvalista             Write FAvalista;
    property Primeiro: TPPrimeiro                Read FPrimeiro             Write FPrimeiro;
    property Ultimas_Ocorrencias: TPNodeInfoList Read FUltimasOcorrencias   Write FUltimasOcorrencias;
    property Mensagem_informativa: String        Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TPFalenciaOcorrencia = Class(TPNodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FData_ocorrencia: String;
    FVara_civel: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cnpj: String            Read FCnpj            Write FCnpj;
    property Razao_social: String    Read FRazao_social    Write FRazao_social;
    property Data_ocorrencia: String Read FData_ocorrencia Write FData_ocorrencia;
    property Vara_civel: String      Read FVara_civel      Write FVara_civel;
  end;

  TPFalenciasEmpresariais = Class(TPNodeInfo)
  private
    FResumo: TPResumoConsulta;
    FUltimas_ocorrencias: TPNodeInfoList; // TPFalenciaOcorrencia
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Resumo: TPResumoConsulta            Read FResumo              Write FResumo;
    property Ultimas_ocorrencias: TPNodeInfoList Read FUltimas_ocorrencias Write FUltimas_ocorrencias; // TPFalenciaOcorrencia
  end;

  TPAcaoResumo = Class(TPNodeInfo)
  private
    FQtd_total: String;
    FData_ultima: String;
    FValor_total: String;
  public
  published
    property Qtd_total: String   Read FQtd_total   Write FQtd_total;
    property Data_ultima: String Read FData_ultima Write FData_ultima;
    property Valor_total: String Read FValor_total Write FValor_total;
  end;

  TPACResumo = Class(TPNodeInfo)
  private
    FQtd_total: String;
    FData_ultima: String;
    FValor_total: String;
  public
  published
    property Qtd_total: String   Read FQtd_total   Write FQtd_total;
    property Data_ultima: String Read FData_ultima Write FData_ultima;
    property Valor_total: String Read FValor_total Write FValor_total;
  end;

  TPAcaoCivel = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FTipo_acao: String;
  public
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Tipo_acao: String  Read FTipo_acao  Write FTipo_acao;
  end;

  TPACTotal = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FValor: String;
  public
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Valor: String      Read FValor      Write FValor;
  end;

  TPAcoesCiveis = Class(TPNodeInfo)
  private
    FResumo: TPACResumo;
    FTotal: TPACTotal;
    FPrimeira: TPDataValor;
    FUltima: TPDataValor;
    FUltimas: TPNodeInfoList; // TPAcaoCivel
    FMensagem_informativa: String;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Resumo: TPACResumo           Read FResumo               Write FResumo;
    property Total: TPACTotal             Read FTotal                Write FTotal;
    property Primeira: TPDataValor        Read FPrimeira             Write FPrimeira;
    property Ultima: TPDataValor          Read FUltima               Write FUltima;
    property Ultimas: TPNodeInfoList      Read FUltimas              Write FUltimas; // TPAcaoCivel
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TPAdministradorPf = Class(TPNodeInfo)
  private
    FImportantes_informacoes: TPImportantesInformacoes;
    FIdentificacao: TPIdentificacaoPF;
    FLocalizacao: TPLocalizacao;
    FParticipacoes_empresas: TPParticipacoesEmEmpresas;
    FConsultas: TPConsultasPF;
    FRegistro_debitos: TPRegistroDebitos;
    FCheques_sem_fundo: TPChequesSemFundoPF;
    FProtestos: TPProtestosPF;
    FFalencias_empresariais: TPFalenciasEmpresariais;
    FAcoes_civeis: TPAcoesCiveis;
  public
    function fGetRelatorio: String; override;
  published
    property importantes_informacoes: TPImportantesInformacoes Read FImportantes_informacoes Write FImportantes_informacoes;
    property identificacao: TPIdentificacaoPF                  Read FIdentificacao           Write FIdentificacao;
    property localizacao: TPLocalizacao                        Read FLocalizacao             Write FLocalizacao;
    property participacoes_empresas: TPParticipacoesEmEmpresas Read FParticipacoes_empresas  Write FParticipacoes_empresas;
    property consultas: TPConsultasPF                          Read FConsultas               Write FConsultas;
    property registro_debitos: TPRegistroDebitos               Read FRegistro_debitos        Write FRegistro_debitos;
    property cheques_sem_fundo: TPChequesSemFundoPF            Read FCheques_sem_fundo       Write FCheques_sem_fundo;
    property protestos: TPProtestosPF                          Read FProtestos               Write FProtestos;
    property falencias_empresariais: TPFalenciasEmpresariais   Read FFalencias_empresariais  Write FFalencias_empresariais;
    property acoes_civeis: TPAcoesCiveis                       Read FAcoes_civeis            Write FAcoes_civeis;
  end;

  TPSociosAcionistas = Class(TPNodeInfo)
  private
    FMarcador: String;
    FCpf: String;
    FNome: String;
    FCnpj: String;
    FRazao_social: String;
    FParticipacao: String;
    FEntrada: String;
  public
    function fGetRelatorio: String; override;
  published
    property Marcador: String     Read FMarcador     Write FMarcador;
    property Cpf: String          Read FCpf          Write FCpf;
    property Nome: String         Read FNome         Write FNome;
    property Cnpj: String         Read FCnpj         Write FCnpj;
    property Razao_social: String Read FRazao_social Write FRazao_social;
    property Participacao: String Read FParticipacao Write FParticipacao;
    property Entrada: String      Read FEntrada      Write FEntrada;
  end;

  TPSociosPlatinum = Class(TPNodeInfo)
  private
    FCapital_social: String;
    FAtu_junta_coml: String;
    FQtd_outros_socios: String;
    FSocios_pj: TPNodeInfoList; // TPSocioPJ
    FSocios_pf: TPNodeInfoList; // TPSocioPF
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Capital_social: String             Read FCapital_social    Write FCapital_social;
    property Atu_junta_coml: String             Read FAtu_junta_coml    Write FAtu_junta_coml;
    property Qtd_outros_socios: String          Read FQtd_outros_socios Write FQtd_outros_socios;
    property Socios_pj: TPNodeInfoList          Read FSocios_pj         Write FSocios_pj;
    property Socios_pf: TPNodeInfoList          Read FSocios_pf         Write FSocios_pf;
  end;

  TPSocios = Class(TPNodeInfo)
  private
    FCapital_social: String;
    FAtu_junta_coml: String;
    FQtd_outros_socios: String;
    FSocios_acionistas: TPNodeInfoLista; // TPSociosAcionistas
    FSocios_pj: TPNodeInfoList; // TPSocioPJ - Platinum
    FSocios_pf: TPNodeInfoList; // TPSocioPF - Platinum
    FMensagem: String;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Capital_social: String             Read FCapital_social    Write FCapital_social;
    property Atu_junta_coml: String             Read FAtu_junta_coml    Write FAtu_junta_coml;
    property Qtd_outros_socios: String          Read FQtd_outros_socios Write FQtd_outros_socios;
    property Socios_acionistas: TPNodeInfoLista Read FSocios_acionistas Write FSocios_acionistas;
    property Socios_pj: TPNodeInfoList          Read FSocios_pj         Write FSocios_pj;
    property Socios_pf: TPNodeInfoList          Read FSocios_pf         Write FSocios_pf;
    property Mensagem: String                   Read FMensagem          Write FMensagem;
  end;

  TAdministradoresPj = Class(TPNodeInfo)
  private
    FAtuJuntaComl: String;
    FAdministrador: TPNodeInfoLista; //TPAdministradorPlatinum
    FQuantidade: String;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Atu_junta_coml: String         Read FAtuJuntaComl    Write FAtuJuntaComl;
    property Administrador: TPNodeInfoLista Read FAdministrador   Write FAdministrador;
    property Quantidade: String             Read FQuantidade      Write FQuantidade;
    property Mensagem: String               Read FMensagem        Write FMensagem;
  end;

  TPAdministradorPj = Class(TPNodeInfo)
  private
    FIdentificacao: TPIdentificacao;
    FLocalizacao: TPLocalizacao;
    FAlerta: TPAlerta;
    FSocios: TPSocios;
    FAdministradores: TAdministradoresPj;
    FParticipacoes: TPParticipacoes;
    FConsultas: TPConsultas;
    FTempo_relacionamento_fornecedores: TPTempoRelFornecedores;
    FTitulos_a_vencer: TPTitulosAVencer;
    FHistorico_pagamentos: TPHistoricoPagamentos;
    FReferenciais_negocios: TPReferenciaisNegocios;
    FPendencias_restricoes: TPPendenciasRestricoes;
    FCheques_sem_fundo: TPChequesSemFundo;
    FProtestos: TPProtestos;
    FRecuperacoes_falencias_acoes: TPNodeInfoList; //TPRecuperacaoFalencia  // TPRecuperacoesFalencias;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Identificacao: TPIdentificacao                            Read FIdentificacao                     Write FIdentificacao;
    property Localizacao: TPLocalizacao                                Read FLocalizacao                       Write FLocalizacao;
    property Alerta: TPAlerta                                          Read FAlerta                            Write FAlerta;
    property Socios: TPSocios                                          Read FSocios                            Write FSocios;
    property Administradores: TAdministradoresPj                       Read FAdministradores                   Write FAdministradores;
    property Participacoes: TPParticipacoes                            Read FParticipacoes                     Write FParticipacoes;
    property Consultas: TPConsultas                                    Read FConsultas                         Write FConsultas;
    property Tempo_relacionamento_fornecedores: TPTempoRelFornecedores Read FTempo_relacionamento_fornecedores Write FTempo_relacionamento_fornecedores;
    property Titulos_a_vencer: TPTitulosAVencer                        Read FTitulos_a_vencer                  Write FTitulos_a_vencer;
    property Historico_pagamentos: TPHistoricoPagamentos               Read FHistorico_pagamentos              Write FHistorico_pagamentos;
    property Referenciais_negocios: TPReferenciaisNegocios             Read FReferenciais_negocios             Write FReferenciais_negocios;
    property Pendencias_restricoes: TPPendenciasRestricoes             Read FPendencias_restricoes             Write FPendencias_restricoes;
    property Cheques_sem_fundo: TPChequesSemFundo                      Read FCheques_sem_fundo                 Write FCheques_sem_fundo;
    property Protestos: TPProtestos                                    Read FProtestos                         Write FProtestos;
    property Recuperacoes_falencias_acoes: TPNodeInfoList              Read FRecuperacoes_falencias_acoes      Write FRecuperacoes_falencias_acoes;
  end;

  TPAdministradores = Class(TPNodeInfo)
  private
    FAtu_junta_coml: String;
    FQuantidade: String;
    FAdministradores_pj: String;
    FAdministradores_pf: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Atu_junta_coml: String     Read FAtu_junta_coml     Write FAtu_junta_coml;
    property Quantidade: String         Read FQuantidade         Write FQuantidade;
    property Administradores_pj: String Read FAdministradores_pj Write FAdministradores_pj;
    property Administradores_pf: String Read FAdministradores_pf Write FAdministradores_pf;
    property Mensagem: String           Read FMensagem           Write FMensagem;
  end;

  TPSocioPJ = Class(TPNodeInfo)
  private
    FIdentificacao: TPIdentificacao;
    FLocalizacao: TPLocalizacao;
    FAlerta: TPAlerta;
    FSocios: TPSocios;
    FAdministradores: TPAdministradores;
    FParticipacoes: TPParticipacoes;
    FConsultas: TPConsultas;
    FTempo_relacionamento_fornecedores: TPTempoRelFornecedores;
    FTitulos_a_vencer: TPTitulosAVencer;
    FHistorico_pagamentos: TPHistoricoPagamentos;
    FReferenciais_negocios: TPReferenciaisNegocios;
    FPendencias_restricoes: TPPendenciasRestricoes;
    FCheques_sem_fundo: TPChequesSemFundo;
    FProtestos: TPProtestos;
    FRecuperacoesFalenciasAcoes: TPNodeInfoList; // TPRecuperacaoFalencia
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Identificacao: TPIdentificacao                            Read FIdentificacao                     Write FIdentificacao;
    property Localizacao: TPLocalizacao                                Read FLocalizacao                       Write FLocalizacao;
    property Alerta: TPAlerta                                          Read FAlerta                            Write FAlerta;
    property Socios: TPSocios                                          Read FSocios                            Write FSocios;
    property Administradores: TPAdministradores                        Read FAdministradores                   Write FAdministradores;
    property Participacoes: TPParticipacoes                            Read FParticipacoes                     Write FParticipacoes;
    property Consultas: TPConsultas                                    Read FConsultas                         Write FConsultas;
    property Tempo_relacionamento_fornecedores: TPTempoRelFornecedores Read FTempo_relacionamento_fornecedores Write FTempo_relacionamento_fornecedores;
    property Titulos_a_vencer: TPTitulosAVencer                        Read FTitulos_a_vencer                  Write FTitulos_a_vencer;
    property Historico_pagamentos: TPHistoricoPagamentos               Read FHistorico_pagamentos              Write FHistorico_pagamentos;
    property Referenciais_negocios: TPReferenciaisNegocios             Read FReferenciais_negocios             Write FReferenciais_negocios;
    property Pendencias_restricoes: TPPendenciasRestricoes             Read FPendencias_restricoes             Write FPendencias_restricoes;
    property Cheques_sem_fundo: TPChequesSemFundo                      Read FCheques_sem_fundo                 Write FCheques_sem_fundo;
    property Protestos: TPProtestos                                    Read FProtestos                         Write FProtestos;
    property Recuperacoes_Falencias_Acoes: TPNodeInfoList              Read FRecuperacoesFalenciasAcoes        Write FRecuperacoesFalenciasAcoes;
  end;

  TPSocioPF = Class(TPNodeInfo)
  private
    FImportantes_informacoes: TPImportantesInformacoes;
    FIdentificacao: TPIdentificacaoPF;
    FLocalizacao: TPLocalizacao;
    FParticipacoes_empresas: TPParticipacoesEmEmpresas;
    FConsultas: TPConsultasPF;
    FRegistro_debitos: TPRegistroDebitos;
    FCheques_sem_fundo: TPChequesSemFundoPF;
    FProtestos: TPProtestosPF;
    FFalencias_empresariais: TPFalenciasEmpresariais;
    FAcoes_civeis: TPAcoesCiveis;
  public
    function fGetRelatorio: String; override;
  published
    property Importantes_informacoes: TPImportantesInformacoes Read FImportantes_informacoes Write FImportantes_informacoes;
    property Identificacao: TPIdentificacaoPF                  Read FIdentificacao           Write FIdentificacao;
    property Localizacao: TPLocalizacao                        Read FLocalizacao             Write FLocalizacao;
    property Participacoes_empresas: TPParticipacoesEmEmpresas Read FParticipacoes_empresas  Write FParticipacoes_empresas;
    property Consultas: TPConsultasPF                          Read FConsultas               Write FConsultas;
    property Registro_debitos: TPRegistroDebitos               Read FRegistro_debitos        Write FRegistro_debitos;
    property Cheques_sem_fundo: TPChequesSemFundoPF            Read FCheques_sem_fundo       Write FCheques_sem_fundo;
    property Protestos: TPProtestosPF                          Read FProtestos               Write FProtestos;
    property Falencias_empresariais: TPFalenciasEmpresariais   Read FFalencias_empresariais  Write FFalencias_empresariais;
    property Acoes_civeis: TPAcoesCiveis                       Read FAcoes_civeis            Write FAcoes_civeis;
  end;

  TPAdministradorPlatinum = Class(TPNodeInfo)
  private
    FMarcador: String;
    FCpf: String;
    FNome: String;
    FEstado_civil: String;
    FNacionalidade: String;
    FCnpj: String;
    FRazao_social: String;
    FCargo: String;
    FData_entrada: String;
    FData_saida: String;
  published
    property Marcador: String      Read FMarcador      Write FMarcador;
    property Cpf: String           Read FCpf           Write FCpf;
    property Nome: String          Read FNome          Write FNome;
    property Estado_civil: String  Read FEstado_civil  Write FEstado_civil;
    property Nacionalidade: String Read FNacionalidade Write FNacionalidade;
    property Cnpj: String          Read FCnpj          Write FCnpj;
    property Razao_social: String  Read FRazao_social  Write FRazao_social;
    property Cargo: String         Read FCargo         Write FCargo;
    property Data_entrada: String  Read FData_entrada  Write FData_entrada;
    property Data_saida: String    Read FData_saida    Write FData_saida;
  end;

  TPAdministradoresPlatinum = Class(TPNodeInfo)
  private
    FAtu_junta_coml: String;
    FQuantidade: String;
    FAdministradoresPJ: TPNodeInfoList; // TPAdministradorPj
    FAdministradoresPF: TPNodeInfoList; // TPAdministradorPf
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Atu_junta_coml: String               Read FAtu_junta_coml      Write FAtu_junta_coml;
    property Quantidade: String                   Read FQuantidade          Write FQuantidade;
    property Administradores_pj: TPNodeInfoList   Read FAdministradoresPJ   Write FAdministradoresPJ;
    property Administradores_pf: TPNodeInfoList   Read FAdministradoresPF   Write FAdministradoresPF;
  end;

  TPParticipacoesPlatinum = Class(TPNodeInfo)
  private
    FQuantidade: String;
    FEmpresas: TPNodeInfoLista; // TPEmpresa
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Empresa:                  TPNodeInfoLista   Read FEmpresas     Write FEmpresas;
    property Qtd_Outras_Participacoes: String            Read FQuantidade   Write FQuantidade;
  end;

  TPEmpresarialPlatinum = Class(TPNodeInfo)
  private
    FIdentificacao: TPIdentificacao;
    FAnaliseSetorial: TPAnaliseSetorial;
    FLocalizacao: TPLocalizacao;
    FAlerta: TPAlerta;
    FComportamento_com_sua_empresa: TPComportamentoEmpresa;
    FSocios: TPSociosPlatinum;
    FAdministradores: TPAdministradoresPlatinum;
    FExtraQuadroSocietario: TStrings;
    FRepresentanteLegal: TPRepresentanteLegal;
    FParticipacoes: TPParticipacoesPlatinum;
    FConsultas: TPConsultas;
    FTempo_relacionamento_fornecedores: TPTempoRelFornecedores;
    FTitulos_a_vencer: TPTitulosAVencer;
    FHistorico_pagamentos: TPHistoricoPagamentos;
    FReferenciais_negocios: TPReferenciaisNegocios;
    FPendencias_restricoes: TPPendenciasRestricoes;
    FCheques_sem_fundo: TPChequesSemFundo;
    FProtestos: TPProtestos;
    FRecuperacoes_falencias_acoes: TPNodeInfoList; //TPRecuperacaoFalencia
    FInformacoes_complementares: TPInformacoesComplementares;
    FInformacoes_mais_recentes: TPInformacoesRecentes;
    FSegmento_empresarial: TPSegmentoEmpresarial;
    FCheques_sustado: TPChequesSustados;
    FScore: TPScore;
    FFaturamento_presumido: TPFaturamentoPresumido;
    FPainel_controle: TPNodeInfoList; // TPPainelControle;
    FPrincipais_fornecedores: TPPrincipaisFornecedores;
    FInconsistencias_participantes: TPInconsistencias;
    FInadimplencia_participantes: TPInadimplencias;
    FFactor: TPFactor;
    FExtra_pendencias: TPExtraPendencias;
    FExtra_protestos: TPExtraProtestos;
    FExtra_participacoes: TPExtraParticipacoes;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Identificacao: TPIdentificacao                            Read FIdentificacao                     Write FIdentificacao;
    property Analise_Setorial: TPAnaliseSetorial                       Read FAnaliseSetorial                   Write FAnaliseSetorial;
    property Localizacao: TPLocalizacao                                Read FLocalizacao                       Write FLocalizacao;
    property Alerta: TPAlerta                                          Read FAlerta                            Write FAlerta;
    property Comportamento_com_sua_empresa: TPComportamentoEmpresa     Read FComportamento_com_sua_empresa     Write FComportamento_com_sua_empresa;
    property Socios: TPSociosPlatinum                                  Read FSocios                            Write FSocios;
    property Administradores: TPAdministradoresPlatinum                Read FAdministradores                   Write FAdministradores;
    property Extra_Quadro_Societario: TStrings Read FExtraQuadroSocietario Write FExtraQuadroSocietario;
    property Representante_legal: TPRepresentanteLegal                 Read FRepresentanteLegal                Write FRepresentanteLegal;
    property Participacoes: TPParticipacoesPlatinum                    Read FParticipacoes                     Write FParticipacoes;
    property Consultas: TPConsultas                                    Read FConsultas                         Write FConsultas;
    property Tempo_relacionamento_fornecedores: TPTempoRelFornecedores Read FTempo_relacionamento_fornecedores Write FTempo_relacionamento_fornecedores;
    property Titulos_a_vencer: TPTitulosAVencer                        Read FTitulos_a_vencer                  Write FTitulos_a_vencer;
    property Historico_pagamentos: TPHistoricoPagamentos               Read FHistorico_pagamentos              Write FHistorico_pagamentos;
    property Referenciais_negocios: TPReferenciaisNegocios             Read FReferenciais_negocios             Write FReferenciais_negocios;
    property Pendencias_restricoes: TPPendenciasRestricoes             Read FPendencias_restricoes             Write FPendencias_restricoes;
    property Cheques_sem_fundo: TPChequesSemFundo                      Read FCheques_sem_fundo                 Write FCheques_sem_fundo;
    property Protestos: TPProtestos                                    Read FProtestos                         Write FProtestos;
    property Recuperacoes_falencias_acoes: TPNodeInfoList              Read FRecuperacoes_falencias_acoes      Write FRecuperacoes_falencias_acoes;
    property Informacoes_complementares: TPInformacoesComplementares   Read FInformacoes_complementares        Write FInformacoes_complementares;
    property Informacoes_mais_recentes: TPInformacoesRecentes          Read FInformacoes_mais_recentes         Write FInformacoes_mais_recentes;
    property Segmento_empresarial: TPSegmentoEmpresarial               Read FSegmento_empresarial              Write FSegmento_empresarial;
    property Cheques_sustado: TPChequesSustados                        Read FCheques_sustado                   Write FCheques_sustado;
    property Score: TPScore                                            Read FScore                             Write FScore;
    property Faturamento_presumido: TPFaturamentoPresumido             Read FFaturamento_presumido             Write FFaturamento_presumido;
    property Painel_controle: TPNodeInfoList                           Read FPainel_controle                   Write FPainel_controle;
    property Principais_fornecedores: TPPrincipaisFornecedores         Read FPrincipais_fornecedores           Write FPrincipais_fornecedores;
    property Inconsistencias_participantes: TPInconsistencias          Read FInconsistencias_participantes     Write FInconsistencias_participantes;
    property Inadimplencia_participantes: TPInadimplencias             Read FInadimplencia_participantes       Write FInadimplencia_participantes;
    property Factor: TPFactor                                          Read FFactor                            Write FFactor;
    property Extra_pendencias: TPExtraPendencias                       Read FExtra_pendencias                  Write FExtra_pendencias;
    property Extra_protestos: TPExtraProtestos                         Read FExtra_protestos                   Write FExtra_protestos;
    property Extra_participacoes: TPExtraParticipacoes                 Read FExtra_participacoes               Write FExtra_participacoes;
  End;

  TConsultaSCPCBoaVistaEmpresarialPlatinum = class(TConsultaSCPC)
  private
    FHTTP: TidHTTP;
    FIDSSL : TIdSSLIOHandlerSocketOpenSSL;
    FEmpresarial: TPEmpresarialPlatinum;
    FErros: TStringList;
    FXmlRetorno: TXMLDocument;
    FDocConsulta: String;
    FNomeEmpresa: String;
    Fconsulta: String;
    FResp: String;
    FGeraLogParaHomolocao: Boolean;
    function fConsultaServico(strDocumento: String): Boolean;
    function fParseErros(node: IXmlNode): Boolean;
    function fFindChildNode(node: IXmlNode; strChildNodeName: String): IXmlNode;
    function fParseNode(strNomeClasse: String; node: IXmlNode): TPNodeInfo;
    procedure pAddChildNodes(lstList: TPNodeInfoList; node: IXmlNode; strProp: String);
    procedure pSaveToPDF(Const strFileName: String);
    procedure pGravaLog(strPai, strProp, strValor: String; blnGera: Boolean = False);
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

uses untFuncoes, untFuncoesSimples, untSQLBind;

{ TPNodeInfo }

constructor TPNodeInfo.Create;
begin
  inherited Create;
end;

function TPNodeInfo.fGetQtdCheques: Integer;
begin
  Result := 0;
end;

function TPNodeInfo.fGetQtdProtestos: Integer;
begin
  Result := 0;
end;

{ TPNodeInfoList }

constructor TPNodeInfoList.Create(strChildClassName: String);
begin
  inherited Create();
  FstrChildClassName := strChildClassName;
end;

function TPNodeInfoList.getChildClassName: String;
begin
  Result := FstrChildClassName;
end;

{ TConsultaSCPCBoaVistaEmpresarialPlatinum }

constructor TConsultaSCPCBoaVistaEmpresarialPlatinum.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FHTTP := TidHTTP.Create(Self);
  FIDSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Self);

  FIDSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  FHTTP.IOHandler := FIDSSL;
  FXmlRetorno := TXMLDocument.Create(Self);
  FErros := TStringList.Create;
  Fconsulta := fCfgSis('INTBOV');
  If fEmptyStr(Fconsulta) Then
    Fconsulta := 'cadastral';
end;

destructor TConsultaSCPCBoaVistaEmpresarialPlatinum.Destroy;
begin
  FreeAndNil(FHTTP);
  FreeAndNil(FIDSSL);
  FreeAndNil(FXmlRetorno);
  FreeAndNil(FEmpresarial);
  FreeAndNil(FErros);
  inherited;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fConsultaServico
  (strDocumento: String): Boolean;
Var
  strLogin, strSenha, strURL: String;
begin
  Result := False;

  If FGeraLogParaHomolocao Then
    pGravaLog('', '', '', True);

  strLogin := fCfgSis('LOGBVE');
  strSenha := fCfgSis('SENBVE');

  If fEmptyStr(strLogin) Then
    If Not fInputQueryTipo('Boa Vista Serviços', 'Login:', strLogin, ttInteiro) Then
      Exit;

  If fEmptyStr(strSenha) Then
    If Not fInputQueryTipo('Boa Vista Serviços', 'Senha:', strSenha, ttAlfanumerico, '*') Then
      Exit;

  FHTTP.HTTPOptions := FHTTP.HTTPOptions + [hoNoProtocolErrorException];
  if fCfgSis('INTBOV') = 'emp_gold' then
    strURL := 'https://commercial.bvsnet.com.br/EmpresarialXmlBv/bvs/empresarial/gold/4.0?usuario=' + strLogin + '&senha=' + strSenha + '&cnpj=' + strDocumento;

  if fCfgSis('INTBOV') = 'emp_platinum' then
    strURL := 'https://commercial.bvsnet.com.br/SmallBusinessBv/bvs/empresarialplatinum/4.1?usuario=' + strLogin + '&senha=' + strSenha + '&cnpj=' + strDocumento;

  FHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36';
  FHTTP.Request.AcceptEncoding := 'gzip, deflate, br';
  FHTTP.Request.AcceptLanguage := 'pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7';
  FHTTP.Request.CacheControl   := 'max-age=0';
  FHTTP.Request.Connection     := 'keep-alive';
  FHTTP.Request.AcceptCharset  := 'UTF-8';
  FHTTP.Request.Host           := 'commercial.bvsnet.com.br';

  FResp := FHTTP.Get(strURL);
  if FResp.IsEmpty then
    FResp := FHTTp.Response.ResponseText;

  If FHTTP.ResponseCode = 200 Then
  Begin
    FXmlRetorno.LoadFromXML(FResp);
    Result := True;
  End
  Else
  Begin
    FErros.Add('Ocorreu um erro imprevisto na consulta!');
    FErros.Add('Código do erro: ' + IntToStr(FHTTP.ResponseCode));
    FErros.Add('Descrição do erro: ' + FHTTP.ResponseText);
  End;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fFindChildNode(node: IXmlNode;
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
      EndsStr(':' + LowerCase(strChildNodeName), LowerCase(childNode.NodeName)) Then
    Begin
      Result := childNode;
      Break;
    End;
  End;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fGetMsgErro: String;
begin
  Result := FErros.Text;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fGetQtdCheques: Integer;
begin
  if Assigned(FEmpresarial.Cheques_sem_fundo) then
  Begin
    if FEmpresarial.Cheques_sem_fundo.Total_cheques <> '' then
      Result := FEmpresarial.Cheques_sem_fundo.Total_cheques.ToInteger
    Else
      Result := 0;
  End
  Else
    Result := 0;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fGetQtdProtestos: Integer;
begin
  if Assigned(FEmpresarial.Protestos) then
  Begin
    if Assigned(FEmpresarial.Protestos.FTotal) then
    Begin
      if FEmpresarial.Protestos.FTotal.Quantidade <> '' then
        Result := FEmpresarial.Protestos.FTotal.Quantidade.ToInteger
      Else
        Result := 0;
    End
    Else
        Result := 0;
  End
  Else
    Result := 0;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fGetRelatorio: String;
begin
  Result := '';
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fParseErros(node: IXmlNode): Boolean;
var
  childNode: IXmlNode;
  intIndex: Integer;
begin
  If (fFindChildNode(node, 'mensagem_erro') <> nil) Or
     (fFindChildNode(node, 'msg_erro') <> nil)Then
  Begin
    For intIndex := 0 to node.ChildNodes.Count - 1 Do
    Begin
      childNode := node.ChildNodes.get(intIndex);

      If ('mensagem_erro' = childNode.NodeName) Or
         (EndsStr(':mensagem_erro', childNode.NodeName)) Or
         ('msg_erro' = childNode.NodeName) Or
         (EndsStr(':msg_erro', childNode.NodeName))Then
        FErros.Add(childNode.NodeValue);
    End;

    Result := True;
  End
  Else
    Result := False;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fParseNode(strNomeClasse: String;
  node: IXmlNode): TPNodeInfo;

  procedure pGravaLogx(strPai, strProp, strValor: String);
  var
    txtArquivo: TextFile;
    strArqLog: String;
  begin
    strArqLog := ExtractFilePath(Application.ExeName) + '\boa_vista_log.txt';
    AssignFile(txtArquivo, strArqLog);
    Reset(txtArquivo);
    Append(txtArquivo);
    Writeln(txtArquivo, strPai + '->' + strProp + ' -> ' + strValor);
    CloseFile(txtArquivo);
  end;
var
  classe: TClass;
  ctx: TRttiContext;
  tipo: TRttiType;
  propriedades: TArray<TRttiProperty>;
  propriedade: TRttiProperty;
  node_local: IXmlNode;
  strPai: String;
begin
  classe := findClass(strNomeClasse);
  strPai := strNomeClasse;

  If (classe = nil) Or (node = nil) Then
  Begin
    Result := nil;
    Exit;
  End;

  Result := TPNodeInfoClass(classe).Create;

  Try
    ctx := TRttiContext.Create;
    tipo := ctx.GetType(classe.ClassInfo);
    propriedades := tipo.GetProperties();

    For propriedade In propriedades Do
    Begin
      Case propriedade.PropertyType.TypeKind Of
        tkClass:
          If (propriedade.PropertyType.Name = 'TStrings') Then
          Begin
            node_local := fFindChildNode(node, LowerCase(propriedade.Name));
            If node_local <> nil Then
            Begin
              propriedade.SetValue(Result,
                fGetXmlChildValoresEmTStrings(fFindChildNode(node,
                LowerCase(propriedade.Name))));
                pGravaLog(strPai, LowerCase(propriedade.Name), TStrings(fGetXmlChildValoresEmTStrings(fFindChildNode(node,
                                                                LowerCase(propriedade.Name)))).Text);
            End;
          End
          Else
          Begin
            pGravaLog(strPai, propriedade.PropertyType.Name, propriedade.Name);
            If propriedade.PropertyType.Name = 'TPNodeInfoLista' Then
              pAddChildNodes(TPNodeInfoList(propriedade.GetValue(Result).AsObject), node, LowerCase(propriedade.Name))
            Else
            If propriedade.PropertyType.Name = 'TPNodeInfoList' Then
              pAddChildNodes(TPNodeInfoList(propriedade.GetValue(Result).AsObject), fFindChildNode(node, LowerCase(propriedade.Name)), '')
            Else
              propriedade.SetValue(Result,
                fParseNode(propriedade.PropertyType.Name, fFindChildNode(node,
                LowerCase(propriedade.Name))));
          End;

        tkUnknown, tkVariant:
          propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node,
            LowerCase(propriedade.Name))));

        tkInteger, tkInt64:
          propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node,
            LowerCase(propriedade.Name), varInteger)));

        tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
         Begin
            propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node,
              IIF(propriedade.Name <> 'DataOcorrencia', LowerCase(propriedade.Name), 'dataOcorrencia')
                   , varString)));
            pGravaLog(strPai, LowerCase(propriedade.Name), fGetValorXml(node,
              IIF(propriedade.Name <> 'DataOcorrencia', LowerCase(propriedade.Name), 'dataOcorrencia')
                   , varString));
         End;

        tkFloat:
          If (propriedade.PropertyType.Name = 'TDate') Or
            (propriedade.PropertyType.Name = 'TTime') Or
            (propriedade.PropertyType.Name = 'TDateTime') Then
            propriedade.SetValue(Result,
              TValue.FromVariant(fGetValorXml(node, LowerCase(propriedade.Name), varDate,
              'd/m/y', '/')))
          Else
            propriedade.SetValue(Result,
              TValue.FromVariant(fGetValorXml(node, LowerCase(propriedade.Name),
              varDouble)));
      End;
    End;
  Finally
    ctx.Free;
  End;
end;

function TConsultaSCPCBoaVistaEmpresarialPlatinum.fRealizarConsulta(strDocumento,
  strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;

begin
  { pMensagemOk('Rotina de Consulta SCPC pela Boa Vista - ES precisa ser homologada. Por favor, entrar em contato com a Citel.');
    Result := False;
    Exit; }

  FDocConsulta := strDocumento;
  FNomeEmpresa := strNomeEmpresa;

  {***************************************}
  { MUDAR O VALOR DESSA VARÍAVEL APENAS   }
  { QUANDO PRECISAR DEBUGAR. QUANDO TRUE  }
  { IRA GRAVAR UM ARQUIVO TEXTO COM O     }
  { CONTEÚDO DOS OBJETOS.                 }
  {************************************JS*}
  FGeraLogParaHomolocao := False;

  If fConsultaServico(strDocumento) Then
  Begin
    If Not fParseErros(FXmlRetorno.ChildNodes.FindNode('empresarialplatinum')) Then
    Begin
      FEmpresarial := TPEmpresarialPlatinum(fParseNode('TPEmpresarialPlatinum',
        FXmlRetorno.ChildNodes.FindNode('empresarialplatinum')));

      Result := True;
    End
    Else
      Result := False;
  End
  Else
    Result := False;
end;

procedure TConsultaSCPCBoaVistaEmpresarialPlatinum.pAddChildNodes
  (lstList: TPNodeInfoList; node: IXmlNode;  strProp: String);
var
  intIndex: Integer;
  childNode: IXmlNode;
  objChild: TPNodeInfo;
begin
  If node = nil Then
    Exit;

  For intIndex := 0 to node.ChildNodes.Count - 1 Do
  Begin
    If fEmptyStr(strProp) Or (Pos(strProp, node.ChildNodes.get(intIndex).GetNodeName) > 0) Then
    Begin
      childNode := node.ChildNodes.get(intIndex);
      objChild := fParseNode(lstList.getChildClassName, childNode);
      lstList.Add(objChild);
    End;
  End;
end;

procedure TConsultaSCPCBoaVistaEmpresarialPlatinum.pGravaLog(strPai, strProp, strValor: String;
 blnGera: Boolean = False);
var
  txtArquivo: TextFile;
  strArqLog: String;
begin
  If Not FGeraLogParaHomolocao Then
    Exit;

  strArqLog := ExtractFilePath(Application.ExeName) + '\boa_vista_log.txt';
  AssignFile(txtArquivo, strArqLog);

  If blnGera Then
    Rewrite(txtArquivo)
  Else
  Begin
    Reset(txtArquivo);
    Append(txtArquivo);
    Writeln(txtArquivo, strPai + '->' + strProp + ' -> ' + strValor);
  End;

  CloseFile(txtArquivo);
end;

procedure TConsultaSCPCBoaVistaEmpresarialPlatinum.pSaveToFile
  (const strFileName: String);
var
  stlTexto: TStringList;
begin
    If Not DirectoryExists(ExtractFilePath(strFileName)) Then
    fCriaDiretorio(ExtractFilePath(strFileName));

  stlTexto := TStringList.Create;
  Try
    stlTexto.Text := Self.fGetRelatorio;
    stlTexto.SaveToFile(strFileName);

    stlTexto.Text := FResp;
    stlTexto.SaveToFile(AnsiReplaceStr(strFileName, ExtractFileExt(strFileName), '.xml'));

    pSaveToPdf(AnsiReplaceStr(strFileName,
      ExtractFileExt(strFileName), '.pdf'));
  Finally
    FreeAndNil(stlTexto);
  End;
end;

procedure TConsultaSCPCBoaVistaEmpresarialPlatinum.pSaveToPDF(const strFileName: String);
var
  strArquivo,
  strAuxiliar,
  strCaminho: String;
  dtsOrigem,
  dtsDestino,
  dtsDestinoDet: TUniClientDataSet;

  function fCriaDataSetPainel(AOwner: TComponent) : TUniClientDataSet;
  begin

    Result := TUniClientDataSet.Create(AOwner);
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'Nome';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CpfCnpj';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'Capital';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'Atualizacao';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'QuantidadeAdm';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'Descricao';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'Quantidade';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'Ultima';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := 'Valor';
      DataType := ftString;
      Size := 120;
      Required := False;
    End;
  end;

  function fCriaDataSet(AOwner: TComponent; classe: TPNodeInfo;
    dataset: TUniClientDataSet; propriedade_ori: String): TUniClientDataSet;
  var
    ctx: TRttiContext;
    tipo: TRttiType;
    propriedades: TArray<TRttiProperty>;
    propriedade: TRttiProperty;
    strProp: String;
  begin
    If dataset = nil Then
      Result := TUniClientDataSet.Create(AOwner)
    Else
      Result := dataset;

    if Not Assigned(classe) then
      Exit;

    Try
      ctx := TRttiContext.Create;
      tipo := ctx.GetType(classe.ClassInfo);
      propriedades := tipo.GetProperties();

      For propriedade In propriedades Do
      Begin
        strProp := IIF(fEmptyStr(propriedade_ori), propriedade.Name,propriedade_ori+'-'+propriedade.Name);
        Case propriedade.PropertyType.TypeKind Of
          tkUString:
            Begin
              With Result.FieldDefs.AddFieldDef Do
              Begin
                Name := strProp;
                If LowerCase(strProp) = 'filiais-cidades' Then
                Begin
                  DataType := ftBlob;
                  Size     := 80;
                End
                Else
                Begin
                  DataType := ftString;
                  Size := 120;
                End;

                Required := False;
              End;
            End;
          tkClass:
            Begin
              If (propriedade.PropertyType.Name = 'TStrings') Then
              Begin
                With Result.FieldDefs.AddFieldDef Do
                Begin
                  Name := strProp;
                  If LowerCase(strProp) = 'filiais-cidades' Then
                  Begin
                    DataType := ftBlob;
                    Size     := 80;
                  End
                  Else
                  Begin
                    DataType := ftString;
                    Size := 300;
                    Required := False;
                  End;
                End;
              End
              Else
              If (propriedade.PropertyType.Name <> 'TPNodeInfoList') And
                 (propriedade.PropertyType.Name <> 'TPNodeInfoLista') Then
                Result:= fCriaDataSet(AOwner, TPNodeInfo(propriedade.GetValue(classe).AsObject), Result, propriedade.Name);
            End;
        End;
      End;

    Finally
      ctx.Free;
    End;
  end;

  function fGravaDataSet(classe: TPNodeInfo; dataset: TUniClientDataSet; propriedade_ori: String)
    : TUniClientDataSet;
  var
    ctx: TRttiContext;
    tipo: TRttiType;
    propriedades: TArray<TRttiProperty>;
    propriedade: TRttiProperty;
    strProp : String;
  begin
    Result := dataset;

    If classe = nil Then
      Exit;

    Try
      ctx := TRttiContext.Create;
      tipo := ctx.GetType(classe.ClassInfo);
      propriedades := tipo.GetProperties();

      For propriedade In propriedades Do
      Begin
        strProp := IIF(fEmptyStr(propriedade_ori),propriedade.Name, propriedade_ori+'-'+propriedade.Name);
        Case propriedade.PropertyType.TypeKind Of
          tkUString:
            Begin
              dataset.FieldByName(strProp).AsString := propriedade.GetValue(classe).AsString;
            End;
          tkClass:
            Begin
              If (propriedade.PropertyType.Name = 'TStrings') Then
              Begin
                If propriedade.GetValue(classe).AsObject <> nil Then
                Begin
                  dataset.FieldByName(strProp).AsString := TStrings(propriedade.GetValue(classe).AsObject).CommaText;
  //                dataset:= fGravaDataSet(TPNodeInfo(propriedade.GetValue(classe).AsObject), dataset, propriedade.Name)
                End;
              End
              Else
              If (propriedade.PropertyType.Name <> 'TPNodeInfoList') Then
                dataset:= fGravaDataSet(TPNodeInfo(propriedade.GetValue(classe).AsObject), dataset, propriedade.Name);
            End;
        End;
      End;

    Finally
      Result := dataset;
      ctx.Free;
    End;

  end;

  function fGetDataSet(AOwner: TComponent; classe: TPNodeInfo)
    : TUniClientDataSet;
  begin
    Result := fCriaDataSet(AOwner, classe, nil, '');
    Result.CreateDataSet;
    Result.Open;

    Result.Append;
    Result := fGravaDataSet(classe, Result, '');
    Result.Post;
  end;

  function fGetDataSetList(AOwner: TComponent; ocorrencias: TPNodeInfoList)
    : TUniClientDataSet;
  var
    ocorrencia: TPNodeInfo;
  begin

    Result := nil;

    Try

      For ocorrencia In ocorrencias Do
      Begin
        If Result = nil Then
        Begin
          Result := fCriaDataSet(AOwner, ocorrencia, nil, '');
          Result.CreateDataSet;
          Result.Open;
        End;

        Result.Append;
        Result := fGravaDataSet(ocorrencia, Result, '');
        Result.Post;
      End;

    Finally
      if not Assigned(Result) then
      Begin
        Result := TUniClientDataSet.Create(nil);
        Result.FieldDefs.add('EmptyDataSet', ftString, 50);
        Result.CreateDataSet;
      End;
    End;

  end;

  function fRetEmptyDataSet:TUniClientDataSet;
  Begin
    Result := TUniClientDataSet.Create(nil);
    Result.FieldDefs.add('EmptyDataSet', ftString, 50);
    Result.CreateDataSet;
  End;

  procedure pPreparaDataSetPainel;
  var
    strQuantidade,
    strUltima,
    strValor: String;

    dtaData,
    dtaDataMaior: TDateTime;

    intAno,
    intMes,
    intDia,
    intQtde: Integer;

    fltValor: Double;

    procedure pLimpaVariaveis;
    begin
      intAno   := 0;
      intMes   := 0;
      intDia   := 0;
      intQtde  := 0;
      dtaData  := 0;
      dtaDataMaior := 0;
      fltValor := 0;

      strQuantidade := '-';
      strUltima     := '-';
      strValor      := '-';
    end;

  begin
    pLimpaVariaveis;

    dtsDestino := fCriaDataSetPainel(Self);
    dtsDestino.CreateDataSet;
    dtsDestino.Open;

    If Assigned(fEmpresarial.FConsultas) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FConsultas.FUltimas_consultas);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          Try
            intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
            intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
            intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
            dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
          Except

          End;

          If dtaData > dtaDataMaior Then
            dtaDataMaior := dtaData;

          Next;
        End;
      End;

      strUltima     := FormatDateTime('mm/yyyy', dtaDataMaior);
      strQuantidade := fEmpresarial.FConsultas.FQuantidade_total;

    End;

    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Consultas';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;

    pLimpaVariaveis;

    If Assigned(fEmpresarial.FTitulos_a_vencer) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FTitulos_a_vencer.FTitulos_a_vencer_periodo);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          Try
            intQtde  := intQtde + StrToInt(FieldByName('Qtd_titulos').AsString);
            fltValor := fltValor + strToFloat(StringReplace(FieldByName('Valor').AsString, '.', ',', []));
          Except

          End;

          Next;
        End;
      End;

      strUltima     := '-';
      strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');

    End;

    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Títulos a Vencer';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;

    pLimpaVariaveis;

    If Assigned(fEmpresarial.FHistorico_pagamentos) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FHistorico_pagamentos.FItem);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          If (strUltima='-') And (LowerCase(FieldByName('Total').AsString) <> 'total') Then
          Begin
            strUltima := FieldByName('Total').AsString;
            Break;
          End;

          IF LowerCase(FieldByName('Total').AsString) = 'total' Then
          Begin
            Try
              intQtde  := StrToInt(FieldByName('Titulos').AsString);
              fltValor := strToFloat(StringReplace(FieldByName('Valor_total').AsString, '.', ',', []));
            Except

            End;
          End;

          Next;
        End;
      End;

      strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');

    End;

    If (strUltima.Length = 6) Then
      strUltima.Insert(3, '/');
    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Comportamento de Pagamentos';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;

    pLimpaVariaveis;

    If Assigned(fEmpresarial.FPendencias_restricoes) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FPendencias_restricoes.FLista_pendencias_restricoes);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          Try
            intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
            intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
            intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
            dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
          Except

          End;

          If dtaData > dtaDataMaior Then
            dtaDataMaior := dtaData;

          Next;
        End;
      End;

      If Assigned(fEmpresarial.FPendencias_restricoes.FTotal_pendencias) Then
      Begin
        strUltima     := FormatDateTime('mm/yyyy', dtaDataMaior);
        strQuantidade := fEmpresarial.FPendencias_restricoes.FTotal_pendencias.FQtd_pendencias;
        fltValor      := strToFloat(StringReplace(fEmpresarial.FPendencias_restricoes.FTotal_pendencias.FValor, '.', ',', []));
        strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');
      End;
    End;

    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Pendências e Restrições Financeiras';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;

    pLimpaVariaveis;

    If Assigned(fEmpresarial.FCheques_sustado) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FCheques_sustado.FCheque_sustado);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          Try
            intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
            intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
            intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
            dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
          Except

          End;

          If dtaData > dtaDataMaior Then
            dtaDataMaior := dtaData;

          Next;
        End;
      End;

      strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
      strQuantidade := IIF(Not fEmptyStr(fEmpresarial.FCheques_sustado.FTotal_cheques),
                           fEmpresarial.FCheques_sustado.FTotal_cheques, '-');
    End;

    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Cheques Sustados - Motivo 21';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;

    pLimpaVariaveis;

    If Assigned(fEmpresarial.FCheques_sem_fundo) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FCheques_sem_fundo.FCheque_sem_fundo);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          Try
            intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
            intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
            intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
            dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
          Except

          End;

          If dtaData > dtaDataMaior Then
            dtaDataMaior := dtaData;

          Next;
        End;
      End;

      strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
      strQuantidade := IIF(Not fEmptyStr(fEmpresarial.FCheques_sem_fundo.FTotal_cheques),
                           fEmpresarial.FCheques_sem_fundo.FTotal_cheques, '-');

    End;

    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Cheques sem Fundo';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;

    pLimpaVariaveis;

    If Assigned(fEmpresarial.FProtestos) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FProtestos.FLista_protestos);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          Try
            intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
            intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
            intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
            dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
          Except

          End;

          If dtaData > dtaDataMaior Then
            dtaDataMaior := dtaData;

          Next;
        End;
      End;

      If Assigned(fEmpresarial.FProtestos.FTotal) Then
      Begin
        strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
        strQuantidade := IIF(Not fEmptyStr(fEmpresarial.FProtestos.FTotal.FQuantidade),
                             fEmpresarial.FProtestos.FTotal.FQuantidade, '-');
        fltValor      := strToFloat(StringReplace(fEmpresarial.FProtestos.FTotal.FValor, '.', ',', []));
        strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');
      End;
    End;

    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Protestos';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;

    pLimpaVariaveis;

    If Assigned(fEmpresarial.FRecuperacoes_falencias_acoes) Then
    Begin
      dtsOrigem  := fGetDataSetList(Self,  fEmpresarial.FRecuperacoes_falencias_acoes);
      dtsOrigem.First;
      With dtsOrigem Do
      Begin

        While Not dtsOrigem.EOF Do
        Begin
          Try
            intQtde  := intQtde + StrToInt(FieldByName('Quantidade').AsString);
            intDia   := StrToInt(Copy(FieldByName('Data_ultima_ocorrencia').AsString, 1, 2));
            intMes   := StrToInt(Copy(FieldByName('Data_ultima_ocorrencia').AsString, 3, 2));
            intAno   := StrToInt(Copy(FieldByName('Data_ultima_ocorrencia').AsString, 5, 4));
            dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
          Except

          End;

          If dtaData > dtaDataMaior Then
            dtaDataMaior := dtaData;

          Next;
        End;
      End;

      strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
      strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
    End;

    dtsDestino.Append;
    dtsDestino.FieldByName('Descricao').AsString  := 'Recuperação, Falências e Ações Judiciais';
    dtsDestino.FieldByName('Quantidade').AsString := strQuantidade;
    dtsDestino.FieldByName('Ultima').AsString     := strUltima;
    dtsDestino.FieldByName('Valor').AsString      := strValor;
    dtsDestino.Post;
  end;

  procedure pPreparaDataSetPainelAdmin(FAdministradores: TPAdministradoresPlatinum);
  var
    strQuantidade,
    strUltima,
    strValor: String;

    dtaData,
    dtaDataMaior: TDateTime;

    intAno,
    intMes,
    intDia,
    intQtde: Integer;

    fltValor: Double;

    administrador: TPNodeInfo;

    procedure pLimpaVariaveis;
    begin
      intAno   := 0;
      intMes   := 0;
      intDia   := 0;
      intQtde  := 0;
      dtaData  := 0;
      dtaDataMaior := 0;
      fltValor := 0;

      strQuantidade := '-';
      strUltima     := '-';
      strValor      := '-';
    end;

  begin
    dtsDestino := fCriaDataSetPainel(Self);
    dtsDestino.CreateDataSet;
    dtsDestino.Open;

    dtsDestinoDet := fCriaDataSetPainel(Self);
    dtsDestinoDet.CreateDataSet;
    dtsDestinoDet.Open;

    For administrador In FAdministradores.Administradores_pj Do
    Begin

      // Consultas PJ
      pLimpaVariaveis;

      dtsDestino.Append;
      dtsDestino.FieldByName('Nome').AsString          := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestino.FieldByName('CpfCnpj').AsString       := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestino.FieldByName('QuantidadeAdm').AsString := FAdministradores.FQuantidade;
      dtsDestino.FieldByName('Atualizacao').AsString   := FAdministradores.FAtu_junta_coml;
      dtsDestino.Post;

      If Assigned(TPAdministradorPj(administrador).FConsultas) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPj(administrador).FConsultas.FUltimas_consultas);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := FormatDateTime('mm/yyyy', dtaDataMaior);
        strQuantidade := '-';
        If TPAdministradorPj(administrador).FConsultas <> Nil Then
        Begin
          intQtde       := IIF(Not fEmptyStr(TPAdministradorPj(administrador).FConsultas.FQuantidade_total),
                               StrToInt(TPAdministradorPj(administrador).FConsultas.FQuantidade_total), 0);
          strQuantidade := IIF(intQtde>0, IntToStr(intQtde), '-');
        End;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Consultas';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Títulos a Vencer PJ

      pLimpaVariaveis;

      If Assigned(TPAdministradorPj(administrador).FTitulos_a_vencer) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPj(administrador).FTitulos_a_vencer.FTitulos_a_vencer_periodo);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intQtde  := intQtde + StrToInt(FieldByName('Qtd_titulos').AsString);
              fltValor := fltValor + strToFloat(StringReplace(FieldByName('Valor').AsString, '.', ',', []));
            Except

            End;

            Next;
          End;
        End;

        strUltima     := '-';
        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
        strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');

      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Títulos a Vencer';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Pagamentos PJ

      pLimpaVariaveis;

      If Assigned(TPAdministradorPj(administrador).FHistorico_pagamentos) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPj(administrador).FHistorico_pagamentos.FItem);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            If (strUltima='-') And (LowerCase(FieldByName('Total').AsString) <> 'total') Then
            Begin
              strUltima := FieldByName('Total').AsString;
              Break;
            End;

            IF LowerCase(FieldByName('Total').AsString) = 'total' Then
            Begin
              Try
                intQtde  := StrToInt(FieldByName('Titulos').AsString);
                fltValor := strToFloat(StringReplace(FieldByName('Valor_total').AsString, '.', ',', []));
              Except

              End;
            End;

            Next;
          End;
        End;

        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
        strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');

      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Pagamentos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Pendencias e Restrições PJ

      pLimpaVariaveis;

      If Assigned(TPAdministradorPj(administrador).FPendencias_restricoes) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPj(administrador).FPendencias_restricoes.FLista_pendencias_restricoes);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        If Assigned(TPAdministradorPj(administrador).FPendencias_restricoes.FTotal_pendencias) Then
        Begin
          strUltima     := FormatDateTime('mm/yyyy', dtaDataMaior);
          strQuantidade := TPAdministradorPj(administrador).FPendencias_restricoes.FTotal_pendencias.FQtd_pendencias;
          fltValor      := strToFloat(StringReplace(TPAdministradorPj(administrador).FPendencias_restricoes.FTotal_pendencias.FValor, '.', ',', []));
          strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');
        End;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Pendências e Restrições Financeiras';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Cheques sem Fundo PJ
      pLimpaVariaveis;

      If Assigned(TPAdministradorPj(administrador).FCheques_sem_fundo) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPj(administrador).FCheques_sem_fundo.FCheque_sem_fundo);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intQtde  := intQtde + StrToInt(FieldByName('Quantidade').AsString);
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0, FormatDateTime('mm/yyyy', dtaDataMaior), '-');
        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Cheques sem Fundo';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Protestos PJ
      pLimpaVariaveis;

      If Assigned(TPAdministradorPj(administrador).FProtestos) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPj(administrador).FProtestos.FLista_protestos);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0, FormatDateTime('mm/yyyy', dtaDataMaior), '-');
        If TPAdministradorPj(administrador).FProtestos.FTotal <> Nil Then
        Begin
          strQuantidade := TPAdministradorPj(administrador).FProtestos.FTotal.FQuantidade;
          strValor      := StringReplace(TPAdministradorPj(administrador).FProtestos.FTotal.FValor, '.', ',', []);
          strValor      := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(strValor));
        End;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Protestos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Ações Judiciais PJ
      pLimpaVariaveis;

      If Assigned(TPAdministradorPj(administrador).FRecuperacoes_falencias_acoes) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPj(administrador).FRecuperacoes_falencias_acoes);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intQtde  := intQtde + StrToInt(FieldByName('Quantidade').AsString);
              intDia   := StrToInt(Copy(FieldByName('data_ultima_ocorrencia').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('data_ultima_ocorrencia').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('data_ultima_ocorrencia').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0, FormatDateTime('mm/yyyy', dtaDataMaior), '-');
        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Recuperações, Falências e Ações Judiciais';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Outras Participações PJ
      pLimpaVariaveis;

      If Assigned(TPAdministradorPj(administrador).FParticipacoes) Then
      Begin
        Try
          intQtde  := StrToInt(TPAdministradorPj(administrador).FParticipacoes.FQtd_outras_participacoes);
        Except

        End;

        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPj(administrador).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPj(administrador).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Outras Participações';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

    End;

    For administrador In FAdministradores.Administradores_pf Do
    Begin
      dtsDestino.Append;
      dtsDestino.FieldByName('Nome').AsString          := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestino.FieldByName('CpfCnpj').AsString       := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestino.FieldByName('QuantidadeAdm').AsString := FAdministradores.FQuantidade;
      dtsDestino.FieldByName('Atualizacao').AsString   := FAdministradores.FAtu_junta_coml;
      dtsDestino.Post;

      // Consultas PF
      pLimpaVariaveis;

      If Assigned(TPAdministradorPf(administrador).FConsultas) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPAdministradorPf(administrador).FConsultas.FUltimos);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
        strQuantidade := '-';
        If TPAdministradorPf(administrador).FConsultas.FResumo <> Nil Then
        Begin
          intQtde       := IIF(Not fEmptyStr(TPAdministradorPf(administrador).FConsultas.FResumo.FQtd_total),
                               StrToInt(TPAdministradorPf(administrador).FConsultas.FResumo.FQtd_total), 0);
          strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
        End;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Consultas';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Registro de Débitos PF

      pLimpaVariaveis;

      If Assigned(TPAdministradorPf(administrador).FRegistro_debitos.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPAdministradorPf(administrador).FRegistro_debitos.FResumo.FData_ultimo, 1, 2));
          intMes   := StrToInt(Copy(TPAdministradorPf(administrador).FRegistro_debitos.FResumo.FData_ultimo, 3, 2));
          intAno   := StrToInt(Copy(TPAdministradorPf(administrador).FRegistro_debitos.FResumo.FData_ultimo, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;


        strUltima     := IIF(dtaData>0, FormatDateTime('mm/yyyy', dtaData), '-');
        strQuantidade := TPAdministradorPf(administrador).FRegistro_debitos.FResumo.FQtd_total;
        strValor      := StringReplace(TPAdministradorPf(administrador).FRegistro_debitos.FResumo.FValor_total, '.', ',', []);
        strValor      := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(strValor));
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Registro de Débitos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Cheques sem Fundo PF
      pLimpaVariaveis;

      If Assigned(TPAdministradorPf(administrador).FCheques_sem_fundo.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPAdministradorPf(administrador).FCheques_sem_fundo.FResumo.FDataUltimo, 1, 2));
          intMes   := StrToInt(Copy(TPAdministradorPf(administrador).FCheques_sem_fundo.FResumo.FDataUltimo, 3, 2));
          intAno   := StrToInt(Copy(TPAdministradorPf(administrador).FCheques_sem_fundo.FResumo.FDataUltimo, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;

        strUltima     := FormatDateTime('mm/yyyy', dtaData);
        strQuantidade := TPAdministradorPf(administrador).FCheques_sem_fundo.FResumo.FQtdTotal;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Cheques sem Fundo';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Protestos PF
      pLimpaVariaveis;

      If Assigned(TPAdministradorPf(administrador).FProtestos.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPAdministradorPf(administrador).FProtestos.FResumo.FDataUltimo, 1, 2));
          intMes   := StrToInt(Copy(TPAdministradorPf(administrador).FProtestos.FResumo.FDataUltimo, 3, 2));
          intAno   := StrToInt(Copy(TPAdministradorPf(administrador).FProtestos.FResumo.FDataUltimo, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;


        strUltima     := IIF(dtaData>0, FormatDateTime('mm/yyyy', dtaData), '-');
        strQuantidade := TPAdministradorPf(administrador).FProtestos.FResumo.FQtdTotal;
        strValor      := StringReplace(TPAdministradorPf(administrador).FProtestos.FResumo.FValorTotal, '.', ',', []);
        strValor      := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(strValor));
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Protestos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Ações Judiciais PF
      pLimpaVariaveis;

      If Assigned(TPAdministradorPf(administrador).FAcoes_civeis.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPAdministradorPf(administrador).FAcoes_civeis.FResumo.FData_ultima, 1, 2));
          intMes   := StrToInt(Copy(TPAdministradorPf(administrador).FAcoes_civeis.FResumo.FData_ultima, 3, 2));
          intAno   := StrToInt(Copy(TPAdministradorPf(administrador).FAcoes_civeis.FResumo.FData_ultima, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;

        strUltima     := IIF(dtaData>0, FormatDateTime('mm/yyyy', dtaData), '-');
        strQuantidade := TPAdministradorPf(administrador).FAcoes_civeis.FResumo.FQtd_total;
        strValor      := StringReplace(TPAdministradorPf(administrador).FAcoes_civeis.FResumo.FValor_total, '.', ',', []);
        strValor      := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(strValor));
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Ações Judiciais';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Falências Empresariais PF
      pLimpaVariaveis;

      If Assigned(TPAdministradorPf(administrador).FFalencias_empresariais.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPAdministradorPf(administrador).FFalencias_empresariais.FResumo.FData_ultima, 1, 2));
          intMes   := StrToInt(Copy(TPAdministradorPf(administrador).FFalencias_empresariais.FResumo.FData_ultima, 3, 2));
          intAno   := StrToInt(Copy(TPAdministradorPf(administrador).FFalencias_empresariais.FResumo.FData_ultima, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;

        strUltima     := FormatDateTime('mm/yyyy', dtaData);
        strQuantidade := TPAdministradorPf(administrador).FFalencias_empresariais.FResumo.FQtd_total;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Falências Empresariais';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Outras Participações PF
      pLimpaVariaveis;

      If Assigned(TPAdministradorPf(administrador).FParticipacoes_empresas.FResumo) Then
      Begin
        Try
          intQtde := StrToInt(TPAdministradorPf(administrador).FParticipacoes_empresas.FResumo.FQuantidade);
        Except

        End;

        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPAdministradorPf(administrador).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPAdministradorPf(administrador).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Outras Participações';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

    End;

  end;

  procedure pPreparaDataSetPainelSocios(FSocios: TPSociosPlatinum);
  var
    strQuantidade,
    strUltima,
    strValor: String;

    dtaData,
    dtaDataMaior: TDateTime;

    intAno,
    intMes,
    intDia,
    intQtde: Integer;

    fltValor: Double;

    socio: TPNodeInfo;

    procedure pLimpaVariaveis;
    begin
      intAno   := 0;
      intMes   := 0;
      intDia   := 0;
      intQtde  := 0;
      dtaData  := 0;
      dtaDataMaior := 0;
      fltValor := 0;

      strQuantidade := '-';
      strUltima     := '-';
      strValor      := '-';
    end;

  begin
    dtsDestino := fCriaDataSetPainel(Self);
    dtsDestino.CreateDataSet;
    dtsDestino.Open;

    dtsDestinoDet := fCriaDataSetPainel(Self);
    dtsDestinoDet.CreateDataSet;
    dtsDestinoDet.Open;

    For socio In FSocios.Socios_pj Do
    Begin

      // Consultas PJ
      pLimpaVariaveis;

      dtsDestino.Append;
      dtsDestino.FieldByName('Nome').AsString        := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestino.FieldByName('CpfCnpj').AsString     := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestino.FieldByName('Capital').AsString     := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(StringReplace(FSocios.FCapital_social, '.', ',', [])));
      dtsDestino.FieldByName('Atualizacao').AsString := FSocios.FAtu_junta_coml;
      dtsDestino.Post;

      If Assigned(TPSocioPJ(socio).FConsultas) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPJ(socio).FConsultas.Fconsultas_mes);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := 1;
              intMes   := StrToInt(Copy(FieldByName('Mes_Ano').AsString, 1, 2));
              intAno   := StrToInt(Copy(FieldByName('Mes_Ano').AsString, 3, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
              intQtde  := IIF(Not fEmptyStr(FieldByName('Quantidade').AsString),
                              StrToInt(FieldByName('Quantidade').AsString), 0);
            Except

            End;

            If (dtaData > dtaDataMaior) And (intQtde > 0) Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0, FormatDateTime('mm/yyyy', dtaDataMaior), '-');
        intQtde       := IIF(Not fEmptyStr(TPSocioPJ(socio).FConsultas.FQuantidade_total),
                             StrToInt(TPSocioPJ(socio).FConsultas.FQuantidade_total),0);
        strQuantidade := IIF(intQtde>0,IntToStr(intQtde), '-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Consultas';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Títulos a Vencer PJ

      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FTitulos_a_vencer) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPJ(socio).FTitulos_a_vencer.FTitulos_a_vencer_periodo);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intQtde  := intQtde + StrToInt(FieldByName('Qtd_titulos').AsString);
              fltValor := fltValor + strToFloat(StringReplace(FieldByName('Valor').AsString, '.', ',', []));
            Except

            End;

            Next;
          End;
        End;

        strUltima     := '-';
        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
        strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');

      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Títulos a Vencer';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Pagamentos PJ

      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FHistorico_pagamentos) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPJ(socio).FHistorico_pagamentos.FItem);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            If (strUltima='-') And (LowerCase(FieldByName('Total').AsString) <> 'total') Then
            Begin
              strUltima := FieldByName('Total').AsString;
              Break;
            End;

            IF LowerCase(FieldByName('Total').AsString) = 'total' Then
            Begin
              Try
                intQtde  := StrToInt(FieldByName('Titulos').AsString);
                fltValor := strToFloat(StringReplace(FieldByName('Valor_total').AsString, '.', ',', []));
              Except

              End;
            End;

            Next;
          End;
        End;

        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
        strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');

      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Pagamentos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Pendencias e Restrições PJ

      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FPendencias_restricoes) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPJ(socio).FPendencias_restricoes.FLista_pendencias_restricoes);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        If Assigned(TPSocioPJ(socio).FPendencias_restricoes.FTotal_pendencias) Then
        Begin
          strUltima     := IIF(dtaDataMaior>0, FormatDateTime('mm/yyyy', dtaDataMaior), '-');
          strQuantidade := TPSocioPJ(socio).FPendencias_restricoes.FTotal_pendencias.FQtd_pendencias;
          fltValor      := strToFloat(StringReplace(TPSocioPJ(socio).FPendencias_restricoes.FTotal_pendencias.FValor, '.', ',', []));
          strValor      := IIF(fltValor>0,FormatFloat('#,##0.00;-#,##0.00', fltValor),'-');
        End;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Pendências e Restrições Financeiras';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Cheques sem Fundo PJ
      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FCheques_sem_fundo) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPJ(socio).FCheques_sem_fundo.FCheque_sem_fundo);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intQtde  := intQtde + StrToInt(FieldByName('Quantidade').AsString);
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Cheques sem Fundo';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Protestos PJ
      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FProtestos) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPJ(socio).FProtestos.FLista_protestos);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        If Assigned(TPSocioPJ(socio).FProtestos.FTotal) Then
        Begin
          strUltima     := IIF(dtaDataMaior>0, FormatDateTime('mm/yyyy', dtaDataMaior), '-');
          strQuantidade := TPSocioPJ(socio).FProtestos.FTotal.FQuantidade;
          strValor      := StringReplace(TPSocioPJ(socio).FProtestos.FTotal.FValor, '.', ',', []);
          strValor      := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(strValor));
        End;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Protestos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Ações Judiciais PJ
      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FRecuperacoesFalenciasAcoes) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPJ(socio).FRecuperacoesFalenciasAcoes);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intQtde  := intQtde + StrToInt(FieldByName('Quantidade').AsString);
              intDia   := StrToInt(Copy(FieldByName('data_ultima_ocorrencia').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('data_ultima_ocorrencia').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('data_ultima_ocorrencia').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Recuperações, Falências e Ações Judiciais';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Sócios e Administradores PJ
      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FSocios) Then
      Begin
        Try
          intQtde  := StrToInt(TPSocioPJ(socio).FSocios.FQtd_outros_socios);
        Except

        End;
      End;

      If Assigned(TPSocioPJ(socio).FAdministradores) Then
      Begin
        Try
          intQtde  := intQtde + StrToInt(TPSocioPJ(socio).FAdministradores.FQuantidade);
        Except

        End;
      End;

      strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Sócios e Administradores';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Outras Participações PJ
      pLimpaVariaveis;

      If Assigned(TPSocioPJ(socio).FParticipacoes) Then
      Begin
        Try
          intQtde  := StrToInt(TPSocioPJ(socio).FParticipacoes.FQtd_outras_participacoes);
        Except

        End;

        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPJ(socio).FIdentificacao.FRazao_social;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPJ(socio).FIdentificacao.FCnpj;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Outras Participações';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

    End;

    For socio In FSocios.Socios_pf Do
    Begin
      dtsDestino.Append;
      dtsDestino.FieldByName('Nome').AsString        := TPSocioPF(socio).FIdentificacao.FNome;
      dtsDestino.FieldByName('CpfCnpj').AsString     := TPSocioPF(socio).FIdentificacao.FCpf;
      dtsDestino.FieldByName('Capital').AsString     := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(StringReplace(FSocios.FCapital_social, '.', ',', [])));
      dtsDestino.FieldByName('Atualizacao').AsString := FSocios.FAtu_junta_coml;
      dtsDestino.Post;

      // Consultas PF
      pLimpaVariaveis;

      If Assigned(TPSocioPF(socio).FConsultas) Then
      Begin
        dtsOrigem  := fGetDataSetList(Self,  TPSocioPF(socio).FConsultas.FUltimos);
        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            Try
              intDia   := StrToInt(Copy(FieldByName('Data').AsString, 1, 2));
              intMes   := StrToInt(Copy(FieldByName('Data').AsString, 3, 2));
              intAno   := StrToInt(Copy(FieldByName('Data').AsString, 5, 4));
              dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
            Except

            End;

            If dtaData > dtaDataMaior Then
              dtaDataMaior := dtaData;

            Next;
          End;
        End;

        strUltima     := IIF(dtaDataMaior>0,FormatDateTime('mm/yyyy', dtaDataMaior),'-');
        If TPSocioPF(socio).FConsultas.FResumo <> Nil Then
        Begin
          intQtde       := IIF(Not fEmptyStr(TPSocioPF(socio).FConsultas.FResumo.FQtd_total),
                               StrToInt(TPSocioPF(socio).FConsultas.FResumo.FQtd_total), 0);
          strQuantidade := IIF(intQtde>0,IntToStr(intQtde), '-');
        End;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPF(socio).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPF(socio).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Consultas';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Registro de Débitos PF

      pLimpaVariaveis;

      If Assigned(TPSocioPF(socio).FRegistro_debitos.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPSocioPF(socio).FRegistro_debitos.FResumo.FData_ultimo, 1, 2));
          intMes   := StrToInt(Copy(TPSocioPF(socio).FRegistro_debitos.FResumo.FData_ultimo, 3, 2));
          intAno   := StrToInt(Copy(TPSocioPF(socio).FRegistro_debitos.FResumo.FData_ultimo, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;

        strUltima     := IIF(dtaData>0, FormatDateTime('mm/yyyy', dtaData), '-');
        strQuantidade := TPSocioPF(socio).FRegistro_debitos.FResumo.FQtd_total;
        strValor      := StringReplace(TPSocioPF(socio).FRegistro_debitos.FResumo.FValor_total, '.', ',', []);
        strValor      := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(strValor));
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPF(socio).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPF(socio).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Registro de Débitos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Cheques sem Fundo PF
      pLimpaVariaveis;

      If Assigned(TPSocioPF(socio).FCheques_sem_fundo.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPSocioPF(socio).FCheques_sem_fundo.FResumo.FDataUltimo, 1, 2));
          intMes   := StrToInt(Copy(TPSocioPF(socio).FCheques_sem_fundo.FResumo.FDataUltimo, 3, 2));
          intAno   := StrToInt(Copy(TPSocioPF(socio).FCheques_sem_fundo.FResumo.FDataUltimo, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;

        strUltima     := IIF(dtaData>0, FormatDateTime('mm/yyyy', dtaData), '-');
        strQuantidade := TPSocioPF(socio).FCheques_sem_fundo.FResumo.FQtdTotal;
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPF(socio).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPF(socio).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Cheques sem Fundo';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Protestos PF
      pLimpaVariaveis;

      If Assigned(TPSocioPF(socio).FProtestos.FResumo) Then
      Begin
        Try
          intDia   := StrToInt(Copy(TPSocioPF(socio).FProtestos.FResumo.FDataUltimo, 1, 2));
          intMes   := StrToInt(Copy(TPSocioPF(socio).FProtestos.FResumo.FDataUltimo, 3, 2));
          intAno   := StrToInt(Copy(TPSocioPF(socio).FProtestos.FResumo.FDataUltimo, 5, 4));
          dtaData  := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
        Except

        End;


        strUltima     := IIF(dtaData>0, FormatDateTime('mm/yyyy', dtaData), '-');
        strQuantidade := TPSocioPF(socio).FProtestos.FResumo.FQtdTotal;
        strValor      := StringReplace(TPSocioPF(socio).FProtestos.FResumo.FValorTotal, '.', ',', []);
        strValor      := FormatFloat('#,##0.00;-#,##0.00', StrToFloat(strValor));
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPF(socio).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPF(socio).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Protestos';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

      // Outras Participações PF
      pLimpaVariaveis;

      If Assigned(TPSocioPF(socio).FParticipacoes_empresas.FResumo) Then
      Begin
        Try
          intQtde  := StrToInt(TPSocioPF(socio).FParticipacoes_empresas.FResumo.FQuantidade);
        Except

        End;

        strQuantidade := IIF(intQtde>0,IntToStr(intQtde),'-');
      End;

      dtsDestinoDet.Append;
      dtsDestinoDet.FieldByName('Nome').AsString       := TPSocioPF(socio).FIdentificacao.FNome;
      dtsDestinoDet.FieldByName('CpfCnpj').AsString    := TPSocioPF(socio).FIdentificacao.FCpf;
      dtsDestinoDet.FieldByName('Descricao').AsString  := 'Outras Participações';
      dtsDestinoDet.FieldByName('Quantidade').AsString := strQuantidade;
      dtsDestinoDet.FieldByName('Ultima').AsString     := strUltima;
      dtsDestinoDet.FieldByName('Valor').AsString      := strValor;
      dtsDestinoDet.Post;

    End;

  end;

begin
  pCriarFormularios(TfrmQckConsultaSCPCEmpresarialPlatinum, frmQckConsultaSCPCEmpresarialPlatinum);

  with frmQckConsultaSCPCEmpresarialPlatinum do
  begin
    frxReport.PrintOptions.ShowDialog := False;
    TfrxMemoView(frxReport.FindObject('memInfConf')).Text := 'INFORMAÇÕES CONFIDENCIAIS, ' + FormatDateTime('dd/mm/yyyy', VS_Date);

    if Assigned(FEmpresarial.FIdentificacao) then
    Begin
      frxIdent.DataSet := fGetDataSet(Self, FEmpresarial.FIdentificacao);
      //If frxIdent.DataSet.FindField('ramo_atividade_secundario-atividade') = Nil Then
      //Begin
      //  TfrxMemoView(frxReport.FindObject('Memo86')).Visible := False;

      //End;
    End
    Else
      frxIdent.DataSet :=  fRetEmptyDataSet;


    TfrxMemoView(frxReport.FindComponent('rllNadaConstaAnaliseSet')).Visible := Not Assigned(FEmpresarial.FAnaliseSetorial);
    if Assigned(FEmpresarial.FAnaliseSetorial) Then
      frxAnaSet.DataSet := fGetDataSet(Self, FEmpresarial.FAnaliseSetorial)
    else
      frxAnaSet.DataSet := fRetEmptyDataSet;

    if Assigned(FEmpresarial.FRepresentanteLegal) Then
      frxRepLeg.DataSet  := fGetDataSet(Self, FEmpresarial.FRepresentanteLegal)
    Else
      frxRepLeg.DataSet  := fRetEmptyDataSet;

    {if Assigned(FEmpresarial.FPainel_controle) Then
      frxPainel.DataSet := fGetDataSetList(Self, FEmpresarial.FPainel_controle)
    else
      frxPainel.DataSet := fRetEmptyDataSet;}

    if Assigned(FEmpresarial.Flocalizacao) Then
      frxLocal.DataSet  := fGetDataSet(Self, FEmpresarial.FLocalizacao)
    Else
      frxLocal.DataSet  := fRetEmptyDataSet;

    pPreparaDataSetPainel;
    frxPainel.DataSet := dtsDestino;

    pPreparaDataSetPainelSocios(fEmpresarial.FSocios);
    frxSocios.DataSet    := dtsDestino;
    frxSociosDet.DataSet := dtsDestinoDet;
    TfrxMemoView(frxReport.FindComponent('rllNadaConstaSocios')).Visible := dtsDestino.RecordCount = 0;

    pPreparaDataSetPainelAdmin(fEmpresarial.FAdministradores);
    frxAdmin.DataSet    := dtsDestino;
    frxAdminDet.DataSet := dtsDestinoDet;
    TfrxMemoView(frxReport.FindComponent('rllNadaConstaAdms')).Visible := dtsDestino.RecordCount = 0;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaSuaEmp')).Visible := (Not Assigned(FEmpresarial.FComportamento_com_sua_empresa)) Or
                                   (Pos('nada consta', LowerCase(FEmpresarial.FComportamento_com_sua_empresa.Mensagem)) > 0);
    if Not TfrxMemoView(frxReport.FindComponent('rllNadaConstaSuaEmp')).Visible Then
    Begin
      If Assigned(fEmpresarial.fComportamento_com_sua_empresa.FConsultante) Then
      Begin
        dtsOrigem  := fGetDataSet(Self,  fEmpresarial.fComportamento_com_sua_empresa.FConsultante);
        dtsDestino := fCriaDataSet(Self, fEmpresarial.fComportamento_com_sua_empresa.FConsultante, nil, '');
        dtsDestino.CreateDataSet;
        dtsDestino.Open;

        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            dtsDestino.Append;
            dtsDestino.FieldByName('Tipo').AsString               := 'Consultante';
            dtsDestino.FieldByName('Qtde_tit_vencer').AsString    := FieldByName('Qtde_tit_vencer').AsString;
            dtsDestino.FieldByName('Valor_vencer').AsString       := FieldByName('Valor_vencer').AsString;
            dtsDestino.FieldByName('Qtde_tit_pagos').AsString     := FieldByName('Qtde_tit_pagos').AsString;
            dtsDestino.FieldByName('Valor_pagos').AsString        := FieldByName('Valor_pagos').AsString;
            dtsDestino.FieldByName('Qtde_tit_vencidos').AsString  := FieldByName('Qtde_tit_vencidos').AsString;
            dtsDestino.FieldByName('Valor_vencidos').AsString     := FieldByName('Valor_vencidos').AsString;
            dtsDestino.FieldByName('Pago_a_vista').AsString       := FieldByName('Pago_a_vista').AsString;
            dtsDestino.FieldByName('Pago_pontual').AsString       := FieldByName('Pago_pontual').AsString;
            dtsDestino.FieldByName('Dias_atraso_1').AsString      := FieldByName('Dias_atraso_1').AsString;
            dtsDestino.FieldByName('Dias_atraso_2').AsString      := FieldByName('Dias_atraso_2').AsString;
            dtsDestino.FieldByName('Dias_atraso_3').AsString      := FieldByName('Dias_atraso_3').AsString;
            dtsDestino.FieldByName('Dias_atraso_4').AsString      := FieldByName('Dias_atraso_4').AsString;
            dtsDestino.FieldByName('Atraso_medio').AsString       := FieldByName('Atraso_medio').AsString;
            dtsDestino.Post;

            Next;
          End;
        End;
      End;

      If Assigned(fEmpresarial.fComportamento_com_sua_empresa.FSegmento) Then
      Begin
        dtsOrigem  := fGetDataSet(Self,  fEmpresarial.fComportamento_com_sua_empresa.FSegmento);
        If Not Assigned(dtsDestino) Then
        Begin
          dtsDestino := fCriaDataSet(Self, fEmpresarial.fComportamento_com_sua_empresa.FSegmento, nil, '');
          dtsDestino.CreateDataSet;
          dtsDestino.Open;
        End;

        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            dtsDestino.Append;
            dtsDestino.FieldByName('Tipo').AsString               := 'Segmento';
            dtsDestino.FieldByName('Qtde_tit_vencer').AsString    := FieldByName('Qtde_tit_vencer').AsString;
            dtsDestino.FieldByName('Valor_vencer').AsString       := FieldByName('Valor_vencer').AsString;
            dtsDestino.FieldByName('Qtde_tit_pagos').AsString     := FieldByName('Qtde_tit_pagos').AsString;
            dtsDestino.FieldByName('Valor_pagos').AsString        := FieldByName('Valor_pagos').AsString;
            dtsDestino.FieldByName('Qtde_tit_vencidos').AsString  := FieldByName('Qtde_tit_vencidos').AsString;
            dtsDestino.FieldByName('Valor_vencidos').AsString     := FieldByName('Valor_vencidos').AsString;
            dtsDestino.Post;

            Next;
          End;
        End;
      End;

      If Assigned(fEmpresarial.fComportamento_com_sua_empresa.FMercado) Then
      Begin
        dtsOrigem  := fGetDataSet(Self,  fEmpresarial.fComportamento_com_sua_empresa.FMercado);
        If Not Assigned(dtsDestino) Then
        Begin
          dtsDestino := fCriaDataSet(Self, fEmpresarial.fComportamento_com_sua_empresa.FMercado, nil, '');
          dtsDestino.CreateDataSet;
          dtsDestino.Open;
        End;

        dtsOrigem.First;
        With dtsOrigem Do
        Begin

          While Not dtsOrigem.EOF Do
          Begin
            dtsDestino.Append;
            dtsDestino.FieldByName('Tipo').AsString               := 'Mercado';
            dtsDestino.FieldByName('Qtde_tit_vencer').AsString    := FieldByName('Qtde_tit_vencer').AsString;
            dtsDestino.FieldByName('Valor_vencer').AsString       := FieldByName('Valor_vencer').AsString;
            dtsDestino.FieldByName('Qtde_tit_pagos').AsString     := FieldByName('Qtde_tit_pagos').AsString;
            dtsDestino.FieldByName('Valor_pagos').AsString        := FieldByName('Valor_pagos').AsString;
            dtsDestino.FieldByName('Qtde_tit_vencidos').AsString  := FieldByName('Qtde_tit_vencidos').AsString;
            dtsDestino.FieldByName('Valor_vencidos').AsString     := FieldByName('Valor_vencidos').AsString;
            dtsDestino.Post;

            Next;
          End;
        End;
      End;

      If Assigned(dtsDestino) Then
        frxComportamentoSuaEmpresa.DataSet := dtsDestino
      Else
        frxComportamentoSuaEmpresa.DataSet := fRetEmptyDataSet;
    End
    else
      frxComportamentoSuaEmpresa.DataSet := fRetEmptyDataSet;

    if Assigned(FEmpresarial.Fparticipacoes) Then
    begin
      TfrxMemoView(frxReport.FindComponent('rllNadaConstaParticip')).Visible := fEmptyStr(FEmpresarial.Fparticipacoes.FQuantidade);

      frxPartic.DataSet       := fGetDataSet(Self, FEmpresarial.Fparticipacoes);
      if Assigned(FEmpresarial.Fparticipacoes.FEmpresas) Then
        frxParticDet.DataSet    := fGetDataSetList(Self, FEmpresarial.Fparticipacoes.FEmpresas)
      else
        frxParticDet.DataSet := fRetEmptyDataSet;
    end
    else
    Begin
      frxPartic.DataSet := fRetEmptyDataSet;
      frxParticDet.DataSet := fRetEmptyDataSet;
    End;

    if Assigned(FEmpresarial.Fconsultas) Then
    Begin
      frxConsul.DataSet       := fGetDataSet(Self, FEmpresarial.Fconsultas);

      if Assigned(FEmpresarial.Fconsultas.Fultimas_consultas) Then
        frxConsulDet.DataSet    := fGetDataSetList(Self, FEmpresarial.Fconsultas.Fultimas_consultas)
      else
        frxConsulDet.DataSet := fRetEmptyDataSet;

      if Assigned(FEmpresarial.Fconsultas.Fconsultas_mes) Then
        frxConsulMes.DataSet    := fGetDataSetList(Self, FEmpresarial.Fconsultas.Fconsultas_mes)
      else
        frxConsulMes.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxConsul.DataSet := fRetEmptyDataSet;
      frxConsulDet.DataSet := fRetEmptyDataSet;
      frxConsulMes.DataSet := fRetEmptyDataSet;
    End;

    if Assigned(FEmpresarial.Ftempo_relacionamento_fornecedores) Then
      frxRelForn.DataSet := fGetDataSet(Self, FEmpresarial.Ftempo_relacionamento_fornecedores)
    else
      frxRelForn.DataSet := fRetEmptyDataSet;

    if Assigned(FEmpresarial.FTitulos_a_vencer.FTitulos_a_vencer_periodo) Then
      frxTitVencer.DataSet := fGetDataSetList(Self, FEmpresarial.FTitulos_a_vencer.FTitulos_a_vencer_periodo)
    Else
      frxTitVencer.DataSet := fRetEmptyDataSet;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaTitVenc')).Visible := frxTitVencer.DataSet.RecordCount = 0;

    if Assigned(FEmpresarial.Fhistorico_pagamentos) Then
    Begin
      if Assigned(FEmpresarial.Fhistorico_pagamentos.Fitem) Then
        frxHistPag.DataSet      := fGetDataSetList(Self, fEmpresarial.fhistorico_pagamentos.fitem)
      else
        frxHistPag.DataSet := fRetEmptyDataSet;
    End
    else
      frxHistPag.DataSet := fRetEmptyDataSet;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaPagamentos')).Visible := frxHistPag.DataSet.RecordCount = 0;

    if Assigned(FEmpresarial.Freferenciais_negocios) Then
    Begin
      if Assigned(FEmpresarial.Freferenciais_negocios.FUltima_compra) then
      begin
        if Not Assigned(frxRefNeg.DataSet) then
        Begin
          frxRefNeg.DataSet       := fGetDataSet(Self, FEmpresarial.Freferenciais_negocios.FUltima_compra);
          frxRefNeg.DataSet.Edit;
          frxRefNeg.DataSet.FieldByName('Descricao').AsString := 'Última Compra';
          frxRefNeg.DataSet.Post;
        End;
      end;

      if Assigned(FEmpresarial.Freferenciais_negocios.FMaior_fatura) then
      begin
        if Not Assigned(frxRefNeg.DataSet) then
        Begin
          frxRefNeg.DataSet       := fGetDataSet(Self, FEmpresarial.Freferenciais_negocios.FMaior_fatura);
          frxRefNeg.DataSet.Edit;
          frxRefNeg.DataSet.FieldByName('Descricao').AsString := 'Maior Fatura';
          frxRefNeg.DataSet.Post;
        End
        else
        begin
          frxRefNeg.DataSet.Append;
          frxRefNeg.DataSet.FieldByName('Data').AsString := FEmpresarial.Freferenciais_negocios.FMaior_fatura.FData;
          frxRefNeg.DataSet.FieldByName('Valor').AsString := FEmpresarial.Freferenciais_negocios.FMaior_fatura.FValor;
          frxRefNeg.DataSet.FieldByName('Media').AsString := FEmpresarial.Freferenciais_negocios.FMaior_fatura.FMedia;
          frxRefNeg.DataSet.FieldByName('Descricao').AsString := 'Maior Fatura';
          frxRefNeg.DataSet.Post;
        end;

      end;

      if Assigned(FEmpresarial.Freferenciais_negocios.FMaior_credito) then
      begin
        if Not Assigned(frxRefNeg.DataSet) then
        Begin
          frxRefNeg.DataSet       := fGetDataSet(Self, FEmpresarial.Freferenciais_negocios.FMaior_credito);
          frxRefNeg.DataSet.Edit;
          frxRefNeg.DataSet.FieldByName('Descricao').AsString := 'Maior Crédito';
          frxRefNeg.DataSet.Post;
        End
        else
        begin
          frxRefNeg.DataSet.Append;
          frxRefNeg.DataSet.FieldByName('Data').AsString  := FEmpresarial.Freferenciais_negocios.FMaior_credito.FData;
          frxRefNeg.DataSet.FieldByName('Valor').AsString := FEmpresarial.Freferenciais_negocios.FMaior_credito.FValor;
          frxRefNeg.DataSet.FieldByName('Media').AsString := FEmpresarial.Freferenciais_negocios.FMaior_credito.FMedia;
          frxRefNeg.DataSet.FieldByName('Descricao').AsString := 'Maior Crédito';
          frxRefNeg.DataSet.Post;
        end;
      end;

      if Not Assigned(frxRefNeg.DataSet) then
        frxRefNeg.DataSet := fRetEmptyDataSet;
    End
    Else
      frxRefNeg.DataSet := fRetEmptyDataSet;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaRefer')).Visible := frxRefNeg.DataSet.RecordCount = 0;

    if Assigned(FEmpresarial.Fpendencias_restricoes) Then
    Begin
      frxPendRestr.DataSet    := fGetDataSet(Self, FEmpresarial.Fpendencias_restricoes);

      if Assigned(FEmpresarial.Fpendencias_restricoes.Flista_pendencias_restricoes) Then
        frxPendRestrDet.DataSet := fGetDataSetList(Self, FEmpresarial.Fpendencias_restricoes.Flista_pendencias_restricoes)
      else
        frxPendRestrDet.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxPendRestr.DataSet := fRetEmptyDataSet;
      frxPendRestrDet.DataSet := fRetEmptyDataSet;
    End;
    TfrxMemoView(frxReport.FindComponent('rllNadaConstaPendRestr')).Visible := frxPendRestrDet.DataSet.RecordCount = 0;

    if Assigned(FEmpresarial.Fcheques_sustado) Then
    Begin
      frxChqSust.DataSet      := fGetDataSet(Self, FEmpresarial.Fcheques_sustado);

      if Assigned(FEmpresarial.Fcheques_sustado.Fcheque_sustado) Then
        frxChqSustDet.DataSet   := fGetDataSetList(Self, FEmpresarial.Fcheques_sustado.Fcheque_sustado)
      else
        frxChqSustDet.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxChqSust.DataSet := fRetEmptyDataSet;
      frxChqSustDet.DataSet := fRetEmptyDataSet;
    End;
    TfrxMemoView(frxReport.FindComponent('rllNadaConstaChequeSus')).Visible := frxChqSustDet.DataSet.RecordCount = 0;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaSemFundo')).Visible := (Not Assigned(FEmpresarial.Fcheques_sem_fundo)) Or
                                   (Pos('nada consta', LowerCase(FEmpresarial.Fcheques_sem_fundo.Mensagem)) > 0);
    if Not TfrxMemoView(frxReport.FindComponent('rllNadaConstaSemFundo')).Visible Then
    Begin
      frxChqSemF.DataSet      := fGetDataSet(Self, FEmpresarial.Fcheques_sem_fundo);

      if Assigned(FEmpresarial.Fcheques_sem_fundo.Fcheque_sem_fundo) Then
        frxChqSemFDet.DataSet   := fGetDataSetList(Self, FEmpresarial.Fcheques_sem_fundo.Fcheque_sem_fundo)
      else
        frxChqSemFDet.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxChqSemF.DataSet := fRetEmptyDataSet;
      frxChqSemFDet.DataSet := fRetEmptyDataSet;
    End;

    if Assigned(FEmpresarial.Fprotestos) Then
    Begin
      frxProtestos.DataSet    := fGetDataSet(Self, FEmpresarial.Fprotestos);

      if Assigned(FEmpresarial.Fprotestos.Flista_protestos) Then
        frxProtestosDet.DataSet := fGetDataSetList(Self, FEmpresarial.Fprotestos.Flista_protestos)
      else
        frxProtestosDet.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxProtestos.DataSet := fRetEmptyDataSet;
      frxProtestosDet.DataSet := fRetEmptyDataSet;
    End;
    TfrxMemoView(frxReport.FindComponent('rllNadaConstaProtestos')).Visible := frxProtestosDet.DataSet.RecordCount = 0;

    if Assigned(FEmpresarial.Frecuperacoes_falencias_acoes) Then
    Begin
      if Assigned(FEmpresarial.FRecuperacoes_falencias_acoes) Then
        frxRecuper.DataSet      := fGetDataSetList(Self, FEmpresarial.Frecuperacoes_falencias_acoes)
      else
        frxRecuper.DataSet := fRetEmptyDataSet;
    End
    Else
      frxRecuper.DataSet := fRetEmptyDataSet;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaRecuper')).Visible :=
          (frxRecuper.DataSet.Recordcount = 0) Or (Pos(LowerCase(frxRecuper.DataSet.FieldByName('mensagem').AsString), 'nada consta') > 0);

    if Assigned(FEmpresarial.Finformacoes_mais_recentes) Then
    Begin
      if Assigned(FEmpresarial.Finformacoes_mais_recentes.Finformacao) Then
        frxInfo.DataSet         := fGetDataSetList(Self, FEmpresarial.Finformacoes_mais_recentes.Finformacao)
      else
        frxInfo.DataSet := fRetEmptyDataSet;
    End
    else
      frxInfo.DataSet := fRetEmptyDataSet;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaInfo')).Visible := frxInfo.DataSet.RecordCount = 0;

    strCaminho  := Copy(strFileName, 1, Length(strFileName)-23);
    strAuxiliar := Copy(strFileName, Pos('CONSULTA_CREDITO\', strFileName) + 17, Length(strFileName));
    strArquivo  := Copy(strAuxiliar, Pos('\', strAuxiliar)+1, Length(strAuxiliar));

    frxReport.PrepareReport;
    frxExpPDF.FileName    := strArquivo;
    frxExpPDF.DefaultPath := strCaminho;
    frxExpPDF.ShowDialog  := False;
    frxReport.Export(frxExpPDF);
    pLog('pSaveToPDF->'+strFileName);
    ShellExecute(Application.Handle,'open',PChar(strFileName), '','',SW_SHOWNORMAL);

    pMensagemOk('Arquivo de consulta gerado na pasta: ' + strCaminho);

  end;

  FreeAndNil(frmQckConsultaSCPCEmpresarialPlatinum);
end;

{ TPEmpresarialPlatinum }

constructor TPEmpresarialPlatinum.Create;
begin
  inherited;
  Fpainel_controle := TPNodeInfoList.Create('TPPainelControle');
  FRecuperacoes_falencias_acoes := TPNodeInfoList.Create('TPRecuperacaoFalencia');
end;

destructor TPEmpresarialPlatinum.Destroy;
begin
  FreeAndNil(Fpainel_controle);
  FreeAndNil(FRecuperacoes_falencias_acoes);
  inherited;
end;

function TPEmpresarialPlatinum.fGetRelatorio: String;
begin
  Result := '';

end;

{ TPLocalizacao }

destructor TPLocalizacao.Destroy;
begin
  FreeAndNil(Ftelefones);
  inherited;
end;

function TPLocalizacao.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result +
    '--------------------------------------------------' + #13#10;
  Result := Result +
    '                   LOCALIZAÇÃO                    ' + #13#10;
  Result := Result +
    '--------------------------------------------------' + #13#10;
  Result := Result + 'Endereço:                ' + Fendereco + #13#10;
  Result := Result + 'Bairro:                  ' + Fbairro + #13#10;
  Result := Result + 'Cidade:                  ' + Fcidade + #13#10;
  Result := Result + 'UF:                      ' + Fuf + #13#10;
  Result := Result + 'CEP:                     ' + Fcep + #13#10;
  Result := Result + Fmatriz.fGetRelatorio + #13#10;

  If (Ftelefones <> nil) And (Ftelefones.Count > 0) Then
  Begin
    Result := Result + 'Telefones:               ' + Ftelefones.Strings
      [0] + #13#10;
    For intIdx := 1 To Ftelefones.Count - 1 Do
      Result := Result + '                         ' + Ftelefones.Strings
        [intIdx] + #13#10;
  End;

  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TPIdentificacao }

destructor TPIdentificacao.Destroy;
begin
  FreeAndNil(Fprincipais_produtos);
  inherited;
end;

function TPIdentificacao.fGetRelatorio: String;
var
  intIdx: Integer;
  strRazaoAnterior: String;
  strDataFundacao: String;
  strDataEncerramento: String;
  strConsultaCNPJ: String;
begin
  strRazaoAnterior    := Copy(Fdata_razao_anterior, 1, 2) + '/' + Copy(Fdata_razao_anterior, 3, 2) + '/' + Copy(Fdata_razao_anterior, 5, Length(Fdata_razao_anterior));
  strDataFundacao     := Copy(Fdata_fundacao, 1,2) + '/' + Copy(Fdata_fundacao, 3, Length(Fdata_fundacao));
  strDataEncerramento := Copy(Fdata_encerramento, 1, 2) + '/' + Copy(Fdata_encerramento, 3, 2) + '/' + Copy(Fdata_encerramento, 5, Length(Fdata_encerramento));
  strConsultaCNPJ     := Copy(Fdata_consulta_cnpj, 1, 2) + '/' + Copy(Fdata_consulta_cnpj, 3, 2) + '/' + Copy(Fdata_consulta_cnpj, 5, Length(Fdata_consulta_cnpj));

  Result := '';
  Result := Result +
    '--------------------------------------------------' + #13#10;
  Result := Result +
    '                   IDENTIFICAÇÃO                  ' + #13#10;
  Result := Result +
    '--------------------------------------------------' + #13#10;
  Result := Result + 'Cnpj:                    ' + Fcnpj + #13#10;
  Result := Result + 'Razão social:            ' + Frazao_social + #13#10;
  Result := Result + 'Razão social anterior:   ' + Frazao_social_anterior + #13#10;
  Result := Result + 'Data razao anterior:     ' + strRazaoAnterior + #13#10;
  Result := Result + 'Nome fantasia:           ' + Fnome_fantasia + #13#10;
  Result := Result + 'Data da fundação:        ' + strDataFundacao + #13#10;
  Result := Result + 'Data do encerramento:    ' + Fdata_encerramento + #13#10;
  Result := Result + 'Situação Cnpj:           ' + Fsituacao_cnpj + #13#10;
  Result := Result + 'Data consulta Cnpj:      ' + strConsultaCNPJ + #13#10;
  Result := Result + 'Natureza Jurídica:       ' + Fnatureza_juridica + #13#10;
  Result := Result + 'Faixa funcionários:      ' + Ffaixa_funcionarios + #13#10;
  If Assigned(Fnire) Then
    Result := Result + Fnire.fGetRelatorio + #13#10;
  If Assigned(Fsintegra) Then
    Result := Result + Fsintegra.fGetRelatorio + #13#10;
  If Assigned(Finscricao_estadual) Then
    Result := Result + Finscricao_estadual.fGetRelatorio + #13#10;
  If Assigned(Ffiliais) Then
    Result := Result + Ffiliais.fGetRelatorio + #13#10;
  If Assigned(Ffiliais) Then
    Result := Result + Framo_atividade.fGetRelatorio + #13#10;
  If Assigned(Framo_atividade_secundario) Then
    Result := Result + Framo_atividade_secundario.fGetRelatorio + #13#10;

  If (Fprincipais_produtos <> nil) And (Fprincipais_produtos.Count > 0) Then
  Begin
    Result := Result + 'Principais produtos:     ' +
      Fprincipais_produtos.Strings[0] + #13#10;
    For intIdx := 1 To Fprincipais_produtos.Count - 1 Do
      Result := Result + '                         ' +
        Fprincipais_produtos.Strings[intIdx] + #13#10;
  End;

  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;


end;

{ TPFarmaciaDrogaria }

constructor TPFarmaciaDrogaria.Create;
begin
  inherited Create;
  Fautorizacoes := TPNodeInfoList.Create('TPAutorizacao');
end;

destructor TPFarmaciaDrogaria.Destroy;
begin
  FreeAndNil(Fautorizacoes);
  inherited;
end;

function TPFarmaciaDrogaria.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + 'Farmácia / Drogaria:     ' + #13#10 + #13#10;
  Result := Result + '  Resp. Legal:           ' + Fresp_legal + #13#10;
  Result := Result + '  Resp. Técnico:         ' + Fresp_tecnico + #13#10;
  Result := Result + '  2.o Resp. Legal:       ' + Fsegundo_resp_legal + #13#10;
  Result := Result + '  2.o Resp. Técnico:     ' +
    Fsegundo_resp_tecnico + #13#10;
  Result := Result + '  3.o Resp. Legal:       ' + Fterceiro_resp_legal
    + #13#10;
  Result := Result + '  3.o Resp. Técnico:     ' +
    Fterceiro_resp_tecnico + #13#10;

  If Fautorizacoes.Count > 0 Then
    Result := Result + #13#10 + '  Autorizações: ' + #13#10;

  For intIdx := 0 To Fautorizacoes.Count - 1 Do
    Result := Result + Fautorizacoes.Items[intIdx].fGetRelatorio();
end;

{ TPDistribuidores }

constructor TPDistribuidores.Create;
begin
  inherited Create;
  Fautorizacoes := TPNodeInfoList.Create('TPAutorizacao');
end;

destructor TPDistribuidores.Destroy;
begin
  FreeAndNil(Fautorizacoes);
  inherited;
end;

function TPDistribuidores.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := #13#10;
  Result := Result + 'Distribuidor:            ' + #13#10 + #13#10;
  Result := Result + '  Resp. Legal:           ' + Fresp_legal + #13#10;
  Result := Result + '  Resp. Técnico:         ' + Fresp_tecnico + #13#10;
  Result := Result + '  2.o Resp. Legal:       ' + Fsegundo_resp_legal + #13#10;
  Result := Result + '  2.o Resp. Técnico:     ' +
    Fsegundo_resp_tecnico + #13#10;
  Result := Result + '  3.o Resp. Legal:       ' + Fterceiro_resp_legal
    + #13#10;
  Result := Result + '  3.o Resp. Técnico:     ' +
    Fterceiro_resp_tecnico + #13#10;

  If Fautorizacoes.Count > 0 Then
    Result := Result + #13#10 + '  Autorizações: ';

  For intIdx := 0 To Fautorizacoes.Count - 1 Do
    Result := Result + Fautorizacoes.Items[intIdx].fGetRelatorio();

end;

{ TPAutorizacao }

function TPAutorizacao.fGetRelatorio: String;
var
  strDataAutorizacao: String;
begin
  strDataAutorizacao := Copy(Fdata_autorizacao, 1, 2) + '/' + Copy(Fdata_autorizacao, 3, 2) + '/' + Copy(Fdata_autorizacao, 5, Length(Fdata_autorizacao));

  Result := #13#10;
  Result := Result + '    Autorização    :     ' + Fautorizacao + #13#10;
  Result := Result + '    Situação       :     ' + Fsituacao + #13#10;
  Result := Result + '    Data           :     ' + strDataAutorizacao + #13#10;
  Result := Result + '    Num. Processo  :     ' + Fnum_processo + #13#10;
  Result := Result + '    Tipo Aut.      :     ' + Ftipo_autorizacao + #13#10;
  Result := Result + '    Tipo Aut. 2    :     ' + Ftipo_autorizacao2 + #13#10;
  Result := Result + '    Classe Ativid. :     ' + Fclasse_atividade + #13#10;
end;

{ TPPrincipaisProdutos }

function TPPrincipaisProdutos.fGetRelatorio: String;
begin

end;

{ TPRamoAtividadeSecundario }

function TPRamoAtividadeSecundario.fGetRelatorio: String;
begin
  Result := Result + 'Ramo Ativ. Sec.:         ' + Fatividade + #13#10;
  Result := Result + 'Ramo Ativ. Sec. CNAE:    ' + Fcnae + #13#10;
end;

{ TPRamoAtividade }

function TPRamoAtividade.fGetRelatorio: String;
begin
  Result := Result + 'Ramo Ativ. :             ' + Fatividade + #13#10;
  Result := Result + 'Ramo Ativ. CNAE:         ' + Fcnae + #13#10;
end;

{ TPNire }

function TPNire.fGetRelatorio: String;
begin
  Result := Result + 'Nire Nro:                ' + Fnumero + #13#10;
  Result := Result + 'Nire UF:                 ' + Fuf + #13#10;
end;

{ TPFiliais }

function TPFiliais.fGetRelatorio: String;
begin
  Result := 'Filiais:' + #13#10;
  Result := Result + ' Quantidade:             ' + Fquantidade + #13#10;
  Result := Result + ' Cidades:                ' + Fcidades + #13#10;
end;

{ TPInscricaoEstadual }

function TPInscricaoEstadual.fGetRelatorio: String;
begin
  Result := Result + 'Inscr. Est. UF      :    ' + Fuf + #13#10;
  Result := Result + 'Inscr. Est. Cadadtro:    ' + Fcadastro + #13#10;
end;

{ TPSintegra }

function TPSintegra.fGetRelatorio: String;
var
  strData, strDataConsulta: String;
begin
  strData         := Copy(Fdata, 1, 2) + '/' + Copy(Fdata, 3, 2) + '/' + Copy(Fdata, 5, Length(Fdata));
  strDataConsulta := Copy(Fdata_consulta, 1, 2) + '/' + Copy(Fdata_consulta, 3, 2) + '/' + Copy(Fdata_consulta, 5, Length(Fdata_consulta));

  Result := 'Sintegra:' + #13#10;
  Result := Result + '  Situação:              ' + Fsituacao + #13#10;
  Result := Result + '  Data:                  ' + strData + #13#10;
  Result := Result + '  Data consulta:         ' + strDataConsulta + #13#10;
end;

{ TPMatriz }

function TPMatriz.fGetRelatorio: String;
begin
  Result := 'Matriz:' + #13#10;
  Result := Result + '  Endereço      :    ' + Fendereco + #13#10;
  Result := Result + '  Bairro        :    ' + Fbairro + #13#10;
  Result := Result + '  Cidade        :    ' + Fcidade + #13#10;
  Result := Result + '  UF            :    ' + Fuf + #13#10;
  Result := Result + '  CEP           :    ' + Fcep + #13#10;
end;

{ TPModeloScore }

function TPModeloScore.fGetRelatorio: String;
begin

end;

{ TPScore }

function TPScore.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                  SCORE CRÉDITO                   ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10 + #13#10;

  // Result := Result + 'Modelo:                  ' + Fmodelo_score + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TPAlerta }

function TPAlerta.fGetRelatorio: String;
var
  strData: String;
begin
  strData := Copy(Fdata, 1, 2) + '/' + Copy(Fdata, 3, 2) + '/' + Copy(Fdata, 5, Length(Fdata));

  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                ALERTA DE FRAUDES                 ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10 + #13#10;

  Result := Result + 'Data:                    ' + Fdata + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TPFaturamentoPresumido }

function TPFaturamentoPresumido.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '               FATURAMENTO PRESUMIDO              ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10 + #13#10;

  Result := Result + 'Descrição Natureza:      ' + Fdescricao_natureza + #13#10;
  Result := Result + 'Descrição Modelo:        ' + Fdescricao_modelo + #13#10;
  Result := Result + 'Faixa:                   ' + Ffaixa + #13#10;
  Result := Result + 'Faturamento Anual:       ' + Ffaturamento_anual + #13#10;
  Result := Result + 'Texto:                   ' + Ftexto + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TPPainelControle }


function TPPainelControle.fGetRelatorio: String;
begin
end;

{ TPSegmento }

function TPSegmento.fGetRelatorio: String;
begin
  Result := #13#10;
  Result := ' Qtde. Títulos a vencer: ' + Fqtde_tit_vencer + #13#10;
  Result := ' Valor Títulos a vencer: ' + Fvalor_vencer + #13#10;
  Result := ' Qtde. Títulos pagos:    ' + Fqtde_tit_pagos + #13#10;
  Result := ' Valor Títulos pagos:    ' + Fvalor_pagos + #13#10;
  Result := ' Qtde. Títulos vencidos: ' + Fqtde_tit_vencidos + #13#10;
  Result := ' Valor Títulos vencidos: ' + Fvalor_vencidos + #13#10;
end;

{ TPMercado }

function TPMercado.fGetRelatorio: String;
begin
  Result := #13#10;
  Result := ' Qtde. Títulos a vencer: ' + Fqtde_tit_vencer + #13#10;
  Result := ' Valor Títulos a vencer: ' + Fvalor_vencer + #13#10;
  Result := ' Qtde. Títulos pagos:    ' + Fqtde_tit_pagos + #13#10;
  Result := ' Valor Títulos pagos:    ' + Fvalor_pagos + #13#10;
  Result := ' Qtde. Títulos vencidos: ' + Fqtde_tit_vencidos + #13#10;
  Result := ' Valor Títulos vencidos: ' + Fvalor_vencidos + #13#10;
end;

{ TPConsultante }

function TPConsultante.fGetRelatorio: String;
begin
  Result := #13#10;
  Result := ' Qtde. Títulos a vencer: ' + Fqtde_tit_vencer + #13#10;
  Result := ' Valor Tot. Tít. vencer: ' + Fvalor_vencer + #13#10;
  Result := ' Qtde. Títulos pagos:    ' + Fqtde_tit_pagos + #13#10;
  Result := ' Valor Tot. Tít. pagos:  ' + Fvalor_pagos + #13#10;
  Result := ' Qtde. Títulos vencidos: ' + Fqtde_tit_vencidos + #13#10;
  Result := ' Valor Tot. Tít. venc:   ' + Fvalor_vencidos + #13#10;
  Result := ' % de Pagamento a vista: ' + Fpago_a_vista + #13#10;
  Result := ' % Pag. pontual Tít Pag: ' + Fpago_pontual + #13#10;
  Result := ' % de Dias Atraso 6-15:  ' + Fdias_atraso_1 + #13#10;
  Result := ' % de Dias Atraso 16-30: ' + Fdias_atraso_2 + #13#10;
  Result := ' % de Dias Atraso 31-60: ' + Fdias_atraso_3 + #13#10;
  Result := ' % de Dias Atraso +60:   ' + Fdias_atraso_4 + #13#10;
  Result := ' Média de Atraso:        ' + Fatraso_medio + #13#10;
end;

function TPComportamentoEmpresa.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '          COMPORTAMENTO COM SUA EMPRESA           ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10 + #13#10;

  If fEmptyStr(Fmensagem) Then
  Begin
    Result := Result + 'Consultante:             ' + Fconsultante.fGetRelatorio + #13#10;
    Result := Result + 'Segmento:                ' + Fsegmento.fGetRelatorio + #13#10;
    Result := Result + 'Mercado:                 ' + Fmercado.fGetRelatorio + #13#10;
  End
  Else
    Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TOcorrencia }


{ TPParticipacoes }

constructor TPParticipacoes.Create;
begin
  inherited;
  Fempresa := TPNodeInfoLista.Create('TPEmpresa');
end;

destructor TPParticipacoes.Destroy;
begin
  inherited;
  FreeAndNil(Fempresa);
end;

function TPParticipacoes.fGetRelatorio: String;
begin

end;

{ TPConsultas }

constructor TPConsultas.Create;
begin
  inherited;
  Fconsultas_mes := TPNodeInfoLista.Create('TPConsultaMes');
  Fultimas_consultas := TPNodeInfoList.Create('TPConsulta');
end;

destructor TPConsultas.Destroy;
begin
  inherited;
  FreeAndNil(Fconsultas_mes);
  FreeAndNil(Fultimas_consultas);
end;

function TPConsultas.fGetRelatorio: String;
begin

end;

{ TPAteDataAnterior }

function TPAteDataAnterior.fGetRelatorio: String;
begin

end;

{ TPConsulta }

function TPConsulta.fGetRelatorio: String;
begin

end;

{ TPConsultaMes }

function TPConsultaMes.fGetRelatorio: String;
begin

end;

{ TPEmpresa }

function TPEmpresa.fGetRelatorio: String;
begin

end;

{ TPRepresentanteLegal }

function TPRepresentanteLegal.fGetRelatorio: String;
begin

end;

{ TPTempoRelFornecedores }

function TPTempoRelFornecedores.fGetRelatorio: String;
begin

end;

{ TPTitulosAVencer }

constructor TPTitulosAVencer.Create;
begin
  inherited;
  FTitulos_a_vencer_periodo := TPNodeInfoLista.Create('TPTituloAVencer');
end;

destructor TPTitulosAVencer.Destroy;
begin
  inherited;
  FreeAndNil(FTitulos_a_vencer_periodo);
end;

function TPTitulosAVencer.fGetRelatorio: String;
begin

end;

{ TPTituloAVencer }

function TPTituloAVencer.fGetRelatorio: String;
begin

end;

{ TPHistoricoPagamentos }

constructor TPHistoricoPagamentos.Create;
begin
  inherited;
  Fitem := TPNodeInfoLista.Create('TPItemHistorico');
end;

destructor TPHistoricoPagamentos.Destroy;
begin
  inherited;
  FreeAndNil(Fitem);
end;

function TPHistoricoPagamentos.fGetRelatorio: String;
begin

end;

{ TPItemHistorico }

function TPItemHistorico.fGetRelatorio: String;
begin

end;

{ TPReferencialNegocio }

function TPReferencialNegocio.fGetRelatorio: String;
begin

end;

{ TPReferenciaisNegocios }

function TPReferenciaisNegocios.fGetRelatorio: String;
begin

end;

{ TPPrincipaisFornecedores }

constructor TPPrincipaisFornecedores.Create;
begin
  inherited;
  Ffornecedor := TPNodeInfoLista.Create('TPFornecedor');
end;

destructor TPPrincipaisFornecedores.Destroy;
begin
  FreeAndNil(Ffornecedor);
  inherited;
end;

function TPPrincipaisFornecedores.fGetRelatorio: String;
begin

end;

{ TPCnae }

function TPCnae.fGetRelatorio: String;
begin

end;

{ TPFornecedor }

function TPFornecedor.fGetRelatorio: String;
begin

end;

{ TPPendenciasRestricoes }

constructor TPPendenciasRestricoes.Create;
begin
  inherited;
  Flista_pendencias_restricoes := TPNodeInfoList.Create('TPPendencia');
end;

destructor TPPendenciasRestricoes.Destroy;
begin
  FreeAndNil(Flista_pendencias_restricoes);
  inherited;
end;

function TPPendenciasRestricoes.fGetRelatorio: String;
begin

end;

{ TPDataValor }

function TPDataValor.fGetRelatorio: String;
begin

end;

{ TPPendencia }

function TPPendencia.fGetRelatorio: String;
begin

end;

{ TPTotalPendencias }

function TPTotalPendencias.fGetRelatorio: String;
begin

end;

{ TPExtraPendencias }

function TPExtraPendencias.fGetRelatorio: String;
begin

end;

{ TPChequesSustados }

constructor TPChequesSustados.Create;
begin
  inherited;
  Fcheque_sustado := TPNodeInfoLista.Create('TPChequeSustado');
end;

destructor TPChequesSustados.Destroy;
begin
  FreeAndNil(Fcheque_sustado);
  inherited;
end;

function TPChequesSustados.fGetRelatorio: String;
begin

end;

{ TPChequesSemFundo }

constructor TPChequesSemFundo.Create;
begin
  inherited;
  Fcheque_sem_fundo := TPNodeInfoLista.Create('TPChequeSemFundo');
end;

destructor TPChequesSemFundo.Destroy;
begin
  FreeAndNil(Fcheque_sem_fundo);
  inherited;
end;

function TPChequesSemFundo.fGetRelatorio: String;
begin

end;

{ TPChequeSemFundo }

function TPChequeSemFundo.fGetRelatorio: String;
begin

end;

{ TPChequeSustado }

function TPChequeSustado.fGetRelatorio: String;
begin

end;

{ TPProtestos }

constructor TPProtestos.Create;
begin
  inherited;
  Flista_protestos := TPNodeInfoList.Create('TPProtesto');
end;

destructor TPProtestos.Destroy;
begin
  FreeAndNil(Flista_protestos);
  inherited;
end;

function TPProtestos.fGetRelatorio: String;
begin

end;

{ TPTotalProtesto }

function TPTotalProtesto.fGetRelatorio: String;
begin

end;

{ TPExtraProtestos }

constructor TPExtraProtestos.Create;
begin
  inherited;
  Fprotestos := TPNodeInfoList.Create('TPProtestos');
end;

destructor TPExtraProtestos.Destroy;
begin
  FreeAndNil(Fprotestos);
  inherited;
end;

function TPExtraProtestos.fGetRelatorio: String;
begin

end;

{ TPProtesto }

function TPProtesto.fGetCartorio: String;
begin
  FCartorioDet := '';
  if Assigned(Self.Cartorio) then
  begin
    FCartorioDet := ((Self.Cartorio) As TPCartorio).numero_cartorio + ' - ' +
                     ((Self.Cartorio) As TPCartorio).cidade + '/' + ((Self.Cartorio) As TPCartorio).estado;
  end;

  Result := FCartorioDet;
end;

function TPProtesto.fGetRelatorio: String;
begin

end;

{ TPCartorio }

function TPCartorio.fGetRelatorio: String;
begin

end;

{ TPRecuperacoesFalencias }

constructor TPRecuperacoesFalencias.Create;
begin
  inherited;
  FRecuperacaoFalenciaAcao := TPNodeInfoList.Create('TPRecuperacaoFalencia');
end;

destructor TPRecuperacoesFalencias.Destroy;
begin
  FreeAndNil(FRecuperacaoFalenciaAcao);
  inherited;
end;

function TPRecuperacoesFalencias.fGetRelatorio: String;
begin

end;

{ TPVara }

function TPVara.fGetRelatorio: String;
begin

end;

{ TPRecuperacaoFalencia }

function TPRecuperacaoFalencia.fGetRelatorio: String;
begin

end;

{ TPInconsistencias }

constructor TPInconsistencias.Create;
begin
  inherited;
  Finconsistencia := TPNodeInfoLista.Create('TPInconsistencia');
end;

destructor TPInconsistencias.Destroy;
begin
  FreeAndNil(Finconsistencia);
  inherited;
end;

function TPInconsistencias.fGetRelatorio: String;
begin

end;

{ TPInadimplencias }

constructor TPInadimplencias.Create;
begin
  inherited;
  Finadimplencia := TPNodeInfoLista.Create('TPInconsistencia');
end;

destructor TPInadimplencias.Destroy;
begin
  FreeAndNil(Finadimplencia);
  inherited;
end;

function TPInadimplencias.fGetRelatorio: String;
begin

end;

{ TPInconsistencia }

function TPInconsistencia.fGetRelatorio: String;
begin

end;

{ TPInformacoesRecentes }

constructor TPInformacoesRecentes.Create;
begin
  inherited;
  Finformacao := TPNodeInfoLista.Create('TPInformacao');
end;

destructor TPInformacoesRecentes.Destroy;
begin
  FreeAndNil(Finformacao);
  inherited;
end;

function TPInformacoesRecentes.fGetRelatorio: String;
begin

end;

{ TPInformacao }

function TPInformacao.fGetRelatorio: String;
begin

end;

{ TPSegmentoEmpresarial }

function TPSegmentoEmpresarial.fGetRelatorio: String;
begin

end;

{ TPSegIdentificacao }

function TPSegIdentificacao.fGetRelatorio: String;
begin

end;

{ TPConsultasGrupo }

function TPConsultasGrupo.fGetRelatorio: String;
begin

end;

{ TPInformacoesComplementares }

function TPInformacoesComplementares.fGetRelatorio: String;
begin

end;

function TPEmpresaGrupo.fGetRelatorio: String;
begin

end;

{ TPEmpresasGrupo }

constructor TPEmpresasGrupo.Create;
begin
  inherited;
  Fempresa_grupo := TPNodeInfoList.Create('TPEmpresaGrupo');
end;

destructor TPEmpresasGrupo.Destroy;
begin
  FreeAndNil(Fempresa_grupo);
  inherited;
end;

function TPEmpresasGrupo.fGetRelatorio: String;
begin

end;

{ TPComportamentoPagamentos }

function TPComportamentoPagamentos.fGetRelatorio: String;
begin

end;

{ TPMediaDiasComportamento }

function TPMediaDiasComportamento.fGetRelatorio: String;
begin

end;

{ TPTotalComportamento }

function TPTotalComportamento.fGetRelatorio: String;
begin

end;

{ TPMediaCredito }

function TPMediaCredito.fGetRelatorio: String;
begin

end;

{ TPComprometimentoFuturo }

function TPComprometimentoFuturo.fGetRelatorio: String;
begin

end;

{ TPTitulosAbertoAV }

function TPTitulosAbertoAV.fGetRelatorio: String;
begin

end;

{ TPClassificacaoRanking }

function TPClassificacaoRanking.fGetRelatorio: String;
begin

end;

{ TPPagosEmAberto }

function TPPagosEmAberto.fGetRelatorio: String;
begin

end;

{ TPTitulosPagos }

function TPTitulosPagos.fGetRelatorio: String;
begin

end;

{ TPTitulosEmAberto }

function TPTitulosEmAberto.fGetRelatorio: String;
begin

end;

{ TPCedenteCasa }

function TPCedenteCasa.fGetRelatorio: String;
begin

end;

{ TPCedenteOutros }

function TPCedenteOutros.fGetRelatorio: String;
begin

end;

{ TPSacadoCasa }

function TPSacadoCasa.fGetRelatorio: String;
begin

end;

{ TPSacadoOutros }

function TPSacadoOutros.fGetRelatorio: String;
begin

end;

{ TPHistoricoCedente }

function TPHistoricoCedente.fGetRelatorio: String;
begin

end;

{ TPHistoricoSacado }

function TPHistoricoSacado.fGetRelatorio: String;
begin

end;

{ TPFactor }

function TPFactor.fGetRelatorio: String;
begin

end;

{ TPExtraParticipacoes }

constructor TPExtraParticipacoes.Create;
begin
  inherited;
  Fempresa := TPNodeInfoList.Create('TPEmpresa');
end;

destructor TPExtraParticipacoes.Destroy;
begin
  FreeAndNil(Fempresa);
  inherited;
end;

function TPExtraParticipacoes.fGetRelatorio: String;
begin

end;

{ TPAnaliseSetorial }

function TPAnaliseSetorial.fGetRelatorio: String;
begin

end;

{ TPSocios }

constructor TPSocios.Create;
begin
  inherited;
  Fsocios_acionistas := TPNodeInfoLista.Create('TPSociosAcionistas');
  Fsocios_pj := TPNodeInfoList.Create('TPSocioPJ');
  Fsocios_pf := TPNodeInfoList.Create('TPSocioPF');
end;

destructor TPSocios.Destroy;
begin
  FreeAndNil(Fsocios_pj);
  FreeAndNil(Fsocios_pf);
  inherited;
end;

function TPSocios.fGetRelatorio: String;
var
  idxInt: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      SÓCIOS                      ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10 + #13#10;

  If fEmptyStr(Fmensagem) Then
  Begin
    Result := Result + 'Capital Social:          ' + Fcapital_social + #13#10;
    Result := Result + 'Atual. Junta Comercial:  ' + Fatu_junta_coml + #13#10;
    Result := Result + 'Qtde de outros sócios:   ' + Fqtd_outros_socios + #13#10;

    If Fsocios_acionistas.Count > 0 Then
    Begin
      Result := Result + 'Sócios acionistas:       ' + #13#10;

      For idxInt := 0 To Fsocios_acionistas.Count - 1 Do
        Result := Result + Fsocios_acionistas[idxInt].fGetRelatorio;
    End;
  End
  Else
    Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TPImportantesInformacoes }

function TPImportantesInformacoes.fGetRelatorio: String;
begin

end;

{ TPIdentificacaoPF }

function TPIdentificacaoPF.fGetRelatorio: String;
begin

end;

{ TPEmpresaParticipacao }

function TPEmpresaParticipacao.fGetRelatorio: String;
begin

end;

{ TPResumo }

function TPResumo.fGetRelatorio: String;
begin

end;

{ TPParticipacoesEmEmpresas }

constructor TPParticipacoesEmEmpresas.Create;
begin
  inherited;
  FEmpresas := TPNodeInfoList.Create('TPEmpresaParticipacao');
end;

destructor TPParticipacoesEmEmpresas.Destroy;
begin
  FreeAndnil(FEmpresas);
  inherited;
end;

function TPParticipacoesEmEmpresas.fGetRelatorio: String;
begin

end;

{ TPResumoConsulta }

function TPResumoConsulta.fGetRelatorio: String;
begin

end;

{ TPTotalConsulta }

function TPTotalConsulta.fGetRelatorio: String;
begin

end;

{ TPConsultaMesVigente }

function TPConsultaMesVigente.fGetRelatorio: String;
begin

end;

{ TPConsultasMes }

function TPConsultasMes.fGetRelatorio: String;
begin

end;

{ TPConsultasPF }

constructor TPConsultasPF.Create;
begin
  inherited;
  FConsultas_mes := TPNodeInfoLista.Create('TPConsultasMes');
  FUltimos       := TPNodeInfoList.Create('TPConsulta');
end;

destructor TPConsultasPF.Destroy;
begin
  FreeAndNil(FConsultas_mes);
  FreeAndNil(FUltimos);
  inherited;
end;

function TPConsultasPF.fGetRelatorio: String;
begin

end;

{ TPFalenciaOcorrencia }

function TPFalenciaOcorrencia.fGetRelatorio: String;
begin

end;

{ TPFalenciasEmpresariais }

constructor TPFalenciasEmpresariais.Create;
begin
  inherited;
  FUltimas_ocorrencias := TPNodeInfoList.Create('TPFalenciaOcorrencia');
end;

destructor TPFalenciasEmpresariais.Destroy;
begin
  FreeAndNil(FUltimas_ocorrencias);
  inherited;
end;

function TPFalenciasEmpresariais.fGetRelatorio: String;
begin

end;

{ TPAdministradorPf }

function TPAdministradorPf.fGetRelatorio: String;
begin

end;

{ TPAdministradorPj }

constructor TPAdministradorPj.Create;
begin
  inherited;
  FRecuperacoes_falencias_acoes := TPNodeInfoList.Create('TPRecuperacaoFalencia');
end;

destructor TPAdministradorPj.Destroy;
begin
  FreeAndNil(FRecuperacoes_falencias_acoes);
  inherited;
end;

function TPAdministradorPj.fGetRelatorio: String;
begin

end;

{ TPAdministradores }

function TPAdministradores.fGetRelatorio: String;
begin

end;

{ TPSocioPJ }

constructor TPSocioPJ.Create;
begin
  inherited;
  FRecuperacoesFalenciasAcoes := TPNodeInfoList.Create('TPRecuperacaoFalencia');
end;

destructor TPSocioPJ.Destroy;
begin
  FreeAndNil(FRecuperacoesFalenciasAcoes);
  inherited;
end;

function TPSocioPJ.fGetRelatorio: String;
begin

end;

{ TPSocioPF }

function TPSocioPF.fGetRelatorio: String;
begin

end;

{ TPSociosAcionistas }

function TPSociosAcionistas.fGetRelatorio: String;
begin
  Result := Result + ' Marcador:               ' + Fmarcador + #13#10;

  If Not fEmptyStr(Fcpf) Then
  Begin
    Result := Result + ' CPF:                    ' + Fcpf + #13#10;
    Result := Result + ' Nome:                   ' + Fnome + #13#10;
  End
  Else
  Begin
    Result := Result + ' CNPJ:                   ' + Fcnpj + #13#10;
    Result := Result + ' Razão Social:           ' + Frazao_social + #13#10;
  End;

  Result := Result + ' Participação:           ' + Fparticipacao + #13#10;
  Result := Result + ' Entrada:                ' + Fentrada + #13#10;
end;

{ TPAdministradoresPlatinum }

constructor TPAdministradoresPlatinum.Create;
begin
  inherited;
  FAdministradoresPJ := TPNodeInfoList.Create('TPAdministradorPj');
  FAdministradoresPF := TPNodeInfoList.Create('TPAdministradorPf');
end;

destructor TPAdministradoresPlatinum.Destroy;
begin
  FreeAndNil(FAdministradoresPJ);
  FreeAndNil(FAdministradoresPF);
  inherited;
end;

{ TPParticipacoesPlatinum }

constructor TPParticipacoesPlatinum.Create;
begin
  inherited;
  FEmpresas := TPNodeInfoLista.Create('TPEmpresa');
end;

destructor TPParticipacoesPlatinum.Destroy;
begin
  FreeAndNil(FEmpresas);
  inherited;
end;

{ TPSociosPlatinum }

constructor TPSociosPlatinum.Create;
begin
  inherited;
  FSocios_pj := TPNodeInfoList.Create('TPSocioPJ');
  FSocios_pf := TPNodeInfoList.Create('TPSocioPF');
end;

destructor TPSociosPlatinum.Destroy;
begin
  FreeAndNil(FSocios_pj);
  FreeAndNil(FSocios_pf);
  inherited;
end;

function TPSociosPlatinum.fGetRelatorio: String;
begin

end;

{ TPRegistroDebitos }

constructor TPRegistroDebitos.Create;
begin
  inherited;
  FUltimasOcorrencias := TPNodeInfoList.Create('TPRegistroDebito');
end;

destructor TPRegistroDebitos.Destroy;
begin
  FreeAndNil(FUltimasOcorrencias);
  inherited;
end;

{ TPChequesSemFundoPF }

constructor TPChequesSemFundoPF.Create;
begin
  inherited;
  FUltimasOcorrencias := TPNodeInfoList.Create('TPChequeSemFundoPF');
end;

destructor TPChequesSemFundoPF.Destroy;
begin
  FreeAndNil(FUltimasOcorrencias);
  inherited;
end;

function TPChequesSemFundoPF.fGetRelatorio: String;
begin

end;

{ TPAcoesCiveis }

constructor TPAcoesCiveis.Create;
begin
  inherited;
  FUltimas := TPNodeInfoList.Create('TPAcaoCivel');
end;

destructor TPAcoesCiveis.Destroy;
begin
  FreeAndNil(FUltimas);
  inherited;
end;

{ TAdministradoresPj }

constructor TAdministradoresPj.Create;
begin
  inherited;
  FAdministrador := TPNodeInfoLista.Create('TPAdministradorPlatinum');
end;

destructor TAdministradoresPj.Destroy;
begin
  FreeAndNil(FAdministrador);
  inherited;
end;

{ TPProtestosPF }

constructor TPProtestosPF.Create;
begin
  inherited;
  FUltimasOcorrencias := TPNodeInfoList.Create('TPProtestoPF');
end;

destructor TPProtestosPF.Destroy;
begin
  FreeAndNil(FUltimasOcorrencias);
  inherited;
end;

initialization

RegisterClasses([TPRepresentanteLegal, TPDataValor, TPEmpresa, TPExtraParticipacoes,
  TPHistoricoSacado, TPHistoricoCedente, TPSacadoOutros, TPSacadoCasa, TPAnaliseSetorial,
  TPCedenteOutros, TPCedenteCasa, TPFactor, TPSegIdentificacao, TPConsultasGrupo,
  TPTitulosEmAberto, TPTitulosPagos, TPPagosEmAberto, TPClassificacaoRanking,
  TPTitulosAbertoAV, TPComprometimentoFuturo, TPMediaCredito, TPTotalComportamento,
  TPMediaDiasComportamento, TPComportamentoPagamentos, TPEmpresaGrupo,
  TPEmpresasGrupo, TPSegmentoEmpresarial, TPInformacao, TPInformacoesRecentes,
  TPInformacoesComplementares, TPInconsistencia, TPInconsistencias,
  TPInadimplencias, TPVara, TPRecuperacaoFalencia, TPRecuperacoesFalencias,
  TPExtraProtestos, TPTotalProtesto, TPCartorio, TPProtesto, TPProtestos, TPProtestosPF,
  TPChequeSemFundo, TPChequesSemFundo, TPChequeSustado, TPChequesSustados,
  TPPendencia, TPTotalPendencias, TPPendenciasRestricoes, TPExtraPendencias, TPCnae,
  TPFornecedor, TPPrincipaisFornecedores, TPReferencialNegocio, TPChequesSemFundo,
  TPReferenciaisNegocios, TPItemHistorico, TPHistoricoPagamentos, TPTituloAVencer,
  TPTitulosAVencer, TPTempoRelFornecedores, TPConsulta, TPConsultaMes, TPProtestoPF,
  TPAteDataAnterior, TPConsultasPF, TPConsultas, TPParticipacoes, TPRepresentanteLegal ,
  TPMercado, TPSegmento, TPConsultante, TPComportamentoEmpresa, TPPainelControle,
  TPFaturamentoPresumido, TPModeloScore, TPScore, TPAlerta, TPAutorizacao,
  TPDistribuidores, TPFarmaciaDrogaria, TPMatriz, TPLocalizacao, TPTipoComportamento,
  TPPrincipaisProdutos, TPRamoAtividadeSecundario, TPRamoAtividade, TPNire, TPReceita,
  TPFiliais, TPInscricaoEstadual, TPSintegra, TPIdentificacao, TPChequesSemFundoPF,
  TPImportantesInformacoes, TPIdentificacaoPF, TPEmpresaParticipacao, TPResumo, TPResumoPF,
  TPParticipacoesEmEmpresas, TPResumoConsulta, TPTotalConsulta, TAdministradoresPj,
  TPConsultaMesVigente, TPConsultasMes, TPConsultasPF, TResumoCF,  TPChequeSemFundoPF,
  TPQtdeTotal, TPRegDebResumo, TPPrimeiro, TPRegistroDebito, TPRegistroDebitos,
  TPFalenciaOcorrencia, TPFalenciasEmpresariais, TPAcaoResumo, TPACResumo,
  TPAcaoCivel, TPACTotal, TPAcoesCiveis, TPAdministradorPf, TPSociosAcionistas,
  TPSocios, TPAdministradorPj, TPAdministradores, TPSociosPlatinum, TPSocioPJ, TPSocioPF,
  TPParticipacoesPlatinum, TPAdministradorPlatinum, TPAdministradoresPlatinum,
  TPEmpresarialPlatinum]);

end.
