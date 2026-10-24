unit untILeads;

interface

uses EditFocus, Data.DB, BitBtnLockedIncrem, Vcl.StdCtrls, Vcl.Graphics;

type
  TStatusLead = (slVazio, slAberto, slAndamento, slFaturamentoParcial, slFinalizado);

  ILeads = interface
    ['{53B96140-2E26-49CA-92B7-9E81B97A9CC2}']

    function GetStatusLead: TStatusLead;
    procedure SetStatusLead(const AValue: TStatusLead);
    function GetTip_Fc: string;
    procedure SetTip_Fc(const AValue: string);
    function GetNumLead: string;
    procedure SetNumLead(const AValue: string);
    function GetAutInc: string;
    procedure SetAutInc(const AValue: string);
    function GetCodCli: string;
    procedure SetCodCli(const AValue: string);
    function GetNmFrmOri: String;
    procedure SetNmFrmOri(const AValue: String);

    function fRetornaStatusLead(const ADataSet: TDataSet): TStatusLead; overload;
    function fRetornaStatusLead(const AStatus: String): TStatusLead; overload;
    procedure pAlterarStatusLead(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus;
      btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
    function fPermitidoExecutarOperacao(const ADataSet: TDataSet): Boolean;
    function fRetornaOperadorFormatado(const ACodOperador: String): String;
    function fExitemOcorrenciasVinculadasAoLeadEmAberto(const ADataSet: TDataSet): Boolean;
    procedure pExibirMensagemFinalizarLeadEmAberto;
    function fExitemOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto(const ANumeroLead: String): Boolean;
    procedure pAtualizaInformacoesGeraisDoLead(lblStatusLead: TLabel; btnFinalizarLead: TBitBtnLocked;
      edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; const ADataSet: TDataSet);
    function fStatusLeadToColor(const AStatus: TStatusLead): TColor;
    function fStatusLeadToStr(const AStatus: TStatusLead): string;
    function fExitemOrcamentosVinculadosAoLead(const ANumeroLead: String): Boolean;
    function fFinalizarLead(const ADataSet: TDataSet): Boolean;
    function fExitemOcorrencias(const AAutInc: String): Boolean;
    function fObterStatusLeadAndamento(const AAutInc, ANumLead: String): TStatusLead;
    procedure pAtualizaStatusLeadAndamento(const AAutInc, ANumLead: String);
    function fRetornaSQLUpdateOrcamento: String;
    procedure pVincularOrcamentoAoLead(const strOrcamento: string);
    procedure pDesVincularOrcamentoAoLead(const strOrcamento: string);
    function fAlterarStatusLeadBancoDados(const AStatus: TStatusLead; const AAutInc: string; Finalizar: Boolean = False; strFrmOri: String = ''): Boolean;
    procedure pLimpar;
    procedure pCarregarDadosLead(const strAutInc: String);
    procedure pSetDadosLead(const ADataSet: TDataSet);

    property StatusLead: TStatusLead read GetStatusLead write SetStatusLead;
    property Tip_Fc: String read GetTip_Fc write SetTip_Fc;
    property strNumLead: String read GetNumLead write SetNumLead;
    property strAutInc: String read GetAutInc write SetAutInc;
    property strCodCli: String read GetCodCli write SetCodCli;
    property strNomeFrmOrigem: String read GetNmFrmOri write SetNmFrmOri;

  end;

  const FINALIZAR_LEAD = 'Finalizar Lead';
        REABRIR_LEAD = 'Reabrir Lead';
        PERGUNTA_REABRIR_LEAD = 'Deseja realmente reabrir o Lead?';

  arrStatusLead: array[TStatusLead] of string = ('X', 'B', 'A', 'P', 'F');
  descricaoStatusLead: array[TStatusLead] of string = ('Todos', 'Aberto', 'Andamento', 'Faturamento Parcial' , 'Finalizado');

implementation

end.
