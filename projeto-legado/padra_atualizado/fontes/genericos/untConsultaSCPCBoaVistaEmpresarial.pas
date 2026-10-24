unit untConsultaSCPCBoaVistaEmpresarial;

interface

uses
  Classes, XMLDoc, XMLIntf, System.SysUtils, System.Rtti, System.StrUtils, ShellAPi, Windows,
  System.Generics.Collections, idHTTP, IdSSLOpenSSL, EditFocus, untConsultaSCPC,
  untQckConsultaSCPCEmpresarial, frxClass, UniClientDataSet, Data.DB, Vcl.Forms;

type
  TENodeInfo = class(TPersistent)
  public
    constructor Create; virtual;
    function fGetRelatorio: String; virtual; abstract;
    function fGetQtdProtestos: Integer; virtual;
    function fGetQtdCheques: Integer; virtual;
  end;

  TENodeInfoClass = class of TENodeInfo;

  TENodeInfoList = class(TObjectList<TENodeInfo>)
  private
    FstrChildClassName: String;
  public
    constructor Create(strChildClassName: String); reintroduce;
    function getChildClassName(): String;
  end;

  TENodeInfoLista = class(TENodeInfoList)
  end;

  TEDataValor = Class(TENodeInfo)
  private
    FData: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String  Read FData  Write FData;
    property valor: String Read FValor Write FValor;
  end;

  TEEmpresa = Class(TENodeInfo)
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

  TEExtraParticipacoes = Class(TENodeInfo)
  private
    FQtd_outras_participacoes: String;
    FEmpresa: TENodeInfoList;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Qtd_outras_participacoes: String Read FQtd_outras_participacoes  Write FQtd_outras_participacoes;
    property Empresa: TENodeInfoList          Read FEmpresa                   Write FEmpresa;
    property Mensagem: String                 Read FMensagem                  Write FMensagem;
  end;

  TEAnaliseSetorial = Class(TENodeInfo)
  private
    Fsegmento: String;
    Fmensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property segmento: String Read Fsegmento Write Fsegmento;
    property mensagem: String Read Fmensagem Write Fmensagem;
  end;

  TEHistoricoSacado = Class(TENodeInfo)
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

  TEHistoricoCedente = Class(TENodeInfo)
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

  TESacadoOutros = Class(TENodeInfo)
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

  TESacadoCasa = Class(TENodeInfo)
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

  TECedenteOutros = Class(TENodeInfo)
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

  TECedenteCasa = Class(TENodeInfo)
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

  TEFactor = Class(TENodeInfo)
  private
    FCedente_casa: TECedenteCasa;
    FCedente_outros: TECedenteOutros;
    FSacado_casa: TESacadoCasa;
    FSacado_outros: TESacadoOutros;
    FHistorico_como_cedente: TEHistoricoCedente;
    FHistorico_como_sacado: TEHistoricoSacado;
  public
    function fGetRelatorio: String; override;
  published
    property Cedente_casa: TECedenteCasa                Read FCedente_casa           Write FCedente_casa;
    property Cedente_outros: TECedenteOutros            Read FCedente_outros         Write FCedente_outros;
    property Sacado_casa: TESacadoCasa                  Read FSacado_casa            Write FSacado_casa;
    property Sacado_outros: TESacadoOutros              Read FSacado_outros          Write FSacado_outros;
    property Historico_como_cedente: TEHistoricoCedente Read FHistorico_como_cedente Write FHistorico_como_cedente;
    property Historico_como_sacado: TEHistoricoSacado   Read FHistorico_como_sacado  Write FHistorico_como_sacado;
  end;

  TESegIdentificacao = Class(TENodeInfo)
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

  TEConsultasGrupo = Class(TENodeInfo)
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

  TETitulosEmAberto = Class(TENodeInfo)
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

  TETitulosPagos = Class(TENodeInfo)
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

  TEPagosEmAberto = Class(TENodeInfo)
  private
    FTitulos_pagos: TETitulosPagos;
    FTitulos_em_aberto: TETitulosEmAberto;
    FMaior_compra: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_pagos: TETitulosPagos        Read FTitulos_pagos     Write FTitulos_pagos;
    property Titulos_em_aberto: TETitulosEmAberto Read FTitulos_em_aberto Write FTitulos_em_aberto;
    property Maior_compra: String                 Read FMaior_compra      Write FMaior_compra;
  end;

  TEClassificacaoRanking = Class(TENodeInfo)
  private
    FTitulos_em_aberto_ranking: TETitulosEmAberto;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_ranking: TETitulosEmAberto Read FTitulos_em_aberto_ranking Write FTitulos_em_aberto_ranking;
  end;

  TETitulosAbertoAV = Class(TENodeInfo)
  private
    FTitulos_em_aberto_a_vencer: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_a_vencer: String Read FTitulos_em_aberto_a_vencer Write FTitulos_em_aberto_a_vencer;
  end;

  TEComprometimentoFuturo = Class(TENodeInfo)
  private
    FTitulos_em_aberto_a_vencer: String;
    FTitulos_em_aberto_em_aberto: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_a_vencer: String  Read FTitulos_em_aberto_a_vencer  Write FTitulos_em_aberto_a_vencer;
    property Titulos_em_aberto_em_aberto: String Read FTitulos_em_aberto_em_aberto Write FTitulos_em_aberto_em_aberto;
  end;

  TEMediaCredito = Class(TENodeInfo)
  private
    FTitulos_em_aberto_em_aberto: String;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_em_aberto_em_aberto: String Read FTitulos_em_aberto_em_aberto Write FTitulos_em_aberto_em_aberto;
  end;

  TETotalComportamento = Class(TENodeInfo)
  private
    FTitulos_pagos: TETitulosPagos;
    FTitulos_em_aberto: TETitulosEmAberto;
  public
    function fGetRelatorio: String; override;
  published
    property Titulos_pagos: TETitulosPagos        Read FTitulos_pagos     Write FTitulos_pagos;
    property Titulos_em_aberto: TETitulosEmAberto Read FTitulos_em_aberto Write FTitulos_em_aberto;
  end;

  TEMediaDiasComportamento = Class(TENodeInfo)
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

  TEComportamentoPagamentos = Class(TENodeInfo)
  private
    FClassificacao_ranking: TEClassificacaoRanking;
    FTitulos_em_aberto_ranking: TETitulosEmAberto;
    FDt_atual_menos_5m_1ano_dt_atual_menos_5m: TEPagosEmAberto;
    FData_atual_menos_4meses: TEPagosEmAberto;
    FData_atual_menos_3meses: TEPagosEmAberto;
    FData_atual_menos_2meses: TEPagosEmAberto;
    FData_atual_menos_1mes: TEPagosEmAberto;
    FData_atual: TEPagosEmAberto;
    FData_atual_mais_1mes: TETitulosAbertoAV;
    FData_atual_mais_2meses: TETitulosAbertoAV;
    FData_atual_mais_3meses: TETitulosAbertoAV;
    FComprometimento_futuro: TEComprometimentoFuturo;
    FTotal_comportamento: TETotalComportamento;
    FMedia_credito_concedido: TEMediaCredito;
    FTtotal_titulos_comportamento: TEPagosEmAberto;
    FMedia_titulos_comportamento: TEPagosEmAberto;
    FMedia_dias_comportamento: TEMediaDiasComportamento;
    FTipo_periodo: String;
  public
    function fGetRelatorio: String; override;
  published
    property Classificacao_ranking: TEClassificacaoRanking             Read FClassificacao_ranking                    Write FClassificacao_ranking;
    property Titulos_em_aberto_ranking: TETitulosEmAberto             Read FTitulos_em_aberto_ranking                Write FTitulos_em_aberto_ranking;
    property Dt_atual_menos_5m_1ano_dt_atual_menos_5m: TEPagosEmAberto Read FDt_atual_menos_5m_1ano_dt_atual_menos_5m Write FDt_atual_menos_5m_1ano_dt_atual_menos_5m;
    property Data_atual_menos_4meses: TEPagosEmAberto                  Read FData_atual_menos_4meses                  Write FData_atual_menos_4meses;
    property Data_atual_menos_3meses: TEPagosEmAberto                  Read FData_atual_menos_3meses                  Write FData_atual_menos_3meses;
    property Data_atual_menos_2meses: TEPagosEmAberto                  Read FData_atual_menos_2meses                  Write FData_atual_menos_2meses;
    property Data_atual_menos_1mes: TEPagosEmAberto                    Read FData_atual_menos_1mes                    Write FData_atual_menos_1mes;
    property Data_atual: TEPagosEmAberto                               Read FData_atual                               Write FData_atual;
    property Data_atual_mais_1mes: TETitulosAbertoAV                   Read FData_atual_mais_1mes                     Write FData_atual_mais_1mes;
    property Data_atual_mais_2meses: TETitulosAbertoAV                 Read FData_atual_mais_2meses                   Write FData_atual_mais_2meses;
    property Data_atual_mais_3meses: TETitulosAbertoAV                 Read FData_atual_mais_3meses                   Write FData_atual_mais_3meses;
    property Comprometimento_futuro: TEComprometimentoFuturo           Read FComprometimento_futuro                   Write FComprometimento_futuro;
    property Total_comportamento: TETotalComportamento                 Read FTotal_comportamento                      Write FTotal_comportamento;
    property Media_credito_concedido: TEMediaCredito                   Read FMedia_credito_concedido                  Write FMedia_credito_concedido;
    property Total_titulos_comportamento: TEPagosEmAberto              Read FTtotal_titulos_comportamento             Write FTtotal_titulos_comportamento;
    property Media_titulos_comportamento: TEPagosEmAberto              Read FMedia_titulos_comportamento              Write FMedia_titulos_comportamento;
    property Media_dias_comportamento: TEMediaDiasComportamento        Read FMedia_dias_comportamento                 Write FMedia_dias_comportamento;
    property Tipo_periodo: String                                      Read FTipo_periodo                             Write FTipo_periodo;
  end;

  TEEmpresaGrupo = Class(TENodeInfo)
  private
    FSegmento_grupo: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Segmento_grupo: String Read FSegmento_grupo Write FSegmento_grupo;
    property Quantidade: String     Read FQuantidade     Write FQuantidade;
  end;

  TEEmpresasGrupo = Class(TENodeInfo)
  private
    FEmpresa_grupo: TENodeInfoList; // TEEmpresaGrupo
    FQtd_total: String;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Empresa_grupo: TENodeInfoList Read FEmpresa_grupo Write FEmpresa_grupo;
    property Qtd_total: String             Read FQtd_total     Write FQtd_total;
    property Mensagem: String              Read FMensagem      Write FMensagem;
  end;

  TESegmentoEmpresarial = Class(TENodeInfo)
  private
    FNomeGrupo: String;
    FIdentificacao: TESegIdentificacao;
    FConsultas_grupo: TEConsultasGrupo;
    FComportamento_pagamentos_grupo: TEComportamentoPagamentos;
    FEmpresas_grupo_registrando_sobre_cnpj: TEEmpresasGrupo;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property NomeGrupo: String                                         Read FNomeGrupo                             Write FNomeGrupo;
    property Identificacao: TESegIdentificacao                         Read FIdentificacao                         Write FIdentificacao;
    property Consultas_grupo: TEConsultasGrupo                         Read FConsultas_grupo                       Write FConsultas_grupo;
    property Comportamento_pagamentos_grupo: TEComportamentoPagamentos Read FComportamento_pagamentos_grupo        Write FComportamento_pagamentos_grupo;
    property Empresas_grupo_registrando_sobre_cnpj: TEEmpresasGrupo    Read FEmpresas_grupo_registrando_sobre_cnpj Write FEmpresas_grupo_registrando_sobre_cnpj;
    property Mensagem: String                                          Read FMensagem                              Write FMensagem;
  end;

  TEInformacao = Class(TENodeInfo)
  private
    FMes_ano: String;
    FTipo_informacao: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_ano: String         Read FMes_ano         Write FMes_ano;
    property Tipo_informacao: String Read FTipo_informacao Write FTipo_informacao;
  end;

  TEInformacoesRecentes = Class(TENodeInfo)
  private
    FInformacao: TENodeInfoLista; // TEInformacao;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Informacao: TENodeInfoLista Read FInformacao Write FInformacao;
    property Mensagem: String            Read FMensagem   Write FMensagem;
  end;

  TEInformacoesComplementares = Class(TENodeInfo)
  private
    FInformacao: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Informacao: String Read FInformacao Write FInformacao;
    property Mensagem: String   Read FMensagem   Write FMensagem;
  end;

  TEInconsistencia = Class(TENodeInfo)
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

  TEInconsistencias = Class(TENodeInfo)
  private
    FInconsistencia: TENodeInfoLista; // TEInconsistencia
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Inconsistencia: TENodeInfoLista Read FInconsistencia Write FInconsistencia;
    property Mensagem: String                Read FMensagem       Write FMensagem;
  end;

  TEInadimplencia = Class(TENodeInfo)
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

  TEInadimplencias = Class(TENodeInfo)
  private
    FInadimplencia: TENodeInfoLista; // TEInadimplencia
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Inadimplencia: TENodeInfoLista Read FInadimplencia  Write FInadimplencia;
    property Mensagem: String               Read FMensagem       Write FMensagem;
  end;

  TEVara = Class(TENodeInfo)
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

  TERecuperacaoFalencia = Class(TENodeInfo)
  private
    FQuantidade: String;
    FTipo_acao: String;
    FData_ultima_ocorrencia: String;
    FVara: TEVara;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String             Read FQuantidade             Write FQuantidade;
    property Tipo_acao: String              Read FTipo_acao              Write FTipo_acao;
    property Data_ultima_ocorrencia: String Read FData_ultima_ocorrencia Write FData_ultima_ocorrencia;
    property Vara: TEVara                   Read FVara                   Write FVara;
  end;

  TERecuperacoesFalencias = Class(TENodeInfo)
  private
    FRecuperacao_falencia_acao: TENodeInfoLista; // TERecuperacaoFalencia;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Recuperacao_falencia_acao: TENodeInfoLista Read FRecuperacao_falencia_acao Write FRecuperacao_falencia_acao;
    property Mensagem: String                           Read FMensagem                  Write FMensagem;
  end;

  TEExtraProtestos = Class(TENodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FProtestos: TENodeInfoList;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Cnpj: String              Read FCnpj         Write FCnpj;
    property Razao_social: String      Read FRazao_social Write FRazao_social;
    property Protestos: TENodeInfoList Read FProtestos    Write FProtestos;
  end;

  TETotalProtesto = Class(TENodeInfo)
  private
    FQuantidade: String;
    FValor: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Valor: String      Read FValor      Write FValor;
  end;

  TECartorio = Class(TENodeInfo)
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

  TEProtesto = Class(TENodeInfo)
  private
    FData: String;
    FCartorio: TECartorio;
    FValor: String;
    FCartorioDet: String;

    function fGetCartorio: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String         Read FData        Write FData;
    property Cartorio: TECartorio Read FCartorio    Write FCartorio;
    property CartorioDet: String  Read fGetCartorio Write FCartorioDet;
    property Valor: String        Read FValor       Write FValor;
  end;

  TEProtestos = Class(TENodeInfo)
  private
    FTotal: TETotalProtesto;
    FPrimeiro_protesto: TEDataValor;
    FMaior_protesto: TEDataValor;
    FLista_protestos: TENodeInfoList; // TEProtesto
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total: TETotalProtesto          Read FTotal             Write FTotal;
    property Primeiro_protesto: TEDataValor  Read FPrimeiro_protesto Write FPrimeiro_protesto;
    property Maior_protesto: TEDataValor     Read FMaior_protesto    Write FMaior_protesto;
    property Lista_protestos: TENodeInfoList Read FLista_protestos   Write FLista_protestos;
    property Mensagem: String                Read FMensagem          Write FMensagem;
  End;

  TEChequeSemFundo = Class(TENodeInfo)
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

  TEChequesSemFundo = Class(TENodeInfo)
  private
    FTotal_cheques: String;
    FCheque_sem_fundo: TENodeInfoLista; // TEChequeSemFundo
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total_cheques: String             Read FTotal_cheques    Write FTotal_cheques;
    property Cheque_sem_fundo: TENodeInfoLista Read FCheque_sem_fundo Write FCheque_sem_fundo;
    property Mensagem: String                  Read FMensagem         Write FMensagem;
  End;

  TEChequeSustado = Class(TENodeInfo)
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

  TEChequesSustados = Class(TENodeInfo)
  private
    FTotal_cheques: String;
    FCheque_sustado: TENodeInfoLista; // TEChequeSustado
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total_cheques: String           Read FTotal_cheques  Write FTotal_cheques;
    property Cheque_sustado: TENodeInfoLista Read FCheque_sustado Write FCheque_sustado;
    property Mensagem: String                Read FMensagem       Write FMensagem;
  End;

  TEPendencia = Class(TENodeInfo)
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

  TETotalPendencias = Class(TENodeInfo)
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

  TEPendenciasRestricoes = Class(TENodeInfo)
  private
    FTotal_pendencias: TETotalPendencias;
    FPrimeira_pendencia: TEDataValor;
    FMaior_pendencia: TEDataValor;
    FLista_pendencias_restricoes: TENodeInfoList; // TEPendencia
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Total_pendencias: TETotalPendencias         Read FTotal_pendencias            Write FTotal_pendencias;
    property Primeira_pendencia: TEDataValor             Read FPrimeira_pendencia          Write FPrimeira_pendencia;
    property Maior_pendencia: TEDataValor                Read FMaior_pendencia             Write FMaior_pendencia;
    property Lista_pendencias_restricoes: TENodeInfoList Read FLista_pendencias_restricoes Write FLista_pendencias_restricoes;
    property Mensagem: String                            Read FMensagem                    Write FMensagem;
  end;

  TEExtraPendencias = Class(TENodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FPendencias_restricoes: TEPendenciasRestricoes;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cnpj: String                                  Read FCnpj                  Write FCnpj;
    property Razao_social: String                          Read FRazao_social          Write FRazao_social;
    property Pendencias_restricoes: TEPendenciasRestricoes Read FPendencias_restricoes Write FPendencias_restricoes;
    property Mensagem: String                              Read FMensagem              Write FMensagem;
  end;

  TECnae = Class(TENodeInfo)
  private
    FDescricao: String;
    FCodigo: String;
  public
    function fGetRelatorio: String; override;
  published
    property Descricao: String Read FDescricao Write FDescricao;
    property Codigo: String    Read FCodigo    Write FCodigo;
  end;

  TEFornecedor = Class(TENodeInfo)
  private
    FCnpj: String;
    FRazao_social: String;
    FCnae: TECnae;
  public
    function fGetRelatorio: String; override;
  published
    property Cnpj: String         Read FCnpj         Write FCnpj;
    property Razao_social: String Read FRazao_social Write FRazao_social;
    property Cnae: TECnae         Read FCnae         Write FCnae;
  end;

  TEPrincipaisFornecedores = Class(TENodeInfo)
  private
    FData: String;
    FFornecedor: TENodeInfoLista;
    FMensagem: String;
  public
    constructor Create; override; //TEFornecedor
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Data: String                Read FData       Write FData;
    property Fornecedor: TENodeInfoLista Read FFornecedor Write FFornecedor;
    property Mensagem: String            Read FMensagem   Write FMensagem;
  end;

  TEReferencialNegocio = Class(TENodeInfo)
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

  TEReferenciaisNegocios = Class(TENodeInfo)
  private
    FUltima_compra: TEReferencialNegocio;
    FMaior_fatura: TEReferencialNegocio;
    FMaior_credito: TEReferencialNegocio;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property ultima_compra: TEReferencialNegocio Read FUltima_compra  Write FUltima_compra;
    property maior_fatura: TEReferencialNegocio  Read FMaior_fatura   Write FMaior_fatura;
    property maior_credito: TEReferencialNegocio Read FMaior_credito  Write FMaior_credito;
    property mensagem: String                    Read FMensagem       Write FMensagem;
  End;

  TEItemHistorico = Class(TENodeInfo)
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

  TEHistoricoPagamentos = Class(TENodeInfo)
  private
    FItem: TENodeInfoLista; //TEItemHistorico
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Item: TENodeInfoLista Read FItem     Write FItem;
    property Mensagem: String      Read FMensagem Write FMensagem;
  End;

  TETempoRelFornecedores = Class(TENodeInfo)
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

  TETituloAVencer = Class(TENodeInfo)
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

  TEConsulta = Class(TENodeInfo)
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

  TEConsultaMes = Class(TENodeInfo)
  private
    FMes_ano: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_ano: String    Read FMes_ano    Write FMes_ano;
    property Quantidade: String Read FQuantidade Write FQuantidade;
  End;

  TEAteDataAnterior = Class(TENodeInfo)
  private
    FData_anterior: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data_anterior: String Read FData_anterior Write FData_anterior;
    property Quantidade: String    Read FQuantidade    Write FQuantidade;
  End;

  TEConsultas = Class(TENodeInfo)
  private
    FQuantidade_total: String;
    FAte_data_anterior: TEAteDataAnterior;
    Fconsultas_mes: TENodeInfoLista; // TEConsultaMes
    FUltimas_consultas: TENodeInfoList; // TEConsulta
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Quantidade_total: String             Read Fquantidade_total  Write Fquantidade_total;
    property Ate_data_anterior: TEAteDataAnterior Read FAte_data_anterior Write FAte_data_anterior;
    property Consultas_mes: TENodeInfoLista       Read Fconsultas_mes     Write Fconsultas_mes;
    property Ultimas_consultas: TENodeInfoList    Read FUltimas_consultas Write FUltimas_consultas;
    property Mensagem: String                     Read FMensagem          Write FMensagem;
  End;

  TETitulosAVencer = Class(TENodeInfo)
  private
    FMensagem: String;
  public
    FTitulos_a_vencer_periodo: TENodeInfoLista; //TETituloAVencer
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Titulos_a_vencer_periodo: TENodeInfoLista Read FTitulos_a_vencer_periodo Write FTitulos_a_vencer_periodo;
    property Mensagem: String                          Read FMensagem                 Write FMensagem;
  End;

  TEParticipacoes = Class(TENodeInfo)
  private
    FQtd_outras_participacoes: String;
    FEmpresa: TENodeInfoList;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Qtd_outras_participacoes: String Read FQtd_outras_participacoes Write FQtd_outras_participacoes;
    property Empresa: TENodeInfoList          Read FEmpresa                  Write FEmpresa;
    property Mensagem: String                 Read FMensagem                 Write FMensagem;
  End;

  TERepresentanteLegal = Class(TENodeInfo)
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

  TEMercado = Class(TENodeInfo)
  private
    FQtde_tit_vencer: String;
    FValor_vencer: String;
    FQtde_tit_pagos: String;
    FValor_pagos: String;
    FQtde_tit_vencidos: String;
    FValor_vencidos: String;
  public
    function fGetRelatorio: String; override;
  published
    property Qtde_tit_vencer: String   Read FQtde_tit_vencer   Write FQtde_tit_vencer;
    property Valor_vencer: String      Read FValor_vencer      Write FValor_vencer;
    property Qtde_tit_pagos: String    Read FQtde_tit_pagos    Write FQtde_tit_pagos;
    property Valor_pagos: String       Read FValor_pagos       Write FValor_pagos;
    property Qtde_tit_vencidos: String Read FQtde_tit_vencidos Write FQtde_tit_vencidos;
    property Valor_vencidos: String Read FValor_vencidos       Write FValor_vencidos;
  End;

  TESegmento = Class(TENodeInfo)
  private
    FQtde_tit_vencer: String;
    FValor_vencer: String;
    FQtde_tit_pagos: String;
    FValor_pagos: String;
    FQtde_tit_vencidos: String;
    FValor_vencidos: String;
  public
    function fGetRelatorio: String; override;
  published
    property Qtde_tit_vencer: String   Read FQtde_tit_vencer   Write FQtde_tit_vencer;
    property Valor_vencer: String      Read FValor_vencer      Write FValor_vencer;
    property Qtde_tit_pagos: String    Read FQtde_tit_pagos    Write FQtde_tit_pagos;
    property Valor_pagos: String       Read FValor_pagos       Write FValor_pagos;
    property Qtde_tit_vencidos: String Read FQtde_tit_vencidos Write FQtde_tit_vencidos;
    property Valor_vencidos: String    Read FValor_vencidos    Write FValor_vencidos;
  End;

  TEConsultante = Class(TENodeInfo)
  private
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

  TEComportamentoEmpresa = Class(TENodeInfo)
  private
    FConsultante: TEConsultante;
    FSegmento: TESegmento;
    FMercado: TEMercado;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Consultante: TEConsultante Read FConsultante Write FConsultante;
    property Segmento: TESegmento       Read FSegmento    Write FSegmento;
    property Mercado: TEMercado         Read FMercado     Write FMercado;
    property Mensagem: String           Read FMensagem    Write FMensagem;
  End;

  TEPainelControle = Class(TENodeInfo)
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

  TEFaturamentoPresumido = Class(TENodeInfo)
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

  TEModeloScore = Class(TENodeInfo)
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

  TEScore = Class(TENodeInfo)
  private
    FModelo_score: TEModeloScore;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Modelo_score: TEModeloScore Read FModelo_score Write FModelo_score;
    property Mensagem: String            Read FMensagem     Write FMensagem;
  End;

  TEAlerta = Class(TENodeInfo)
  private
    FData: String;
    FMensagem: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String     Read FData     Write FData;
    property Mensagem: String Read FMensagem Write FMensagem;
  End;

  TEPeticao = Class(TENodeInfo)
  private
    FData_entrada: String;
    FNum_expediente: String;
    FSituacao: String;
    FProtocolo: String;
    FAssunto: String;
    FProcesso: String;
    FLocal: String;
    FPublicacao: String;
    FResolucao: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data_entrada: String   Read FData_entrada   Write FData_entrada;
    property Num_expediente: String Read FNum_expediente Write FNum_expediente;
    property Situacao: String       Read FSituacao       Write FSituacao;
    property Protocolo: String      Read FProtocolo      Write FProtocolo;
    property Assunto: String        Read FAssunto        Write FAssunto;
    property Processo: String       Read FProcesso       Write FProcesso;
    property Local: String          Read FLocal          Write FLocal;
    property Publicacao: String     Read FPublicacao     Write FPublicacao;
    property Resolucao: String      Read FResolucao      Write FResolucao;
  End;

  TEAutorizacao = Class(TENodeInfo)
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

  TEDistribuidores = Class(TENodeInfo)
  private
    FResp_legal: String;
    FResp_tecnico: String;
    FSegundo_resp_legal: String;
    FSegundo_resp_tecnico: String;
    FTerceiro_resp_legal: String;
    FTerceiro_resp_tecnico: String;
    FAutorizacoes: TENodeInfoList; // TEAutorizacao
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
    property Autorizacoes: TENodeInfoList  Read FAutorizacoes          Write FAutorizacoes;
  End;

  TEFarmaciaDrogaria = Class(TENodeInfo)
  private
    FResp_legal: String;
    FResp_tecnico: String;
    FSegundo_resp_legal: String;
    FSegundo_resp_tecnico: String;
    FTerceiro_resp_legal: String;
    FTerceiro_resp_tecnico: String;
    FAutorizacoes: TENodeInfoList; //TEAutorizacao
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
    property Autorizacoes: TENodeInfoList  Read FAutorizacoes          Write FAutorizacoes;
  End;

  TEAnvisa = Class(TENodeInfo)
  private
    FFarmacia_drogaria: TEFarmaciaDrogaria;
    FDistribuidores: TEDistribuidores;
    FPeticoes: TENodeInfoList; // TEPeticao
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Farmacia_drogaria: TEFarmaciaDrogaria Read FFarmacia_drogaria Write FFarmacia_drogaria;
    property Distribuidores: TEDistribuidores      Read FDistribuidores    Write FDistribuidores;
    property Peticoes: TENodeInfoList              Read FPeticoes          Write FPeticoes;
    property Mensagem: String                      Read FMensagem          Write FMensagem;
  End;

  TEMatriz = Class(TENodeInfo)
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

  TELocalizacao = class(TENodeInfo)
  private
    FEndereco: String;
    FBairro: String;
    FCidade: String;
    FUf: String;
    FCep: String;
    FMensagem: String;
    FMatriz: TEMatriz;
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
    property Matriz: TEMatriz    Read FMatriz    Write FMatriz;
    property Telefones: TStrings Read FTelefones Write FTelefones;
  end;

  TEPrincipaisProdutos = class(TENodeInfo)
  private
    FProduto: String;
  public
    function fGetRelatorio: String; override;
  published
    property Produto: String Read FProduto Write FProduto;
  end;

  TERamoAtividadeSecundario = class(TENodeInfo)
  private
    FAtividade: String;
    FCnae: String;
  public
    function fGetRelatorio: String; override;
  published
    property Atividade: String Read FAtividade Write FAtividade;
    property Cnae: String      Read FCnae Write FCnae;
  end;

  TERamoAtividade = class(TENodeInfo)
  private
    FAtividade: String;
    FCnae: String;
  public
    function fGetRelatorio: String; override;
  published
    property Atividade: String Read FAtividade Write FAtividade;
    property Cnae: String      Read FCnae      Write FCnae;
  end;

  TENire = class(TENodeInfo)
  private
    FNumero: String;
    FUf: String;
  public
    function fGetRelatorio: String; override;
  published
    property Numero: String Read FNumero Write FNumero;
    property Uf: String     Read FUf     Write FUf;
  end;

  TEFiliais = class(TENodeInfo)
  private
    FQuantidade: String;
    FCidades: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Cidades: String    Read FCidades    Write FCidades;
  end;

  TEInscricaoEstadual = class(TENodeInfo)
  private
    FUf: String;
    FCadastro: String;
  public
    function fGetRelatorio: String; override;
  published
    property Uf: String       Read FUf       Write FUf;
    property Cadastro: String Read FCadastro Write FCadastro;
  end;

  TESintegra = class(TENodeInfo)
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

  TEIdentificacao = class(TENodeInfo)
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
    FSintegra: TESintegra;
    FInscricao_estadual: TEInscricaoEstadual;
    FNatureza_juridica: String;
    FFaixa_funcionarios: String;
    FFiliais: TEFiliais;
    FNire: TENire;
    FRamo_atividade: TERamoAtividade;
    FRamo_atividade_secundario: TERamoAtividadeSecundario;
    FMensagem: String;
    FPrincipais_produtos: TStrings;
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
    property Sintegra: TESintegra                                 Read FSintegra                  Write FSintegra;
    property Inscricao_estadual: TEInscricaoEstadual              Read FInscricao_estadual        Write FInscricao_estadual;
    property Natureza_juridica: String                            Read FNatureza_juridica         Write FNatureza_juridica;
    property Faixa_funcionarios: String                           Read FFaixa_funcionarios        Write FFaixa_funcionarios;
    property Filiais: TEFiliais                                   Read FFiliais                   Write FFiliais;
    property Nire: TENire                                         Read FNire                      Write FNire;
    property Ramo_atividade: TERamoAtividade                      Read FRamo_atividade            Write FRamo_atividade;
    property Ramo_atividade_secundario: TERamoAtividadeSecundario Read FRamo_atividade_secundario Write FRamo_atividade_secundario;
    property Mensagem: String                                     Read FMensagem                  Write FMensagem;
    property Principais_produtos: TStrings                        Read FPrincipais_produtos       Write FPrincipais_produtos;
  end;

  TEImportantesInformacoes = Class(TENodeInfo)
  private
    FData: String;
    FMensagem_informativa: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String                 Read FData                 Write FData;
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TEIdentificacaoPF = Class(TENodeInfo)
  private
    FCpf: String;
    FNome: String;
    FNome_mae: String;
    FReceita: String;
    FData_nascimento: String;
    FMensagem_informativa: String;
  public
    function fGetRelatorio: String; override;
  published
    property Cpf: String                  Read FCpf                  Write FCpf;
    property Nome: String                 Read FNome                 Write FNome;
    property Nome_mae: String             Read FNome_mae             Write FNome_mae;
    property Receita: String              Read FReceita              Write FReceita;
    property Data_nascimento: String      Read FData_nascimento      Write FData_nascimento;
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TEEmpresaParticipacao = Class(TENodeInfo)
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

  TEResumo = Class(TENodeInfo)
  private
    FQuantidade: String;
    FData_ultima: String;
  public
    function fGetRelatorio: String; override;
  published
    property Quantidade: String  Read FQuantidade  Write FQuantidade;
    property Data_ultima: String Read FData_ultima Write FData_ultima;
  end;

  TEParticipacoesEmEmpresas = Class(TENodeInfo)
  private
    FResumo: TEResumo;
    FEmpresas: TENodeInfoList; // TEEmpresaParticipacao
    FMensagem_informativa: String;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Resumo: TEResumo             Read FResumo               Write FResumo;
    property Empresas: TENodeInfoList     Read FEmpresas             Write FEmpresas;
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TEResumoConsulta = Class(TENodeInfo)
  private
    FQtd_total: String;
    FData_ultima: String;
  public
    function fGetRelatorio: String; override;
  published
    property Qtd_total: String   Read FQtd_total   Write FQtd_total;
    property Data_ultima: String Read FData_ultima Write FData_ultima;
  end;

  TETotalConsulta = Class(TENodeInfo)
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

  TEConsultaMesVigente = Class(TENodeInfo)
  private
    FData: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Data: String       Read FData       Write FData;
    property Quantidade: String Read FQuantidade Write FQuantidade;
  end;

  TEConsultasMes = Class(TENodeInfo)
  private
    FMes_ano: String;
    FQuantidade: String;
  public
    function fGetRelatorio: String; override;
  published
    property Mes_ano: String    Read FMes_ano    Write FMes_ano;
    property Quantidade: String Read FQuantidade Write FQuantidade;
  end;

  TEUltimasConsultas = Class(TENodeInfo)
  private
    FConsulta: TENodeInfoList; // TEConsulta
  public
    function fGetRelatorio: String; override;
  published
    property Consulta: TENodeInfoList Read Fconsulta Write Fconsulta;
  end;

  TEConsultasPF = Class(TENodeInfo)
  private
    FResumo: TEResumoConsulta;
    FTotais: TETotalConsulta;
    FConsulta_mes_vigente: TEConsultaMesVigente;
    FConsultas_mes: TENodeInfoList; // TEConsultasMes;
    FUltimos: TEUltimasConsultas;
    FMensagem_informativa: String;
  public
    function fGetRelatorio: String; override;
  published
    property Resumo: TEResumoConsulta                   Read FResumo               Write FResumo;
    property Totais: TETotalConsulta                    Read FTotais               Write FTotais;
    property Consulta_mes_vigente: TEConsultaMesVigente Read FConsulta_mes_vigente Write FConsulta_mes_vigente;
    property Consultas_mes: TENodeInfoList              Read FConsultas_mes        Write FConsultas_mes;
    property Ultimos: TEUltimasConsultas                Read FUltimos              Write FUltimos;
    property Mensagem_informativa: String               Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TEQtdeTotal = Class(TENodeInfo)
  private
    FQtd_total: String;
    FValor_total: String;
  public
  published
    property Qtd_total: String   Read FQtd_total Write FQtd_total;
    property Valor_total: String Read FValor_total Write FValor_total;
  end;

  TERegDebResumo = Class(TENodeInfo)
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

  TEPrimeiro = Class(TENodeInfo)
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

  TERegistroDebito = Class(TENodeInfo)
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

  TERegistroDebitos = Class(TENodeInfo)
  private
    FResumo: TERegDebResumo;
    FComprador: TEQtdeTotal;
    FAvalista: TEQtdeTotal;
    FPrimeiro: TEPrimeiro;
    FUltimas_ocorrencias: TENodeInfoList; // TERegistroDebito
    FMensagem_informativa: String;
  public
  published
    property Resumo: TERegDebResumo              Read FResumo               Write FResumo;
    property Comprador: TEQtdeTotal              Read FComprador            Write FComprador;
    property Avalista: TEQtdeTotal               Read FAvalista             Write FAvalista;
    property Primeiro: TEPrimeiro                Read FPrimeiro             Write FPrimeiro;
    property Ultimas_ocorrencias: TENodeInfoList Read FUltimas_ocorrencias  Write FUltimas_ocorrencias;
    property Mensagem_informativa: String        Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TEFalenciaOcorrencia = Class(TENodeInfo)
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

  TEFalenciasEmpresariais = Class(TENodeInfo)
  private
    FResumo: TEResumoConsulta;
    FUltimas_ocorrencias: TENodeInfoList; // TEFalenciaOcorrencia
  public
    function fGetRelatorio: String; override;
  published
    property Resumo: TEResumoConsulta            Read FResumo              Write FResumo;
    property Ultimas_ocorrencias: TENodeInfoList Read FUltimas_ocorrencias Write FUltimas_ocorrencias; // TEFalenciaOcorrencia
  end;

  TEAcaoResumo = Class(TENodeInfo)
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

  TEACResumo = Class(TENodeInfo)
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

  TEAcaoCivel = Class(TENodeInfo)
  private
    FQuantidade: String;
    FTipo_acao: String;
  public
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Tipo_acao: String  Read FTipo_acao  Write FTipo_acao;
  end;

  TEACTotal = Class(TENodeInfo)
  private
    FQuantidade: String;
    FValor: String;
  public
  published
    property Quantidade: String Read FQuantidade Write FQuantidade;
    property Valor: String      Read FValor      Write FValor;
  end;

  TEAcoesCiveis = Class(TENodeInfo)
  private
    FResumo: TEACResumo;
    FTotal: TEACTotal;
    FPrimeira: TEDataValor;
    FUltima: TEDataValor;
    FUltimas: TENodeInfoList; // TEAcaoCivel
    FMensagem_informativa: String;
  public
  published
    property Resumo: TEACResumo           Read FResumo               Write FResumo;
    property Total: TEACTotal             Read FTotal                Write FTotal;
    property Primeira: TEDataValor        Read FPrimeira             Write FPrimeira;
    property Ultima: TEDataValor          Read FUltima               Write FUltima;
    property Ultimas: TENodeInfoList      Read FUltimas              Write FUltimas; // TEAcaoCivel
    property Mensagem_informativa: String Read FMensagem_informativa Write FMensagem_informativa;
  end;

  TEAdministradorPF = Class(TENodeInfo)
  private
    FImportantes_informacoes: TEImportantesInformacoes;
    FIdentificacao: TEIdentificacaoPF;
    FLocalizacao: TELocalizacao;
    FParticipacoes_empresas: TEParticipacoesEmEmpresas;
    FConsultas: TEConsultasPF;
    FRegistro_debitos: TERegistroDebitos;
    FCheques_sem_fundo: TEChequesSemFundo;
    FProtestos: TEProtestos;
    FFalencias_empresariais: TEFalenciasEmpresariais;
    FAcoes_civeis: TEAcoesCiveis;
  public
    function fGetRelatorio: String; override;
  published
    property importantes_informacoes: TEImportantesInformacoes Read FImportantes_informacoes Write FImportantes_informacoes;
    property identificacao: TEIdentificacaoPF                  Read FIdentificacao           Write FIdentificacao;
    property localizacao: TELocalizacao                        Read FLocalizacao             Write FLocalizacao;
    property participacoes_empresas: TEParticipacoesEmEmpresas Read FParticipacoes_empresas  Write FParticipacoes_empresas;
    property consultas: TEConsultasPF                          Read FConsultas               Write FConsultas;
    property registro_debitos: TERegistroDebitos               Read FRegistro_debitos        Write FRegistro_debitos;
    property cheques_sem_fundo: TEChequesSemFundo              Read FCheques_sem_fundo       Write FCheques_sem_fundo;
    property protestos: TEProtestos                            Read FProtestos               Write FProtestos;
    property falencias_empresariais: TEFalenciasEmpresariais   Read FFalencias_empresariais  Write FFalencias_empresariais;
    property acoes_civeis: TEAcoesCiveis                       Read FAcoes_civeis            Write FAcoes_civeis;
  end;

  TESociosAcionistas = Class(TENodeInfo)
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

  TESocios = Class(TENodeInfo)
  private
    FCapital_social: String;
    FAtu_junta_coml: String;
    FQtd_outros_socios: String;
    FSocios_acionistas: TENodeInfoLista; // TESociosAcionistas
    FSocios_pj: TENodeInfoList; // TSocioPJ - Platinum
    FSocios_pf: TENodeInfoList; // TSocioPF - Platinum
    FMensagem: String;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Capital_social: String             Read FCapital_social    Write FCapital_social;
    property Atu_junta_coml: String             Read FAtu_junta_coml    Write FAtu_junta_coml;
    property Qtd_outros_socios: String          Read FQtd_outros_socios Write FQtd_outros_socios;
    property Socios_acionistas: TENodeInfoLista Read FSocios_acionistas Write FSocios_acionistas;
    property Socios_pj: TENodeInfoList          Read FSocios_pj         Write FSocios_pj;
    property Socios_pf: TENodeInfoList          Read FSocios_pf         Write FSocios_pf;
    property Mensagem: String                   Read FMensagem          Write FMensagem;
  end;

  TEAdministradorPj = Class(TENodeInfo)
  private
    FIdentificacao: TEIdentificacao;
    FLocalizacao: TELocalizacao;
    FAlerta: TEAlerta;
    FSocios: TESocios;
    FAdministradores: String;
    FParticipacoes: TEParticipacoes;
    FConsultas: TEConsultas;
    FTempo_relacionamento_fornecedores: TETempoRelFornecedores;
    FTitulos_a_vencer: TETitulosAVencer;
    FHistorico_pagamentos: TEHistoricoPagamentos;
    FReferenciais_negocios: TEReferenciaisNegocios;
    FPendencias_restricoes: TEPendenciasRestricoes;
    FCheques_sem_fundo: TEChequesSemFundo;
    FProtestos: TEProtestos;
    FRecuperacoes_falencias_acoes: TERecuperacoesFalencias;
  public
    function fGetRelatorio: String; override;
  published
    property Identificacao: TEIdentificacao                            Read FIdentificacao                     Write FIdentificacao;
    property Localizacao: TELocalizacao                                Read FLocalizacao                       Write FLocalizacao;
    property Alerta: TEAlerta                                          Read FAlerta                            Write FAlerta;
    property Socios: TESocios                                          Read FSocios                            Write FSocios;
    property Administradores: String                                   Read FAdministradores                   Write FAdministradores;
    property Participacoes: TEParticipacoes                            Read FParticipacoes                     Write FParticipacoes;
    property Consultas: TEConsultas                                    Read FConsultas                         Write FConsultas;
    property Tempo_relacionamento_fornecedores: TETempoRelFornecedores Read FTempo_relacionamento_fornecedores Write FTempo_relacionamento_fornecedores;
    property Titulos_a_vencer: TETitulosAVencer                        Read FTitulos_a_vencer                  Write FTitulos_a_vencer;
    property Historico_pagamentos: TEHistoricoPagamentos               Read FHistorico_pagamentos              Write FHistorico_pagamentos;
    property Referenciais_negocios: TEReferenciaisNegocios             Read FReferenciais_negocios             Write FReferenciais_negocios;
    property Pendencias_restricoes: TEPendenciasRestricoes             Read FPendencias_restricoes             Write FPendencias_restricoes;
    property Cheques_sem_fundo: TEChequesSemFundo                      Read FCheques_sem_fundo                 Write FCheques_sem_fundo;
    property Protestos: TEProtestos                                    Read FProtestos                         Write FProtestos;
    property Recuperacoes_falencias_acoes: TERecuperacoesFalencias     Read FRecuperacoes_falencias_acoes      Write FRecuperacoes_falencias_acoes;
  end;

  TEAdministradores = Class(TENodeInfo)
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

  TESocioPJ = Class(TENodeInfo)
  private
    FIdentificacao: TEIdentificacao;
    FLocalizacao: TELocalizacao;
    FAlerta: TEAlerta;
    FSocios: TESocios;
    FAdministradores: TEAdministradores;
    FParticipacoes: TEParticipacoes;
    FConsultas: TEConsultas;
    FTempo_relacionamento_fornecedores: TETempoRelFornecedores;
    FTitulos_a_vencer: TETitulosAVencer;
    FHistorico_pagamentos: TEHistoricoPagamentos;
    FReferenciais_negocios: TEReferenciaisNegocios;
    FPendencias_restricoes: TEPendenciasRestricoes;
    FCheques_sem_fundo: TEChequesSemFundo;
    FProtestos: TEProtestos;
    FRecuperacoes_falencias_acoes: TERecuperacoesFalencias;
  public
    function fGetRelatorio: String; override;
  published
    property Identificacao: TEIdentificacao                            Read FIdentificacao                     Write FIdentificacao;
    property Localizacao: TELocalizacao                                Read FLocalizacao                       Write FLocalizacao;
    property Alerta: TEAlerta                                          Read FAlerta                            Write FAlerta;
    property Socios: TESocios                                          Read FSocios                            Write FSocios;
    property Administradores: TEAdministradores                        Read FAdministradores                   Write FAdministradores;
    property Participacoes: TEParticipacoes                            Read FParticipacoes                     Write FParticipacoes;
    property Consultas: TEConsultas                                    Read FConsultas                         Write FConsultas;
    property Tempo_relacionamento_fornecedores: TETempoRelFornecedores Read FTempo_relacionamento_fornecedores Write FTempo_relacionamento_fornecedores;
    property Titulos_a_vencer: TETitulosAVencer                        Read FTitulos_a_vencer                  Write FTitulos_a_vencer;
    property Historico_pagamentos: TEHistoricoPagamentos               Read FHistorico_pagamentos              Write FHistorico_pagamentos;
    property Referenciais_negocios: TEReferenciaisNegocios             Read FReferenciais_negocios             Write FReferenciais_negocios;
    property Pendencias_restricoes: TEPendenciasRestricoes             Read FPendencias_restricoes             Write FPendencias_restricoes;
    property Cheques_sem_fundo: TEChequesSemFundo                      Read FCheques_sem_fundo                 Write FCheques_sem_fundo;
    property Protestos: TEProtestos                                    Read FProtestos                         Write FProtestos;
    property Recuperacoes_falencias_acoes: TERecuperacoesFalencias     Read FRecuperacoes_falencias_acoes      Write FRecuperacoes_falencias_acoes;
  end;

  TESocioPF = Class(TENodeInfo)
  private
    FImportantes_informacoes: TEImportantesInformacoes;
    FIdentificacao: TEIdentificacaoPF;
    FLocalizacao: TELocalizacao;
    FParticipacoes_empresas: TEParticipacoesEmEmpresas;
    FConsultas: TEConsultas;
    FRegistro_debitos: TERegistroDebitos;
    FCheques_sem_fundo: TEChequesSemFundo;
    FProtestos: TEProtestos;
    FFalencias_empresariais: TEFalenciasEmpresariais;
    FAcoes_civeis: TEAcoesCiveis;
  public
    function fGetRelatorio: String; override;
  published
    property Importantes_informacoes: TEImportantesInformacoes Read FImportantes_informacoes Write FImportantes_informacoes;
    property Identificacao: TEIdentificacaoPF                  Read FIdentificacao           Write FIdentificacao;
    property Localizacao: TELocalizacao                        Read FLocalizacao             Write FLocalizacao;
    property Participacoes_empresas: TEParticipacoesEmEmpresas Read FParticipacoes_empresas  Write FParticipacoes_empresas;
    property Consultas: TEConsultas                            Read FConsultas               Write FConsultas;
    property Registro_debitos: TERegistroDebitos               Read FRegistro_debitos        Write FRegistro_debitos;
    property Cheques_sem_fundo: TEChequesSemFundo              Read FCheques_sem_fundo       Write FCheques_sem_fundo;
    property Protestos: TEProtestos                            Read FProtestos               Write FProtestos;
    property Falencias_empresariais: TEFalenciasEmpresariais   Read FFalencias_empresariais  Write FFalencias_empresariais;
    property Acoes_civeis: TEAcoesCiveis                       Read FAcoes_civeis            Write FAcoes_civeis;
  end;

  TEAdministradorGold = Class(TENodeInfo)
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

  TEAdministradoresGold = Class(TENodeInfo)
  private
    FAtu_junta_coml: String;
    FQquantidade: String;
    FAdministrador: TENodeInfoLista; // TEAdministradorGold
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Atu_junta_coml: String         Read FAtu_junta_coml Write FAtu_junta_coml;
    property Quantidade: String             Read FQquantidade    Write FQquantidade;
    property Administrador: TENodeInfoLista Read FAdministrador  Write FAdministrador;
    property Mensagem: String               Read FMensagem       Write FMensagem;
  end;

  TEParticipacoesGold = Class(TENodeInfo)
  private
    FParticipacao: TENodeInfoLista; // TEEmpresa
    FQuantidade: String;
    FMensagem: String;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Participacao: TENodeInfoLista Read FParticipacao Write FParticipacao;
    property Quantidade: String            Read FQuantidade   Write FQuantidade;
    property Mensagem: String              Read FMensagem     Write FMensagem;
  end;

  TEEmpresarial = Class(TENodeInfo)
  private
    FIdentificacao: TEIdentificacao;
    FLocalizacao: TELocalizacao;
    FAnvisa: TEAnvisa;
    FAlerta: TEAlerta;
    FScore: TEScore;
    FFaturamento_presumido: TEFaturamentoPresumido;
    FPainel_controle: TENodeInfoList; // TEPainelControle;
    FComportamento_com_sua_empresa: TEComportamentoEmpresa;
    FRepresentante_legal: TERepresentanteLegal;
    FParticipacoes: TEParticipacoesGold;
    FConsultas: TEConsultas;
    FTempo_relacionamento_fornecedores: TETempoRelFornecedores;
    FTitulos_a_vencer: TETitulosAVencer;
    FHistorico_pagamentos: TEHistoricoPagamentos;
    FReferenciais_negocios: TEReferenciaisNegocios;
    FPrincipais_fornecedores: TEPrincipaisFornecedores;
    FPendencias_restricoes: TEPendenciasRestricoes;
    FExtra_pendencias: TEExtraPendencias;
    FCheques_sustado: TEChequesSustados;
    FCheques_sem_fundo: TEChequesSemFundo;
    FProtestos: TEProtestos;
    FExtra_protestos: TEExtraProtestos;
    FRecuperacoes_falencias_acoes: TERecuperacoesFalencias;
    FInconsistencias_participantes: TEInconsistencias;
    FInadimplencia_participantes: TEInadimplencias;
    FInformacoes_complementares: TEInformacoesComplementares;
    FInformacoes_mais_recentes: TEInformacoesRecentes;
    FSegmento_empresarial: TESegmentoEmpresarial;
    FFactor: TEFactor;
    FAnalise_setorial: TEAnaliseSetorial;
    FExtra_participacoes: TEExtraParticipacoes;
    FSocios: TESocios;
    FAdministradores: TEAdministradoresGold;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function fGetRelatorio: String; override;
  published
    property Identificacao: TEIdentificacao                            Read FIdentificacao                     Write FIdentificacao;
    property Localizacao: TELocalizacao                                Read FLocalizacao                       Write FLocalizacao;
    property Anvisa: TEAnvisa                                          Read FAnvisa                            Write FAnvisa;
    property Alerta: TEAlerta                                          Read FAlerta                            Write FAlerta;
    property Score: TEScore                                            Read FScore                             Write FScore;
    property Faturamento_presumido: TEFaturamentoPresumido             Read FFaturamento_presumido             Write FFaturamento_presumido;
    property Painel_controle: TENodeInfoList                           Read FPainel_controle                   Write FPainel_controle;
    property Comportamento_com_sua_empresa: TEComportamentoEmpresa     Read FComportamento_com_sua_empresa     Write FComportamento_com_sua_empresa;
    property Representante_legal: TERepresentanteLegal                 Read FRepresentante_legal               Write FRepresentante_legal;
    property Participacoes: TEParticipacoesGold                        Read FParticipacoes                     Write FParticipacoes;
    property Consultas: TEConsultas                                    Read FConsultas                         Write FConsultas;
    property Tempo_relacionamento_fornecedores: TETempoRelFornecedores Read FTempo_relacionamento_fornecedores Write FTempo_relacionamento_fornecedores;
    property Titulos_a_vencer: TETitulosAVencer                        Read FTitulos_a_vencer                  Write FTitulos_a_vencer;
    property Historico_pagamentos: TEHistoricoPagamentos               Read FHistorico_pagamentos              Write FHistorico_pagamentos;
    property Referenciais_negocios: TEReferenciaisNegocios             Read FReferenciais_negocios             Write FReferenciais_negocios;
    property Principais_fornecedores: TEPrincipaisFornecedores         Read FPrincipais_fornecedores           Write FPrincipais_fornecedores;
    property Pendencias_restricoes: TEPendenciasRestricoes             Read FPendencias_restricoes             Write FPendencias_restricoes;
    property Extra_pendencias: TEExtraPendencias                       Read FExtra_pendencias                  Write FExtra_pendencias;
    property Cheques_sustado: TEChequesSustados                        Read FCheques_sustado                   Write FCheques_sustado;
    property Cheques_sem_fundo: TEChequesSemFundo                      Read FCheques_sem_fundo                 Write FCheques_sem_fundo;
    property Protestos: TEProtestos                                    Read FProtestos                         Write FProtestos;
    property Extra_protestos: TEExtraProtestos                         Read FExtra_protestos                   Write FExtra_protestos;
    property Recuperacoes_falencias_acoes: TERecuperacoesFalencias     Read FRecuperacoes_falencias_acoes      Write FRecuperacoes_falencias_acoes;
    property Inconsistencias_participantes: TEInconsistencias          Read FInconsistencias_participantes     Write FInconsistencias_participantes;
    property Inadimplencia_participantes: TEInadimplencias             Read FInadimplencia_participantes       Write FInadimplencia_participantes;
    property Informacoes_complementares: TEInformacoesComplementares   Read FInformacoes_complementares        Write FInformacoes_complementares;
    property Informacoes_mais_recentes: TEInformacoesRecentes          Read FInformacoes_mais_recentes         Write FInformacoes_mais_recentes;
    property Segmento_empresarial: TESegmentoEmpresarial               Read FSegmento_empresarial              Write FSegmento_empresarial;
    property Factor: TEFactor                                          Read FFactor                            Write FFactor;
    property Analise_setorial: TEAnaliseSetorial                       Read FAnalise_setorial                  Write FAnalise_setorial;
    property Extra_participacoes: TEExtraParticipacoes                 Read FExtra_participacoes               Write FExtra_participacoes;
    property Socios: TESocios                                          Read FSocios                            Write FSocios;
    property Administradores: TEAdministradoresGold                    Read FAdministradores                   Write FAdministradores;
  End;

  TConsultaSCPCBoaVistaEmpresarial = class(TConsultaSCPC)
  private
    FHTTP: TidHTTP;
    FIDSSL : TIdSSLIOHandlerSocketOpenSSL;
    FEmpresarial: TEEmpresarial;
    FErros: TStringList;
    FXmlRetorno: TXMLDocument;
    FDocConsulta: String;
    FNomeEmpresa: String;
    Fconsulta: String;
    FResp: String;
    function fConsultaServico(strDocumento: String): Boolean;
    function fParseErros(node: IXmlNode): Boolean;
    function fFindChildNode(node: IXmlNode; strChildNodeName: String): IXmlNode;
    function fParseNode(strNomeClasse: String; node: IXmlNode): TENodeInfo;
    procedure pAddChildNodes(lstList: TENodeInfoList; node: IXmlNode; strProp: String);
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

uses untFuncoes, untFuncoesSimples, untSQLBind;

{ TENodeInfo }

constructor TENodeInfo.Create;
begin
  inherited Create;
end;

function TENodeInfo.fGetQtdCheques: Integer;
begin
  Result := 0;
end;

function TENodeInfo.fGetQtdProtestos: Integer;
begin
  Result := 0;
end;

{ TENodeInfoList }

constructor TENodeInfoList.Create(strChildClassName: String);
begin
  inherited Create();
  FstrChildClassName := strChildClassName;
end;

function TENodeInfoList.getChildClassName: String;
begin
  Result := FstrChildClassName;
end;

{ TConsultaSCPCBoaVistaEmpresarial }

constructor TConsultaSCPCBoaVistaEmpresarial.Create(AOwner: TComponent);
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

destructor TConsultaSCPCBoaVistaEmpresarial.Destroy;
begin
  FreeAndNil(FHTTP);
  FreeAndNil(FIDSSL);
  FreeAndNil(FXmlRetorno);
  FreeAndNil(FEmpresarial);
  FreeAndNil(FErros);
  inherited;
end;

function TConsultaSCPCBoaVistaEmpresarial.fConsultaServico
  (strDocumento: String): Boolean;
Var
  strLogin, strSenha, strURL: String;
begin
  Result := False;

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
    strURL := 'https://commercial.bvsnet.com.br/SmallBusinessBv/bvs/empresarialplatinum/4.1?usuario=' + strLogin + '&senha=' + strSenha + '&cnpj=' + strDocumento +
              '&scoreCredito=XX&extraPendencias=U&extraProtestos=V&extraParticipacoes=W&extraQuadroSocietario=Y&analiseSetorial=Z';

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

function TConsultaSCPCBoaVistaEmpresarial.fFindChildNode(node: IXmlNode;
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

function TConsultaSCPCBoaVistaEmpresarial.fGetMsgErro: String;
begin
  Result := FErros.Text;
end;

function TConsultaSCPCBoaVistaEmpresarial.fGetQtdCheques: Integer;
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

function TConsultaSCPCBoaVistaEmpresarial.fGetQtdProtestos: Integer;
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

function TConsultaSCPCBoaVistaEmpresarial.fGetRelatorio: String;
begin
  Result := FEmpresarial.Identificacao.fGetRelatorio();
end;

function TConsultaSCPCBoaVistaEmpresarial.fParseErros(node: IXmlNode): Boolean;
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

function TConsultaSCPCBoaVistaEmpresarial.fParseNode(strNomeClasse: String;
  node: IXmlNode): TENodeInfo;
var
  classe: TClass;
  ctx: TRttiContext;
  tipo: TRttiType;
  propriedades: TArray<TRttiProperty>;
  propriedade: TRttiProperty;
  node_local: IXmlNode;
begin
  classe := findClass(strNomeClasse);

  If (classe = nil) Or (node = nil) Then
  Begin
    Result := nil;
    Exit;
  End;

  Result := TENodeInfoClass(classe).Create;

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
              propriedade.SetValue(Result,
                fGetXmlChildValoresEmTStrings(fFindChildNode(node,
                LowerCase(propriedade.Name))));
          End
          Else
          If propriedade.PropertyType.Name = 'TENodeInfoLista' Then
            pAddChildNodes(TENodeInfoList(propriedade.GetValue(Result).AsObject), node, LowerCase(propriedade.Name))
          Else
          If propriedade.PropertyType.Name = 'TENodeInfoList' Then
            pAddChildNodes(TENodeInfoList(propriedade.GetValue(Result).AsObject), fFindChildNode(node, LowerCase(propriedade.Name)), '')
          Else
            propriedade.SetValue(Result,
              fParseNode(propriedade.PropertyType.Name, fFindChildNode(node,
              LowerCase(propriedade.Name))));

        tkUnknown, tkVariant:
          propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node,
            LowerCase(propriedade.Name))));

        tkInteger, tkInt64:
          propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node,
            LowerCase(propriedade.Name), varInteger)));

        tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
          propriedade.SetValue(Result, TValue.FromVariant(fGetValorXml(node,
            IIF(propriedade.Name <> 'DataOcorrencia', LowerCase(propriedade.Name), 'dataOcorrencia')
                 , varString)));

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

function TConsultaSCPCBoaVistaEmpresarial.fRealizarConsulta(strDocumento,
  strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;
begin
  { pMensagemOk('Rotina de Consulta SCPC pela Boa Vista - ES precisa ser homologada. Por favor, entrar em contato com a Citel.');
    Result := False;
    Exit; }

  FDocConsulta := strDocumento;
  FNomeEmpresa := strNomeEmpresa;

  If fConsultaServico(strDocumento) Then
  Begin
    If Not fParseErros(FXmlRetorno.ChildNodes.FindNode(iif(fCfgSis('INTBOV') = 'emp_gold', 'empresarialgold', 'empresarialplatinum'))) Then
    Begin
      FEmpresarial := TEEmpresarial(fParseNode('TEEmpresarial',
        FXmlRetorno.ChildNodes.FindNode(iif(fCfgSis('INTBOV') = 'emp_gold', 'empresarialgold', 'empresarialplatinum'))));

      Result := True;
    End
    Else
      Result := False;
  End
  Else
    Result := False;
end;

procedure TConsultaSCPCBoaVistaEmpresarial.pAddChildNodes
  (lstList: TENodeInfoList; node: IXmlNode;  strProp: String);
var
  intIndex: Integer;
  childNode: IXmlNode;
  objChild: TENodeInfo;
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

procedure TConsultaSCPCBoaVistaEmpresarial.pSaveToFile
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

procedure TConsultaSCPCBoaVistaEmpresarial.pSaveToPDF(const strFileName: String);
var
  strArquivo,
  strAuxiliar,
  strCaminho: String;

  function fCriaDataSet(AOwner: TComponent; classe: TENodeInfo;
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
              If (propriedade.PropertyType.Name <> 'TENodeInfoList') And
                 (propriedade.PropertyType.Name <> 'TENodeInfoLista') Then
                Result:= fCriaDataSet(AOwner, TENodeInfo(propriedade.GetValue(classe).AsObject), Result, propriedade.Name);
            End;
        End;
      End;

    Finally
      ctx.Free;
    End;    
  end;

  function fGravaDataSet(classe: TENodeInfo; dataset: TUniClientDataSet; propriedade_ori: String)
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
  //                dataset:= fGravaDataSet(TENodeInfo(propriedade.GetValue(classe).AsObject), dataset, propriedade.Name)
                End;
              End
              Else
              If (propriedade.PropertyType.Name <> 'TENodeInfoList') Then
                dataset:= fGravaDataSet(TENodeInfo(propriedade.GetValue(classe).AsObject), dataset, propriedade.Name);
            End;
        End;
      End;

    Finally
      Result := dataset;
      ctx.Free;
    End;

  end;

  function fGetDataSet(AOwner: TComponent; classe: TENodeInfo)
    : TUniClientDataSet;
  begin
    Result := fCriaDataSet(AOwner, classe, nil, '');
    Result.CreateDataSet;
    Result.Open;

    Result.Append;
    Result := fGravaDataSet(classe, Result, '');
    Result.Post;
  end;

  function fGetDataSetList(AOwner: TComponent; ocorrencias: TENodeInfoList)
    : TUniClientDataSet;
  var
    ocorrencia: TENodeInfo;
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

begin

  pCriarFormularios(TfrmQckConsultaSCPCEmpresarial, frmQckConsultaSCPCEmpresarial);

  with frmQckConsultaSCPCEmpresarial do
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

    if Assigned(FEmpresarial.FPainel_controle) Then
      frxPainel.DataSet := fGetDataSetList(Self, FEmpresarial.FPainel_controle)
    else
      frxPainel.DataSet := fRetEmptyDataSet;

    if Assigned(FEmpresarial.Flocalizacao) Then
      frxLocal.DataSet  := fGetDataSet(Self, FEmpresarial.FLocalizacao)
    Else
      frxLocal.DataSet  := fRetEmptyDataSet;

    if Assigned(FEmpresarial.Fsocios) Then
    Begin
      frxSocios.DataSet := fGetDataSet(Self, FEmpresarial.FSocios);

      if Assigned(FEmpresarial.Fsocios.FSocios_acionistas) Then
        frxSociosDet.DataSet    := fGetDataSetList(Self, FEmpresarial.Fsocios.FSocios_acionistas)
      else
        frxSociosDet.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxSocios.DataSet := fRetEmptyDataSet;
      frxSociosDet.DataSet := fRetEmptyDataSet;
    End;

    If (Assigned(frxSociosDet.DataSet)) And
       (Not frxSociosDet.DataSet.IsEmpty) Then
    Begin
      frxSociosDet.DataSet.First;
      While Not frxSociosDet.DataSet.Eof Do
      Begin
        If (frxSociosDet.DataSet.FindField('razao_social') <> nil) And
           (frxSociosDet.DataSet.FieldByName('razao_social').AsString <> '') Then
        Begin
          frxSociosDet.DataSet.Edit;
          frxSociosDet.DataSet.FieldByName('nome').AsString := frxSociosDet.DataSet.FieldByName('razao_social').AsString;
          frxSociosDet.DataSet.Post;
        End;

        frxSociosDet.DataSet.Next;
      End;

      frxSociosDet.DataSet.First;
    End;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaSuaEmp')).Visible := (Not Assigned(FEmpresarial.FComportamento_com_sua_empresa)) Or
                                   (Pos('nada consta', LowerCase(FEmpresarial.FComportamento_com_sua_empresa.Mensagem)) > 0);
    if Not TfrxMemoView(frxReport.FindComponent('rllNadaConstaSuaEmp')).Visible Then
      frxComportamentoSuaEmpresa.DataSet := fGetDataSet(Self, fEmpresarial.fComportamento_com_sua_empresa)
    else
      frxComportamentoSuaEmpresa.DataSet := fRetEmptyDataSet;

    if Assigned(FEmpresarial.Fadministradores) Then
    Begin
      frxAdmin.DataSet        := fGetDataSet(Self, FEmpresarial.Fadministradores);

      if Assigned(FEmpresarial.Fadministradores.Fadministrador) Then
        frxAdminDet.DataSet     := fGetDataSetList(Self, FEmpresarial.Fadministradores.Fadministrador)
      else
        frxAdminDet.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxAdmin.DataSet := fRetEmptyDataSet;
      frxAdminDet.DataSet := fRetEmptyDataSet;
    End;

    if Assigned(FEmpresarial.Fparticipacoes) Then
    begin
      frxPartic.DataSet       := fGetDataSet(Self, FEmpresarial.Fparticipacoes);
      if Assigned(FEmpresarial.Fparticipacoes.Fparticipacao) Then
        frxParticDet.DataSet    := fGetDataSetList(Self, FEmpresarial.Fparticipacoes.Fparticipacao)
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

    if Assigned(FEmpresarial.Fhistorico_pagamentos) Then
    Begin
      if Assigned(FEmpresarial.Fhistorico_pagamentos.Fitem) Then
        frxHistPag.DataSet      := fGetDataSetList(Self, fEmpresarial.fhistorico_pagamentos.fitem)
      else
        frxHistPag.DataSet := fRetEmptyDataSet;
    End
    else
      frxHistPag.DataSet := fRetEmptyDataSet;

    if Assigned(FEmpresarial.Freferenciais_negocios) Then
    Begin
      if Assigned(FEmpresarial.Freferenciais_negocios.FUltima_compra) then
      begin
        if Not Assigned(frxRefNeg.DataSet) then
          frxRefNeg.DataSet       := fGetDataSet(Self, FEmpresarial.Freferenciais_negocios.FUltima_compra);
          frxRefNeg.DataSet.Edit;
          frxRefNeg.DataSet.FieldByName('Descricao').AsString := 'Última Compra';
          frxRefNeg.DataSet.Post;
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

    if Assigned(FEmpresarial.Fprincipais_fornecedores) Then
    Begin
      frxPrincForn.DataSet    := fGetDataSet(Self, FEmpresarial.Fprincipais_fornecedores);

      if Assigned(FEmpresarial.Fprincipais_fornecedores.Ffornecedor) Then
        frxPrincFornDet.DataSet := fGetDataSetList(Self, FEmpresarial.Fprincipais_fornecedores.Ffornecedor)
      else
        frxPrincFornDet.DataSet := fRetEmptyDataSet;
    End
    else
    Begin
      frxPrincForn.DataSet := fRetEmptyDataSet;
      frxPrincFornDet.DataSet := fRetEmptyDataSet;
    End;

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

    if Assigned(FEmpresarial.Frecuperacoes_falencias_acoes) Then
    Begin
      if Assigned(FEmpresarial.Frecuperacoes_falencias_acoes.Frecuperacao_falencia_acao) Then
        frxRecuper.DataSet      := fGetDataSetList(Self, FEmpresarial.Frecuperacoes_falencias_acoes.Frecuperacao_falencia_acao)
      else
        frxRecuper.DataSet := fRetEmptyDataSet;
    End
    Else
      frxRecuper.DataSet := fRetEmptyDataSet;

    TfrxMemoView(frxReport.FindComponent('rllNadaConstaIncPart')).Visible := (Not Assigned(FEmpresarial.Finconsistencias_participantes)) Or
                                   (Pos('nada consta', LowerCase(FEmpresarial.Finconsistencias_participantes.Mensagem)) > 0);
    if Not TfrxMemoView(frxReport.FindComponent('rllNadaConstaIncPart')).Visible Then
    Begin
      if Assigned(FEmpresarial.Finconsistencias_participantes.Finconsistencia) Then
        frxIncPart.DataSet      := fGetDataSetList(Self, FEmpresarial.Finconsistencias_participantes.Finconsistencia)
      else
        frxIncPart.DataSet := fRetEmptyDataSet;
    End
    Else
      frxIncPart.DataSet := fRetEmptyDataSet;

    if Assigned(FEmpresarial.Finadimplencia_participantes) Then
    Begin
      if Assigned(FEmpresarial.Finadimplencia_participantes.Finadimplencia) Then
        frxInadimp.DataSet      := fGetDataSetList(Self, FEmpresarial.Finadimplencia_participantes.Finadimplencia)
      else
        frxInadimp.DataSet := fRetEmptyDataSet;
    End
    Else
      frxInadimp.DataSet := fRetEmptyDataSet;

    If (Assigned(frxInadimp.DataSet)) And
       (Not frxInadimp.DataSet.IsEmpty) Then
    Begin

      frxInadimp.DataSet.First;
      While Not frxInadimp.DataSet.Eof Do
      Begin
        frxInadimp.DataSet.Edit;
        If (frxInadimp.DataSet.FindField('razao_social') <> nil) And
           (frxInadimp.DataSet.FieldByName('razao_social').AsString <> '') Then
          frxInadimp.DataSet.FieldByName('nome').AsString := frxInadimp.DataSet.FieldByName('razao_social').AsString;

        If (frxInadimp.DataSet.FindField('cnpj') <> nil) And
           (frxInadimp.DataSet.FieldByName('cnpj').AsString <> '') Then
          frxInadimp.DataSet.FieldByName('cpf').AsString := frxInadimp.DataSet.FieldByName('cnpj').AsString;
        frxInadimp.DataSet.Post;

        frxInadimp.DataSet.Next;
      End;
      frxInadimp.DataSet.First;
    End;

    if Assigned(FEmpresarial.Finformacoes_mais_recentes) Then
    Begin
      if Assigned(FEmpresarial.Finformacoes_mais_recentes.Finformacao) Then
        frxInfo.DataSet         := fGetDataSetList(Self, FEmpresarial.Finformacoes_mais_recentes.Finformacao)
      else
        frxInfo.DataSet := fRetEmptyDataSet;
    End
    else
      frxInfo.DataSet := fRetEmptyDataSet;

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

  FreeAndNil(frmQckConsultaSCPCEmpresarial);
end;

{ TEEmpresarial }

constructor TEEmpresarial.Create;
begin
  inherited;
  Fpainel_controle := TENodeInfoList.Create('TEPainelControle');
end;

destructor TEEmpresarial.Destroy;
begin
  FreeAndNil(Fpainel_controle);
  inherited;
end;

function TEEmpresarial.fGetRelatorio: String;
begin
  Result := '';

end;

{ TELocalizacao }

destructor TELocalizacao.Destroy;
begin
  FreeAndNil(Ftelefones);
  inherited;
end;

function TELocalizacao.fGetRelatorio: String;
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

{ TEIdentificacao }

destructor TEIdentificacao.Destroy;
begin
  FreeAndNil(Fprincipais_produtos);
  inherited;
end;

function TEIdentificacao.fGetRelatorio: String;
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

{ TEFarmaciaDrogaria }

constructor TEFarmaciaDrogaria.Create;
begin
  inherited Create;
  Fautorizacoes := TENodeInfoList.Create('TEAutorizacao');
end;

destructor TEFarmaciaDrogaria.Destroy;
begin
  FreeAndNil(Fautorizacoes);
  inherited;
end;

function TEFarmaciaDrogaria.fGetRelatorio: String;
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

{ TEDistribuidores }

constructor TEDistribuidores.Create;
begin
  inherited Create;
  Fautorizacoes := TENodeInfoList.Create('TEAutorizacao');
end;

destructor TEDistribuidores.Destroy;
begin
  FreeAndNil(Fautorizacoes);
  inherited;
end;

function TEDistribuidores.fGetRelatorio: String;
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

{ TEAnvisa }

constructor TEAnvisa.Create;
begin
  inherited;
  Fpeticoes := TENodeInfoList.Create('TEPeticao');
end;

destructor TEAnvisa.Destroy;
begin
  FreeAndNil(Fpeticoes);
  inherited;
end;

function TEAnvisa.fGetRelatorio: String;
var
  intIdx: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      ANVISA                      ' + #13#10;
  Result := Result + '--------------------------------------------------' +  #13#10 + #13#10;

  Result := Result + Ffarmacia_drogaria.fGetRelatorio;
  Result := Result + Fdistribuidores.fGetRelatorio;

  If Fpeticoes.Count > 0 Then
    Result := Result + #13#10 + '  Petições: ';

  For intIdx := 0 To Fpeticoes.Count - 1 Do
    Result := Result + Fpeticoes.Items[intIdx].fGetRelatorio();

  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TEPeticao }

function TEPeticao.fGetRelatorio: String;
var
  strDataEntrada: String;
begin
  strDataEntrada := Copy(Fdata_entrada, 1, 2) + '/' + Copy(Fdata_entrada, 3, 2) + '/' + Copy(Fdata_entrada, 5, Length(Fdata_entrada));

  Result := #13#10;
  Result := Result + '  Data Entrada     :     ' + strDataEntrada + #13#10;
  Result := Result + '  Num. Expediente  :     ' + Fnum_expediente + #13#10;
  Result := Result + '  Situação         :     ' + Fsituacao + #13#10;
  Result := Result + '  Protocolo        :     ' + Fprotocolo + #13#10;
  Result := Result + '  Assunto          :     ' + Fassunto + #13#10;
  Result := Result + '  Processo         :     ' + Fprocesso + #13#10;
  Result := Result + '  Local            :     ' + Flocal + #13#10;
  Result := Result + '  Publicação       :     ' + Fpublicacao + #13#10;
  Result := Result + '  Resolução        :     ' + Fresolucao + #13#10;
end;

{ TEAutorizacao }

function TEAutorizacao.fGetRelatorio: String;
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

{ TEPrincipaisProdutos }

function TEPrincipaisProdutos.fGetRelatorio: String;
begin

end;

{ TERamoAtividadeSecundario }

function TERamoAtividadeSecundario.fGetRelatorio: String;
begin
  Result := Result + 'Ramo Ativ. Sec.:         ' + Fatividade + #13#10;
  Result := Result + 'Ramo Ativ. Sec. CNAE:    ' + Fcnae + #13#10;
end;

{ TERamoAtividade }

function TERamoAtividade.fGetRelatorio: String;
begin
  Result := Result + 'Ramo Ativ. :             ' + Fatividade + #13#10;
  Result := Result + 'Ramo Ativ. CNAE:         ' + Fcnae + #13#10;
end;

{ TENire }

function TENire.fGetRelatorio: String;
begin
  Result := Result + 'Nire Nro:                ' + Fnumero + #13#10;
  Result := Result + 'Nire UF:                 ' + Fuf + #13#10;
end;

{ TEFiliais }

function TEFiliais.fGetRelatorio: String;
begin
  Result := 'Filiais:' + #13#10;
  Result := Result + ' Quantidade:             ' + Fquantidade + #13#10;
  Result := Result + ' Cidades:                ' + Fcidades + #13#10;
end;

{ TEInscricaoEstadual }

function TEInscricaoEstadual.fGetRelatorio: String;
begin
  Result := Result + 'Inscr. Est. UF      :    ' + Fuf + #13#10;
  Result := Result + 'Inscr. Est. Cadadtro:    ' + Fcadastro + #13#10;
end;

{ TESintegra }

function TESintegra.fGetRelatorio: String;
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

{ TEMatriz }

function TEMatriz.fGetRelatorio: String;
begin
  Result := 'Matriz:' + #13#10;
  Result := Result + '  Endereço      :    ' + Fendereco + #13#10;
  Result := Result + '  Bairro        :    ' + Fbairro + #13#10;
  Result := Result + '  Cidade        :    ' + Fcidade + #13#10;
  Result := Result + '  UF            :    ' + Fuf + #13#10;
  Result := Result + '  CEP           :    ' + Fcep + #13#10;
end;

{ TEModeloScore }

function TEModeloScore.fGetRelatorio: String;
begin

end;

{ TEScore }

function TEScore.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                  SCORE CRÉDITO                   ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10 + #13#10;

  // Result := Result + 'Modelo:                  ' + Fmodelo_score + #13#10;
  Result := Result + 'Mensagem:                ' + Fmensagem + #13#10;
end;

{ TEAlerta }

function TEAlerta.fGetRelatorio: String;
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

{ TEFaturamentoPresumido }

function TEFaturamentoPresumido.fGetRelatorio: String;
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

{ TEPainelControle }


function TEPainelControle.fGetRelatorio: String;
begin
end;

{ TESegmento }

function TESegmento.fGetRelatorio: String;
begin
  Result := #13#10;
  Result := ' Qtde. Títulos a vencer: ' + Fqtde_tit_vencer + #13#10;
  Result := ' Valor Títulos a vencer: ' + Fvalor_vencer + #13#10;
  Result := ' Qtde. Títulos pagos:    ' + Fqtde_tit_pagos + #13#10;
  Result := ' Valor Títulos pagos:    ' + Fvalor_pagos + #13#10;
  Result := ' Qtde. Títulos vencidos: ' + Fqtde_tit_vencidos + #13#10;
  Result := ' Valor Títulos vencidos: ' + Fvalor_vencidos + #13#10;
end;

{ TEMercado }

function TEMercado.fGetRelatorio: String;
begin
  Result := #13#10;
  Result := ' Qtde. Títulos a vencer: ' + Fqtde_tit_vencer + #13#10;
  Result := ' Valor Títulos a vencer: ' + Fvalor_vencer + #13#10;
  Result := ' Qtde. Títulos pagos:    ' + Fqtde_tit_pagos + #13#10;
  Result := ' Valor Títulos pagos:    ' + Fvalor_pagos + #13#10;
  Result := ' Qtde. Títulos vencidos: ' + Fqtde_tit_vencidos + #13#10;
  Result := ' Valor Títulos vencidos: ' + Fvalor_vencidos + #13#10;
end;

{ TEConsultante }

function TEConsultante.fGetRelatorio: String;
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

{ TEComportamentoEmpresa }

function TEComportamentoEmpresa.fGetRelatorio: String;
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


{ TEParticipacoes }

constructor TEParticipacoes.Create;
begin
  inherited;
  Fempresa := TENodeInfoList.Create('TEEmpresa');
end;

destructor TEParticipacoes.Destroy;
begin
  inherited;
  FreeAndNil(Fempresa);
end;

function TEParticipacoes.fGetRelatorio: String;
begin

end;

{ TEConsultas }

constructor TEConsultas.Create;
begin
  inherited;
  Fconsultas_mes := TENodeInfoLista.Create('TEConsultaMes');
  Fultimas_consultas := TENodeInfoList.Create('TEConsulta');
end;

destructor TEConsultas.Destroy;
begin
  inherited;
  FreeAndNil(Fconsultas_mes);
  FreeAndNil(Fultimas_consultas);
end;

function TEConsultas.fGetRelatorio: String;
begin

end;

{ TEAteDataAnterior }

function TEAteDataAnterior.fGetRelatorio: String;
begin

end;

{ TEConsulta }

function TEConsulta.fGetRelatorio: String;
begin

end;

{ TEConsultaMes }

function TEConsultaMes.fGetRelatorio: String;
begin

end;

{ TEEmpresa }

function TEEmpresa.fGetRelatorio: String;
begin

end;

{ TERepresentanteLegal }

function TERepresentanteLegal.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '          COMPORTAMENTO COM SUA EMPRESA           ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10 + #13#10;

end;

{ TETempoRelFornecedores }

function TETempoRelFornecedores.fGetRelatorio: String;
begin

end;

{ TETitulosAVencer }

constructor TETitulosAVencer.Create;
begin
  inherited;
  FTitulos_a_vencer_periodo := TENodeInfoLista.Create('TETituloAVencer');
end;

destructor TETitulosAVencer.Destroy;
begin
  inherited;
  FreeAndNil(FTitulos_a_vencer_periodo);
end;

function TETitulosAVencer.fGetRelatorio: String;
begin

end;

{ TETituloAVencer }

function TETituloAVencer.fGetRelatorio: String;
begin

end;

{ TEHistoricoPagamentos }

constructor TEHistoricoPagamentos.Create;
begin
  inherited;
  Fitem := TENodeInfoLista.Create('TEItemHistorico');
end;

destructor TEHistoricoPagamentos.Destroy;
begin
  inherited;
  FreeAndNil(Fitem);
end;

function TEHistoricoPagamentos.fGetRelatorio: String;
begin

end;

{ TEItemHistorico }

function TEItemHistorico.fGetRelatorio: String;
begin

end;

{ TEReferencialNegocio }

function TEReferencialNegocio.fGetRelatorio: String;
begin

end;

{ TEReferenciaisNegocios }

function TEReferenciaisNegocios.fGetRelatorio: String;
begin

end;

{ TEPrincipaisFornecedores }

constructor TEPrincipaisFornecedores.Create;
begin
  inherited;
  Ffornecedor := TENodeInfoLista.Create('TEFornecedor');
end;

destructor TEPrincipaisFornecedores.Destroy;
begin
  FreeAndNil(Ffornecedor);
  inherited;
end;

function TEPrincipaisFornecedores.fGetRelatorio: String;
begin

end;

{ TECnae }

function TECnae.fGetRelatorio: String;
begin

end;

{ TEFornecedor }

function TEFornecedor.fGetRelatorio: String;
begin

end;

{ TEPendenciasRestricoes }

constructor TEPendenciasRestricoes.Create;
begin
  inherited;
  Flista_pendencias_restricoes := TENodeInfoList.Create('TEPendencia');
end;

destructor TEPendenciasRestricoes.Destroy;
begin
  FreeAndNil(Flista_pendencias_restricoes);
  inherited;
end;

function TEPendenciasRestricoes.fGetRelatorio: String;
begin

end;

{ TEDataValor }

function TEDataValor.fGetRelatorio: String;
begin

end;

{ TEPendencia }

function TEPendencia.fGetRelatorio: String;
begin

end;

{ TETotalPendencias }

function TETotalPendencias.fGetRelatorio: String;
begin

end;

{ TEExtraPendencias }

function TEExtraPendencias.fGetRelatorio: String;
begin

end;

{ TEChequesSustados }

constructor TEChequesSustados.Create;
begin
  inherited;
  Fcheque_sustado := TENodeInfoLista.Create('TEChequeSustado');
end;

destructor TEChequesSustados.Destroy;
begin
  FreeAndNil(Fcheque_sustado);
  inherited;
end;

function TEChequesSustados.fGetRelatorio: String;
begin

end;

{ TEChequesSemFundo }

constructor TEChequesSemFundo.Create;
begin
  inherited;
  Fcheque_sem_fundo := TENodeInfoLista.Create('TEChequeSemFundo');
end;

destructor TEChequesSemFundo.Destroy;
begin
  FreeAndNil(Fcheque_sem_fundo);
  inherited;
end;

function TEChequesSemFundo.fGetRelatorio: String;
begin

end;

{ TEChequeSemFundo }

function TEChequeSemFundo.fGetRelatorio: String;
begin

end;

{ TEChequeSustado }

function TEChequeSustado.fGetRelatorio: String;
begin

end;

{ TEProtestos }

constructor TEProtestos.Create;
begin
  inherited;
  Flista_protestos := TENodeInfoList.Create('TEProtesto');
end;

destructor TEProtestos.Destroy;
begin
  FreeAndNil(Flista_protestos);
  inherited;
end;

function TEProtestos.fGetRelatorio: String;
begin

end;

{ TETotalProtesto }

function TETotalProtesto.fGetRelatorio: String;
begin

end;

{ TEExtraProtestos }

constructor TEExtraProtestos.Create;
begin
  inherited;
  Fprotestos := TENodeInfoList.Create('TEProtestos');
end;

destructor TEExtraProtestos.Destroy;
begin
  FreeAndNil(Fprotestos);
  inherited;
end;

function TEExtraProtestos.fGetRelatorio: String;
begin

end;

{ TEProtesto }

function TEProtesto.fGetCartorio: String;
begin
  FCartorioDet := '';
  if Assigned(Self.Cartorio) then
  begin
    FCartorioDet := ((Self.Cartorio) As TECartorio).numero_cartorio + ' - ' +
                     ((Self.Cartorio) As TECartorio).cidade + '/' + ((Self.Cartorio) As TECartorio).estado;
  end;

  Result := FCartorioDet;
end;

function TEProtesto.fGetRelatorio: String;
begin

end;

{ TECartorio }

function TECartorio.fGetRelatorio: String;
begin

end;

{ TERecuperacoesFalencias }

constructor TERecuperacoesFalencias.Create;
begin
  inherited;
  Frecuperacao_falencia_acao := TENodeInfoLista.Create('TERecuperacaoFalencia');
end;

destructor TERecuperacoesFalencias.Destroy;
begin
  FreeAndNil(Frecuperacao_falencia_acao);
  inherited;
end;

function TERecuperacoesFalencias.fGetRelatorio: String;
begin

end;

{ TEVara }

function TEVara.fGetRelatorio: String;
begin

end;

{ TERecuperacaoFalencia }

function TERecuperacaoFalencia.fGetRelatorio: String;
begin

end;

{ TEInconsistencias }

constructor TEInconsistencias.Create;
begin
  inherited;
  Finconsistencia := TENodeInfoLista.Create('TEInconsistencia');
end;

destructor TEInconsistencias.Destroy;
begin
  FreeAndNil(Finconsistencia);
  inherited;
end;

function TEInconsistencias.fGetRelatorio: String;
begin

end;

{ TEInadimplencias }

constructor TEInadimplencias.Create;
begin
  inherited;
  Finadimplencia := TENodeInfoLista.Create('TEInconsistencia');
end;

destructor TEInadimplencias.Destroy;
begin
  FreeAndNil(Finadimplencia);
  inherited;
end;

function TEInadimplencias.fGetRelatorio: String;
begin

end;

{ TEInconsistencia }

function TEInconsistencia.fGetRelatorio: String;
begin

end;

{ TEInformacoesRecentes }

constructor TEInformacoesRecentes.Create;
begin
  inherited;
  Finformacao := TENodeInfoLista.Create('TEInformacao');
end;

destructor TEInformacoesRecentes.Destroy;
begin
  FreeAndNil(Finformacao);
  inherited;
end;

function TEInformacoesRecentes.fGetRelatorio: String;
begin

end;

{ TEInformacao }

function TEInformacao.fGetRelatorio: String;
begin

end;

{ TESegmentoEmpresarial }

function TESegmentoEmpresarial.fGetRelatorio: String;
begin

end;

{ TESegIdentificacao }

function TESegIdentificacao.fGetRelatorio: String;
begin

end;

{ TEConsultasGrupo }

function TEConsultasGrupo.fGetRelatorio: String;
begin

end;

{ TEInformacoesComplementares }

function TEInformacoesComplementares.fGetRelatorio: String;
begin

end;

function TEEmpresaGrupo.fGetRelatorio: String;
begin

end;

{ TEEmpresasGrupo }

constructor TEEmpresasGrupo.Create;
begin
  inherited;
  Fempresa_grupo := TENodeInfoList.Create('TEEmpresaGrupo');
end;

destructor TEEmpresasGrupo.Destroy;
begin
  FreeAndNil(Fempresa_grupo);
  inherited;
end;

function TEEmpresasGrupo.fGetRelatorio: String;
begin

end;

{ TEComportamentoPagamentos }

function TEComportamentoPagamentos.fGetRelatorio: String;
begin

end;

{ TEMediaDiasComportamento }

function TEMediaDiasComportamento.fGetRelatorio: String;
begin

end;

{ TETotalComportamento }

function TETotalComportamento.fGetRelatorio: String;
begin

end;

{ TEMediaCredito }

function TEMediaCredito.fGetRelatorio: String;
begin

end;

{ TEComprometimentoFuturo }

function TEComprometimentoFuturo.fGetRelatorio: String;
begin

end;

{ TETitulosAbertoAV }

function TETitulosAbertoAV.fGetRelatorio: String;
begin

end;

{ TEClassificacaoRanking }

function TEClassificacaoRanking.fGetRelatorio: String;
begin

end;

{ TEPagosEmAberto }

function TEPagosEmAberto.fGetRelatorio: String;
begin

end;

{ TETitulosPagos }

function TETitulosPagos.fGetRelatorio: String;
begin

end;

{ TETitulosEmAberto }

function TETitulosEmAberto.fGetRelatorio: String;
begin

end;

{ TECedenteCasa }

function TECedenteCasa.fGetRelatorio: String;
begin

end;

{ TECedenteOutros }

function TECedenteOutros.fGetRelatorio: String;
begin

end;

{ TESacadoCasa }

function TESacadoCasa.fGetRelatorio: String;
begin

end;

{ TESacadoOutros }

function TESacadoOutros.fGetRelatorio: String;
begin

end;

{ TEHistoricoCedente }

function TEHistoricoCedente.fGetRelatorio: String;
begin

end;

{ TEHistoricoSacado }

function TEHistoricoSacado.fGetRelatorio: String;
begin

end;

{ TEFactor }

function TEFactor.fGetRelatorio: String;
begin

end;

{ TEExtraParticipacoes }

constructor TEExtraParticipacoes.Create;
begin
  inherited;
  Fempresa := TENodeInfoList.Create('TEEmpresa');
end;

destructor TEExtraParticipacoes.Destroy;
begin
  FreeAndNil(Fempresa);
  inherited;
end;

function TEExtraParticipacoes.fGetRelatorio: String;
begin

end;

{ TEAnaliseSetorial }

function TEAnaliseSetorial.fGetRelatorio: String;
begin

end;

{ TESocios }

constructor TESocios.Create;
begin
  inherited;
  Fsocios_acionistas := TENodeInfoLista.Create('TESociosAcionistas');
  Fsocios_pj := TENodeInfoList.Create('TESocioPJ');
  Fsocios_pf := TENodeInfoList.Create('TESocioPF');
end;

destructor TESocios.Destroy;
begin
  FreeAndNil(Fsocios_pj);
  FreeAndNil(Fsocios_pf);
  inherited;
end;

function TESocios.fGetRelatorio: String;
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

{ TEImportantesInformacoes }

function TEImportantesInformacoes.fGetRelatorio: String;
begin

end;

{ TEIdentificacaoPF }

function TEIdentificacaoPF.fGetRelatorio: String;
begin

end;

{ TEEmpresaParticipacao }

function TEEmpresaParticipacao.fGetRelatorio: String;
begin

end;

{ TEResumo }

function TEResumo.fGetRelatorio: String;
begin

end;

{ TEParticipacoesEmEmpresas }

constructor TEParticipacoesEmEmpresas.Create;
begin
  inherited;

end;

destructor TEParticipacoesEmEmpresas.Destroy;
begin

  inherited;
end;

function TEParticipacoesEmEmpresas.fGetRelatorio: String;
begin

end;

{ TEResumoConsulta }

function TEResumoConsulta.fGetRelatorio: String;
begin

end;

{ TETotalConsulta }

function TETotalConsulta.fGetRelatorio: String;
begin

end;

{ TEConsultaMesVigente }

function TEConsultaMesVigente.fGetRelatorio: String;
begin

end;

{ TEConsultasMes }

function TEConsultasMes.fGetRelatorio: String;
begin

end;

{ TEUltimasConsultas }

function TEUltimasConsultas.fGetRelatorio: String;
begin

end;

{ TEConsultasPF }

function TEConsultasPF.fGetRelatorio: String;
begin

end;

{ TEFalenciaOcorrencia }

function TEFalenciaOcorrencia.fGetRelatorio: String;
begin

end;

{ TEFalenciasEmpresariais }

function TEFalenciasEmpresariais.fGetRelatorio: String;
begin

end;

{ TEAdministradorPF }

function TEAdministradorPF.fGetRelatorio: String;
begin

end;

{ TEAdministradorPj }

function TEAdministradorPj.fGetRelatorio: String;
begin

end;

{ TEAdministradores }

function TEAdministradores.fGetRelatorio: String;
begin

end;

{ TESocioPJ }

function TESocioPJ.fGetRelatorio: String;
begin

end;

{ TESocioPF }

function TESocioPF.fGetRelatorio: String;
begin

end;

{ TESociosAcionistas }

function TESociosAcionistas.fGetRelatorio: String;
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

{ TEAdministradoresGold }

constructor TEAdministradoresGold.Create;
begin
  inherited;
  Fadministrador := TENodeInfoLista.Create('TEAdministradorGold');
end;

destructor TEAdministradoresGold.Destroy;
begin
  FreeAndNil(Fadministrador);
  inherited;
end;

{ TEParticipacoesGold }

constructor TEParticipacoesGold.Create;
begin
  inherited;
  Fparticipacao := TENodeInfoLista.Create('TEEmpresa');
end;

destructor TEParticipacoesGold.Destroy;
begin
  FreeAndNil(Fparticipacao);
  inherited;
end;

initialization

RegisterClasses([TEDataValor, TEEmpresa, TEExtraParticipacoes, TEAnaliseSetorial,
  TEHistoricoSacado, TEHistoricoCedente, TESacadoOutros, TESacadoCasa,
  TECedenteOutros, TECedenteCasa, TEFactor, TESegIdentificacao, TEConsultasGrupo,
  TETitulosEmAberto, TETitulosPagos, TEPagosEmAberto, TEClassificacaoRanking,
  TETitulosAbertoAV, TEComprometimentoFuturo, TEMediaCredito, TETotalComportamento,
  TEMediaDiasComportamento, TEComportamentoPagamentos, TEEmpresaGrupo,
  TEEmpresasGrupo, TESegmentoEmpresarial, TEInformacao, TEInformacoesRecentes,
  TEInformacoesComplementares, TEInconsistencia, TEInconsistencias,
  TEInadimplencias, TEVara, TERecuperacaoFalencia, TERecuperacoesFalencias,
  TEExtraProtestos, TETotalProtesto, TECartorio, TEProtesto, TEProtestos,
  TEChequeSemFundo, TEChequesSemFundo, TEChequeSustado, TEChequesSustados,
  TEPendencia, TETotalPendencias, TEPendenciasRestricoes, TEExtraPendencias, TECnae,
  TEFornecedor, TEPrincipaisFornecedores, TEReferencialNegocio,
  TEReferenciaisNegocios, TEItemHistorico, TEHistoricoPagamentos, TETituloAVencer,
  TETitulosAVencer, TETempoRelFornecedores, TEConsulta, TEConsultaMes,
  TEAteDataAnterior, TEConsultas, TEParticipacoes, TERepresentanteLegal, TEMercado,
  TESegmento, TEConsultante, TEComportamentoEmpresa, TEPainelControle,
  TEFaturamentoPresumido, TEModeloScore, TEScore, TEAlerta, TEPeticao, TEAutorizacao,
  TEDistribuidores, TEFarmaciaDrogaria, TEAnvisa, TEMatriz, TELocalizacao,
  TEPrincipaisProdutos, TERamoAtividadeSecundario, TERamoAtividade, TENire,
  TEFiliais, TEInscricaoEstadual, TESintegra, TEIdentificacao,
  TEImportantesInformacoes, TEIdentificacaoPF, TEEmpresaParticipacao, TEResumo,
  TEParticipacoesEmEmpresas, TEResumoConsulta, TETotalConsulta,
  TEConsultaMesVigente, TEConsultasMes, TEUltimasConsultas, TEConsultasPF,
  TEQtdeTotal, TERegDebResumo, TEPrimeiro, TERegistroDebito, TERegistroDebitos,
  TEFalenciaOcorrencia, TEFalenciasEmpresariais, TEAcaoResumo, TEACResumo,
  TEAcaoCivel, TEACTotal, TEAcoesCiveis, TEAdministradorPF, TESociosAcionistas,
  TESocios, TEAdministradorPj, TEAdministradores, TESocioPJ, TESocioPF, TEParticipacoesGold,
  TEAdministradorGold, TEAdministradoresGold,
  TEEmpresarial]);

end.
