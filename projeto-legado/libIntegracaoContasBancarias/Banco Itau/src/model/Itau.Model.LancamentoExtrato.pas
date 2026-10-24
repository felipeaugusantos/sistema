unit Itau.Model.LancamentoExtrato;

interface

uses
  System.SysUtils, System.Classes, ContasBancarias.Model.ContaBancaria;

type
  TLancamentoExtrato = record
    // Dados da conta local (mapeamento: EXT_NUMAGE, EXT_NUMCCA, EXT_DV_CCA)
    Agencia: string;
    Conta: string;
    DigitoConta: string;

    // Dados do evento (mapeamento: EXT_ID_EVE, EXT_TIPEVE, EXT_CREDEB, EXT_ESTONO)
    IdEvento: string;
    TipoEvento: string;           // 'lancamento', 'balance'
    Operacao: string;              // 'C' (crédito), 'D' (débito)
    Estorno: Boolean;

    // Datas (mapeamento: EXT_DTAEVE, EXT_DTACON)
    DataEvento: TDateTime;         // Data/hora do evento
    DataContabil: TDate;           // Data contábil

    // Histórico (mapeamento: EXT_CODHIS, EXT_DESRES, EXT_DESCOM, EXT_TIPHIS)
    CodigoHistorico: string;
    DescricaoResumida: string;
    DescricaoCompleta: string;
    TipoHistorico: string;         // Novo campo mapeado de EXT_TIPHIS (anteriormente ComplementoOrigem)

    // Valores (mapeamento: EXT_VALLAN, EXT_TIPMOE)
    ValorLancamento: Double;
    Moeda: string;                 // 'BRL'

    // Contrapartida (mapeamento: EXT_TIP_CP, EXT_ISPB_CP, EXT_AGE_CP, EXT_CCA_CP, EXT_DVC_CP, EXT_NOM_CP, EXT_DOC_CP, EXT_TDC_CP)
    TipoContrapartida: string;     // 'CONTA_CORRENTE', 'CONTA_CONTABIL', etc.
    ISPBContrapartida: string;     // Código ISPB
    AgenciaContrapartida: string;
    ContaContrapartida: string;
    DigitoContaContrapartida: string;
    NomeContrapartida: string;
    // Campo removido: BancoContrapartida (não existe na tabela EXT_BCITAU)
    DocumentoContrapartida: string;
    TipoPessoaContrapartida: string; // 'F' ou 'J'

    // Origem (mapeamento: EXT_ID_ORI, EXT_OPEORI, EXT_CANORI)
    IdentificadorOrigem: string;
    // Campo removido: TipoOrigem (não existe na tabela EXT_BCITAU)
    OperacaoOrigem: string;        // 'PIX_EMISSAO', 'TEF_SISPAG_SI', etc.
    CanalOrigem: string;
    // Campo removido: ComplementoOrigem (agora mapeado para TipoHistorico)

    // Importação (mapeamento: EXT_OPEIMP, EXT_DTAIMP, EXT_HORIMP, EXT_URLIMP)
    OperadorImportacao: string;
    DataImportacao: TDate;
    HoraDaImportacao: TTime;
    UrlImportacao: string;

    // Dados complementares
    ContaBancaria: TContaBancaria;
  end;

implementation

end.
