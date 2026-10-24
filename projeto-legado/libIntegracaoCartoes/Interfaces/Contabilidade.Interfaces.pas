unit Contabilidade.Interfaces;

interface

uses cxProgressBar, UniClientDataSet, Uni, Classes;

type
  TParametrosConsulta = record
    strCodEmp: String;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
  End;

  TContaErro = record
    intSeqDoc: Integer;
    strMotivo: String;
    strHistor: String;
    strTipLan: String;
    strDesVal: String;
    strNatOpe: String;
  end;

  IContabilidadeTelas = interface
    ['{0DEBC602-9B74-48B0-9F5C-E9874A7C4A23}']
    procedure HistoricoPadrao;
    procedure LancamentoSaldos;
    procedure ConferenciaEstoqueContabil;
    procedure GeracaoLancamentoContabil;
    procedure ManutencaoLancamentosContabeis;
    procedure ParametrosContabilizacao;
    procedure PlanoContabil;
  end;

  IValidaContaContabil = interface
    ['{93F1635B-B94F-4908-BEED-EE1F45128EEE}']
    procedure pAddErro(recContaErro: TContaErro);
    function GetDataSet: TUniClientDataSet;
    property DataSet: TUniClientDataSet read GetDataSet;
  end;

  ITipLanCon = Interface
    ['{B705B892-BF6C-44B9-860D-E7727E258368}']
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil);
  End;

  ILanConFactory = interface
    ['{A10B19DF-8C8B-42E3-9FBD-7D79727E4BBE}']
    function fLanCon(strTipLan: String; recParCon: TParametrosConsulta; pgbProgresso: TcxProgressBar): ITipLanCon;
  end;

implementation

end.
