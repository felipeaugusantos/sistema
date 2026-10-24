unit untILibDominioSistemasWrapper;

interface

uses Data.DB, Uni, untTypesSistema, Vcl.Forms, Vcl.StdCtrls, EditFocus ;

type
  ILibDominioSistemas = Interface
    ['{4407624F-5566-4927-B8CD-3DE4F24E7518}']
    function fICriaQuery: TUniQuery;
    function fICampoTabela(strCampo : String;
                           strNomTab: String;
                           arrCampoChave: Array Of String;
                           arrValorChave: Array Of Variant;
                           blnSempreLerBanco: Boolean = True;
                           strOrderBy: String = '';
                           Conexao: TUniConnection = Nil;
                           blnUsarMax: Boolean = False): Variant;
    function fIGetEmpresaLogada: String;
    function fICfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
    procedure pIValidaProCod(strNomeTabela: String);
    function fIRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
    function fIExecutandoModoClassico: Boolean;
    function fIMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      blnAutoSize: Boolean = False; intSomarTop: Integer = 0): Integer;
    procedure pIMensagensErro(const MensErro, LocalErro: String; const strMensagem: String = '');
    procedure pIGravarErro(const GravarErro:Boolean; const MensagemErro: String);
    function fIEhAdministrador(strCodOpe: String): Boolean;
    function fIRetOperadorLogado: String;
    function fIRetEmpresaLogada: String;
    procedure fIRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');
    function fIRetNomeEmpresa: String; overload;
    function fIRetNomeEmpresa(strCodEmp: String): String; overload;
    function fITiraCaracEspeciais(strTexto      : String;
                                  blnUsaLista   : Boolean = True;
                                  blnTiraEspacos: Boolean = False;
                                  blnTiraPontos : Boolean = False;
                                  blnTiraDoisPts: Boolean = False;
                                  blnTiraTab    : Boolean = False;
                                  blnTiraVirgula: Boolean = True;
                                  blnTiraAbreviacaoNumero: Boolean = False;
                                  strCaracterePersonalizado: String = ''): String;
    function fIDataValida(dtaData: TDateTime): Boolean;
    function fIValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
    function fIPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                           ASelf     : TForm;                          {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                           edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                           qryTabela: TUniQuery;                       {* Query                                       *}
                           Var chrKey: Char;                           {* Key                                         *}
                           Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                           blnConSim: Boolean = True                   {* Consulta Simples ou Múltipla (multi select) *}
                           ): Boolean; {* Tipo de Movimento                         *}
    function fIChamaTelaGravando(fExecutarAcao: TFunctionFormGravando; strTitulo: String = ''; blnStayOnTop: Boolean = False): Boolean;
    procedure pIFreeAndNil(var frmForm; ARemoverPilha : Boolean = False);
    Procedure pIMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
    procedure pICriarForm(ClasseForm: TFormClass; NomeForm: TForm);
    function fITelaGravandoAntiga: Boolean;
  end ;

implementation

end.
