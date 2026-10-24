{**********************************************************************************************}
{* Interface que representa o AutcomTinta.dll e suas funções, assim a dll da tinta especifica *}
{* não precisa conhecer todas as implementações das funções usadas na dll autcomtinta, com    *}
{* isso a dll especifica da tinta fica com um tamanho menor                                   *}
{*******************************************************************************************PH*}
unit untIAutcomTintaWrapper;

interface

uses
  untIConfTinta, untIDataSet, untIConsultaTinta, untITintadeMaquinaWrapper, untIDicionario;

type
  IAutcomTintaWrapper = interface
    ['{4744AF1A-CCE4-43F7-B0F1-B8DAAB60C274}']
    function fGetConfTinta(const strIdePro: String): IConfTinta;
    function fGetDataSet: IDataSet;
    function fCfgSis(const strCamCfg: String; const varTipVar: TVarType = varString; const strCodEmp: String = ''): Variant;
    function fArqIniTinta(const ReadWrite: Integer; const NomChave, NomSecao, Conteudo: String): String;
    function GetCodEmp(): String;
    function GetUsuarioLogado(): string;
    function fCalculaPrecoCusto2(const dicDados: IDicionario): Double;
    function GetIConsultaTinta(const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): IConsultaTinta;
    function fConsultaDinamica(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
    function fConsultaDinamicaGeral(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
    function fConsultaDinamicaVenda(const Sender: TObject; const strTabPre: String;
      const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
    procedure pMensagensErro(const MensErro, LocalErro: String; const strMensagem: String = '');
    procedure pGravarErro(const GravarErro:Boolean; const MensagemErro: String);
    procedure pAjudaAutcom(const Handle: THandle; const intNumHlp: Integer);
    function GetDicionario(): IDicionario;
    function pConsultaComp(var qryTabela: IDataSet;
      const strNomeTabela, strSQL, stlIndice, stlDesInd: String; strOrderOpc: String = '';
      blnMarDes: Boolean = False; strCampoChave: String = 'AUTOINCREM'; strSimilar: String = ''): Boolean;
    function fEntraCons(const strCodigo: String): Boolean;
    function fMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      intSomarTop: Integer = 0): Integer;
    function fRetAutoIncrem(const strNomeTabela: string; const strCodEmp: String): String;
    function GetInsert(const strTabela: string): string;
    function GetInsertDelayed(const strTabela: string): string;
    function fInsereProCod(const strNomTab: String): Boolean;
    procedure TruncateTable(const strNomeTabela: string);
    procedure DropTable(const strNomeTabela: string);
    procedure pValidaProCod(strNomeTabela: String);
    function fUsaProCodigo(strNomeTabela: String): Boolean;
    function fGetDescricaoProdutoTinta(const strCodIte: string): string;
    function GetValorCampo(const strSql: string; const strNomeCampo: string; const arrParametros: array of string): Variant;
    function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                              curPrecus,
                              curPreven,
                              curMarBru,
                              curIcmsVenda,
                              curImpFed,
                              curDesOpe,
                              curValCom: Currency;
                              strMarMkp: String = '';
                              strPcmPro: String = '';
                              intDecUni: Integer = -1): Double;
    function fCriarProcesso(strArquivo: string; blnTrava: Boolean): boolean;
  end;

implementation

end.

