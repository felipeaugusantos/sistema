unit untConsultasTinta;

interface

uses  Uni, SysUtils, Forms, StdCtrls, EditFocus, MaskEditFocus, untTypesSistema,
  untClassPanelCx, Variants, UniClientDataSet, DB, Dialogs,
  StrUtils, DBEditFocus, ExtCtrls, cxStyles, Graphics, cxCustomData, System.Generics.Collections,
  Controls,   cxGridCustomTableView, cxGridDBTableView,untFuncoesGenerica,
  MaskUtils, untFuncoesSimples;

Type
  TArrayString = Array of String;


  TFormat = Record
    strNomeCampo: string;
    strFormat: string;
  end;

  TArrayOfFormat = array of TFormat;

  TTipoPesquisas = (tpAcabamentos, tpMontadora, tpBase, tpColorante, tpFormula, tpEmbalagem, tpCadastro, tpLinha);

  TDefTintaRelacionamento = Class(TDefConsulta)
  Private
    FCampoRelacionamento: string;
    cxsSemRelacionado: TcxStyle;
  public
    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
    property CampoRelacionamento: string read  FCampoRelacionamento write FCampoRelacionamento;
    Constructor Create; Reintroduce;
    Destructor destroy; Reintroduce;
  End;


  TGerenciaConsultaTinta = Class
  private
    FstrNomeTinta: String;
  Protected
    FstrSQL        : String;
    FstrWhere      : String;
    FstrGroup      : String;
    FstrTabela     : String;
    FstrTituloTela : String;
    FarrTitCol     : TArrayString;
    FarrOrdenacao  : TArrayString;
    FarrCampoFiltro: TArrayString;
    FopcConsulta   : TTipoTintas;
    FstrSiglaTinta : String;
    FobjConsulta   : TDefConsulta;
    FFormats       : TArrayOfFormat;
    Procedure pAddNomeColuna(strNomCol: String);
    Procedure pAddColunaSql( Campo: string = ''; NomeGrid: String = ''; Decimal: integer = 0; blnVirgula: Boolean = True);
    procedure pAddFiltros(strNomCol: String);
    procedure pSetSiglaTinta;
    procedure pSetNomeTinta;
  Public
    constructor Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = '');
    destructor Destroy; override;
    procedure pFormatarCampos(qryTabela: TUniQuery);
    property strSQL        : String       Read FstrSQL;
    property strWhere      : String       Read FstrWhere;
    property strGroup      : String       Read FstrGroup;
    property arrTitCol     : TArrayString Read FarrTitCol;
    property arrOrdenacao  : TArrayString Read FarrOrdenacao;
    property arrCampoFiltro: TArrayString Read FarrCampoFiltro;
    property strTabela     : String       Read FstrTabela;
    property strTituloTela : String       Read FstrTituloTela;
    property objConsulta   : TDefConsulta Read FobjConsulta;
    property strSiglaTinta : String       Read FStrSiglaTinta;
    Property strNomeTinta  : String       Read FstrNomeTinta;

  End;

  TGerenciaConsultaAcabamentos = Class (TGerenciaConsultaTinta)
  Private

  Public

  End;


  TGerenciaConsultaMontadora = Class (TGerenciaConsultaTinta)
  Private
    FstrCodMontadora: String;
    FstrDesMontadora: String;
    procedure pPreparaPadrao;
    procedure pPreparaConBra;
    procedure pPreparaConFar;
    procedure pPreparaConBla;
  Public
    constructor Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = '');
    property strCodMontadora: String Read FstrCodMontadora;
    property strDesMontadora: String Read FstrDesMontadora;
  End;

  TGerenciaConsultaLinha = Class (TGerenciaConsultaTinta)
  Private
    FstrCodLinha: String;
    FstrDesLinha: String;
    procedure pPreparaPadrao;
  Public
    constructor Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = '');
    property strCodLinha: String Read FstrCodLinha;
    property strDesLinha: String Read FstrDesLinha;
  End;

  TGerenciaConsultaColorante = Class (TGerenciaConsultaTinta)
  Private
    {*Campos de Retorno para os edits*}
    FstrCodColorante: String;
    FstrCodigoItem  : String;
    FblnComProdutos : Boolean;
    procedure pPreparaDefaultTodosCampos;
    procedure pPreparaDefaultSemCOL_PESESP;
    procedure pPreparaDefaultSemCOL_PESESP_e_COL_DESCRI;
  Public
    constructor Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = ''; blnComProdutos: Boolean = True);
    property strCodColorante : String Read FstrCodColorante;
    property strCodigoItem   : String Read FstrCodigoItem;
     { ******************************* }
  End;

  TGerenciaConsultasBaseTinta = Class(TGerenciaConsultaTinta)
  private
    {*Campos de Retorno para os edits*}
    FstrCampoBase          : String;
    FstrCampoDescricaoBase : String;
    FblnComProdutos        : Boolean;
    { ******************************* }
    procedure pPreparaPadraoComGrupo;
    procedure pPreparaConAdv;
    procedure pPreparaConAdt;
    procedure pPreparaConAle;
    procedure pPreparaConAnn;
    procedure pPreparaConAut;
    procedure pPreparaConBau;
    procedure pPreparaConQua;
    procedure pPreparaConBel;
    procedure pPreparaConCia;
    procedure pPreparaConJot;
    procedure pPreparaConMeg;
    procedure pPreparaConGra;
    procedure pPreparaConBza;
    procedure pPreparaConBzc;
    Procedure pPreparaConBzi;
    procedure pPreparaConCal;
    procedure pPreparaConCorImo;
    procedure pPreparaConCorInd;
    Procedure pPreparaConDac;
    procedure pPreparaConDox;
    procedure pPreparaConDup;
    procedure pPreparaConDux;
    procedure pPreparaConDu2;
    procedure pPreparaConEUC;
    procedure pPreparaConFar;
    procedure pPreparaConFut;
    procedure pPreparaConGen;
    procedure pPreparaConGla;
    procedure pPreparaConGlo;
    procedure pPreparaConHyd;
    procedure pPreparaConInt;
    procedure pPreparaConLec;
    procedure pPreparaConIqu;
    procedure pPreparaConKil;
    procedure pPreparaConLaz;
    procedure pPreparaConLik;
    procedure pPreparaConLks;
    procedure pPreparaConLkc;
    procedure pPreparaConMaz;
    procedure pPreparaConMza;
    procedure pPreparaConAjt;
    procedure pPreparaConAlk;
    procedure pPreparaConCoa;
    procedure pPreparaConMif;
    procedure pPreparaConMzd;
    procedure pPreparaConMzi;
    procedure pPreparaConSpa;
    procedure pPreparaConFal;
    procedure pPreparaConShw;
    procedure pPreparaConMon;
    procedure pPreparaConPPG_NEX;
    procedure pPreparaConRec;
    procedure pPreparaConRei;
    procedure pPreparaConRen;
    procedure pPreparaConSal;
    procedure pPreparaConSay;
    procedure pPreparaConSky;
    procedure pPreparaConSol;
    procedure pPreparaConSta;
    procedure pPreparaConStaWeb;
    procedure pPreparaConSuv;
    procedure pPreparaConUni;
    procedure pPreparaConVel;
    Procedure pPreparaWanda;
    procedure pPreparaConZyn;
    procedure pPreparaConInk;
    procedure pPreparaConKre;
    procedure pPreparaConKin;
    procedure pPreparaConRob;
    procedure pPreparaConMax;
    procedure pPreparaConAlp;
    procedure pPreparaConBsn;
    procedure pPreparaConCsn;
    procedure pPreparaConGbc;
    procedure pPreparaConClb;
    procedure pPreparaConBlt;
    procedure pPreparaConC11;
    procedure pPreparaConTex;
    procedure pPreparaConChr;
    procedure pPreparaConAds;
    procedure pPreparaConLei;
    procedure pPreparaConMae;
    procedure pPreparaConSin;
    procedure pPreparaConDca;
    procedure pPreparaConLuz;
    procedure pPreparaConRep;
    procedure pPreparaConPro;
    procedure pPreparaConAn2;
    procedure pPreparaConRs2;
    procedure pPreparaConLca;
    procedure pPreparaConAlv;
    procedure pPreparaConPfa;
    procedure pPreparaConAla;
    procedure pPreparaConBla;


    procedure pSetarRetorno(CampoBase: String = 'BAS_CODBAS'; CampoDescricaoBase: String = 'BAS_DESBAS');
    procedure pAddFinalSql;
    procedure pSetarOrdenacao(Ordenacao: TArrayString);

  Public
    constructor Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = ''; blnComProdutos: boolean = True);
     {*Campos de Retorno para os edits*}
    property strCampoBase          : String Read FStrCampoBase;
    property strCampoDescricaoBase : String Read FstrCampoDescricaoBase;
    Const cTabelaBase = '_CADBAS';

  End;

  TGerenciaConsultaEmbalagemTinta = Class(TGerenciaConsultaTinta)
  Private
    FstrCodUnidade: String;
    FstrCodEmbalagem: String;
    FstrQuantidade: String;
    procedure pPreparaVelutex;
    procedure pPreparaAlessi;
    procedure pPreparaConSay;
    procedure pPreparaConAdt;
    procedure pPreparaConDac;
    procedure pPreparaGenerica;
    procedure pPreparaGenerica2;
  Public
    constructor Create(opcConsulta: TTipoTintas);
    property strCodUnidade: String Read FstrCodUnidade;
    property strCodEmbalagem: String read FstrCodEmbalagem;
    property strQuantidade: String read FstrQuantidade;
  End;

  TGerenciaConsultaNovasFormulas = Class(TGerenciaConsultaTinta)
  Private
    FstrCodigoFormula: String;
    procedure pPreparaConAdt;
    procedure pPreparaconAdv;
    procedure pPraparaConAdvCor;
    procedure pPraparaconAja;
    procedure pPreparaComAnj;
    procedure pPreparaConAle;
    procedure pPraparaconAnn;
    procedure pPreparaConBau;
    procedure pPreparaConQua;
    procedure pPreparaConBel;
    procedure pPreparaConCia;
    procedure pPreparaConJot;
    procedure pPreparaConMeg;
    procedure pPreparaConGra;
    procedure pPraparaconBza;
    procedure pPreparaConBzi;
    procedure pPraparaconBzc;
    procedure pPraparaconCal;
    procedure pPreparaconCorImo;
    procedure pPreparaCorInd;
    procedure pPraparaconDac;
    procedure pPraparaconSpa;
    procedure pPraparaconFal;
    procedure pPraparaconShw;
    procedure pPraparaconDox;
    procedure pPraparaconDup;
    procedure pPraparaconDux;
    procedure pPreparaConDu2;
    procedure pPraparaconEuc;
    procedure pPraparaconFar;
    procedure pPraparaconFut;
    procedure pPreparaConGen;
    procedure pPraparaConGla;
    procedure PreparaConGlo;
    procedure pPraparaconHyd;
    procedure pPraparaconInt;
    procedure pPreparaconLec;
    procedure pPreparaConIqu;
    procedure pPraparaconKil;
    procedure pPraparaconKild;
    procedure pPraparaconLaz;
    procedure PreparaConLik;
    procedure pPraparaconLkd;
    procedure pPraparaconLks;
    procedure pPreparaconLkc;
    procedure pPreparaConMza;
    procedure pPreparaConAjt;
    procedure pPreparaConAlk;
    procedure pPreparaConCoa;
    procedure pPreparaConMif;
    procedure pPreparaConMzd;
    procedure pPraparaconMzi;
    procedure pPraparaconMon;
    procedure pPraparaconNex;
    procedure pPraparaconPPG;
    procedure pPraparaconPPX;
    procedure pPreparaConRec;
    procedure pPraparaconRei;
    procedure pPraparaconRen;
    procedure pPraparaconRsi;
    procedure pPraparaconSay;
    procedure pPraparaconSal;
    procedure pPraparaconShe;
    procedure pPraparaconSky;
    procedure pPraparaconSol;
    procedure pPraparaconSta;
    procedure pPraparaconStaWeb;
    procedure pPraparaConSuv;
    procedure pPraparaconUni;
    procedure pPraparaconVel;
    procedure pPraparaconWanPro;
    procedure pPraparaconWeg;
    procedure pPraparaconZyn;
    procedure pPreparaConInk;
    procedure pPreparaConKre;
    procedure pPreparaConKin;
    procedure pPreparaConRob;
    procedure pPreparaConMax;
    procedure pPreparaConAlp;
    procedure pPreparaConBsn;
    procedure pPreparaConCsn;
    procedure pPreparaConGbc;
    procedure pPreparaConClb;
    procedure pPreparaConBlt;
    procedure pPreparaConC11;
    procedure pPreparaConTex;
    procedure pPreparaConChr;
    procedure pPreparaConAds;
    procedure pPreparaConLei;
    procedure pPreparaConMae;
    procedure pPreparaConSin;
    procedure pPreparaConDca;
    procedure pPreparaConLuz;
    procedure pPreparaconRep;
    procedure pPreparaConPro;
    procedure pPreparaConAn2;
    procedure pPreparaConRs2;
    procedure pPreparaConLca;
    procedure pPreparaConAlv;
    procedure pPreparaConPfa;
    procedure pPreparaConAla;
    procedure pPreparaConBla;
  public
    constructor Create(opcConsulta: TTipoTintas);
    Property strCodigoFormula: String Read FstrCodigoFormula;
  End;


  TGerenciaConsultaCadastro = Class (TGerenciaConsultaTinta)
  Private
    procedure pPreparaconBzi;
    procedure pPreparaConCorImo;
    procedure pPreparaConCorInd;
    procedure pPreparaConLks;
    procedure pPreparaConPPG;
    procedure pPreparaConPPX;
    procedure pPreparaComSTA;
    procedure pPreparaComRei;
    const cTabelaBase = '_CAD';
  Public
    constructor Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = '');
  End;

  TGerenciaNomeTintaPesqEmbalagens = Class
  private
    FstrNomeTintaEmb: String;
    procedure pSetNomeTintaEmb(strTabelaEmb: String);
  Public
    constructor Create(strTabelaEmb: String);

    Property strNomeTintaEmb  : String       Read FstrNomeTintaEmb;
  End;


  TLocalizaPesquisa = class
  Private
    FTipoPesquisas: TTipoPesquisas;
    FopcConsulta: TTipoTintas;
    FstrSigla: String;
    FstrTabela: String;
    procedure pProcessar;
    procedure pLocalizar_opcConsulta;
    procedure pLocalizar_tipoPesquisa;
  Public
    constructor create(strNometabela: string);
    class function fLocalizaOpcConsulta(strNomeTabela: string): TLocalizaPesquisa;
    property TipoPesquisa: TTipoPesquisas read FTipoPesquisas;
    property opcConsulta: TTipoTintas read FopcConsulta;
  End;


implementation

{ TGerenciaConsultasBaseTinta }

constructor TGerenciaConsultasBaseTinta.Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = ''; blnComProdutos: boolean = True);
begin
  Inherited Create(opcConsulta, campoRelacionamento);
  FblnComProdutos := blnComProdutos;
  FOpcConsulta := opcConsulta;
  pSetSiglaTinta;
  FstrTituloTela := 'Consulta de Bases';
  FstrTabela := FstrSiglaTinta + cTabelaBase;
  FstrSQL := ' SELECT SQL_NO_CACHE ';
  pSetarRetorno();
  pSetarOrdenacao([]);
  Case FOpcConsulta Of
    conBzi: pPreparaConBzi;
    conCorInd: pPreparaConCorInd;
    conCorImo: pPreparaConCorImo;

    conDac, conDacGroupFML: pPreparaConDac;

    conWanda, conWandaPro, conWandaLinha, conWandaProLinha : pPreparaWanda;
    conSuv: pPreparaConSuv;
    conSal: pPreparaConSal;
    conMzi: pPreparaConMzi;
    conSpa: pPreparaConSpa;
    conFal: pPreparaConFal;
    conShw: pPreparaConShw;

    conDup: pPreparaConDUP;
    conDux: pPreparaConDUX;
    conDu2: pPreparaConDu2;
    conAle: pPreparaConAle;
    conSta: pPreparaConSta;
    conStaWeb: pPreparaConStaWeb;
    conBza: pPreparaConBza;
    conEUC: pPreparaConEUC;
    conSky: pPreparaConSky;
    conFar: pPreparaConFar;
    conGla: pPreparaConGla;
    conDox: pPreparaConDox;
    conBau: pPreparaConBau;
    conQua: pPreparaConQua;
    conBel: pPreparaConBel;
    conCia: pPreparaConCia;
    conJot: pPreparaConJot;
    conMeg: pPreparaConMeg;
    conGra: pPreparaConGra;
    conMon: pPreparaConMon;
    conBzc: pPreparaConBzc;
    conAut: pPreparaConAut;
    conLaz: pPreparaConLaz;
    conLks: pPreparaConLks;
    conLkc: pPreparaConLkc;
    conZyn: pPreparaConZyn;
    conVel: pPreparaConVel;
    conSol: pPreparaConSol;
    conRei: pPreparaConRei;
    conGen: pPreparaConGen;
    conAdvCor, conAja, conAnj, conLkd, conWeg, conRsi, conShe: pPreparaPadraoComGrupo;

    conFut: pPreparaConFut;
    conAdv: pPreparaConAdv;
    conUni: pPreparaConUni;
    conKil, conKild: pPreparaConKil;
    conMza: pPreparaConMza;
    ConAjt: pPreparaConAjt;
    conMzd: pPreparaConMzd;
    conMaz: pPreparaConMaz;
    conInt: pPreparaConInt;
    conLec: pPreparaConLec;
    conCal: pPreparaConCal;
    conAdt: pPreparaConAdt;
    conAnn: pPreparaConAnn;
    conInk: pPreparaConInk;
    conKre: pPreparaConKre;
    conGlo: pPreparaConGlo;
    conHyd: pPreparaConHyd;
    conLik: pPreparaConLik;
    conIqu: pPreparaConIqu;
    conRen: pPreparaConRen;
    conRec: pPreparaConRec;
    conSay: pPreparaConSay;
    conPPG, conNex, conPPX: pPreparaConPPG_NEX;
    conKin: pPreparaConKin;
    conRob: pPreparaConRob;
    conMax: pPreparaConMax;
    conAlp: pPreparaConAlp;
    conBsn: pPreparaConBsn;
    conCsn: pPreparaConCsn;
    conGbc: pPreparaConGbc;
    conClb: pPreparaConClb;
    conBlt: pPreparaConBlt;
    conAlk: pPreparaConAlk;
    conCoa: pPreparaConCoa;
    conMif: pPreparaConMif;
    conC11: pPreparaConC11;
    conTex: pPreparaConTex;
    conChr: pPreparaConChr;
    conAds: pPreparaConAds;
    conLei: pPreparaConLei;
    conMae: pPreparaConMae;
    conSin: pPreparaConSin;
    conDca: pPreparaConDca;
    conLuz: pPreparaConLuz;
    conRep: pPreparaConRep;
    conPrt: pPreparaConPro;
    conAn2: pPreparaConAn2;
    conRs2: pPreparaConRs2;
    conLca: pPreparaConLca;
    conAlv: pPreparaConAlv;
    conPfa: pPreparaConPfa;
    conAla: pPreparaConAla;
    conBla: pPreparaConBla;
  End;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaPadraoComGrupo;
begin
  pAddColunaSql('BAS_BASE__', 'Código Base');
  pAddColunaSql('BAS_PROKEY', 'Prod. Key');
  pAddColunaSql('BAS_SUBKEY', 'Sub. Key');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSQL('ITE_CODITE');
  pAddColunaSql('BAS_CODEMP');

  pAddFinalSql;

  pSetarOrdenacao(['BAS_BASE__', 'BAS_PROKEY']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConRob;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_TIPBAS', 'Tipo Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência Item');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConRs2;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_DESEMB', 'Descrição Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');


  FstrSQL := FstrSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM  ';
  FstrSQL := FstrSQL + '   RS2_CADBAS AS B ';

  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE '
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE ';

  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAds;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAdt;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CONTEU', 'Conteudo');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Item Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('BAS_CODEMB', 'Embalagem');
  pAddColunaSql('EMB_DESCRI', 'Descrição');
  pAddColunaSql('UNI_SIGUNI', 'Unidade');

  pAddFinalSql;

  FstrSQL := FstrSQL + '   LEFT JOIN ADT_CADEMB E ON B.BAS_CODEMB = E.EMB_CODEMB  ';
  FstrSQL := FstrSQL + '   LEFT JOIN CADUNI U ON E.EMB_CODUNI = U.UNI_CODUNI      ';
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');

end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAdv;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Item Referência');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_GRUPO_', 'Grupo');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAla;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_TIPO__', 'Tipo Base');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAle;
begin
  pAddColunaSql('BAS_BASE__', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto Base');
  pAddColunaSql('BAS_CODUNI', 'Código Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAlk;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAlp;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Volume', 3);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAn2;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');


  FstrSQL := FstrSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM  ';
  FstrSQL := FstrSQL + '   AN2_CADBAS AS B ';

  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE '
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE ';

  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAnn;
begin
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('ITE_CODITE');

  pAddFinalSqL;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');

end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAut;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PESPEC');
  pAddColunaSql('BAS_CODEMP');
  pAddColunaSql('BAS_MIXSCH');
  pAddFinalSqL;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBau;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;


procedure TGerenciaConsultasBaseTinta.pPreparaConQua;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBel;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBla;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBlt;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBsn;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBza;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PESPEC', 'Peso Específico');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBzc;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('ITE_CODITE', 'Descrição do Item');

  pAddColunaSql('BAS_ESPECI');
  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConBzi;
begin
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Produto');
  pAddColunaSql('BAS_LINHA_', 'Linha');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConC11;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConCal;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_CODEMB', 'Embalagem');
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConChr;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConCia;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('BAS_VOLUME', 'Volume');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;

end;

procedure TGerenciaConsultasBaseTinta.pPreparaConClb;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('BAS_UNIDAD', 'Código Unidade');
  pAddColunaSql('BAS_CONTEU', 'Conteudo');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMeg;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;

end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMif;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConGra;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_COLECA', 'Coleção');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Volume', 3);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;

end;


procedure TGerenciaConsultasBaseTinta.pPreparaConFal;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_LINHA_', 'Linha');
  pAddColunaSql('BAS_DESLIN', 'Descrição da Linha');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_DESCRI', 'Descrição da base');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConShw;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_DESCRI', 'Descrição da base');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;


procedure TGerenciaConsultasBaseTinta.pPreparaConSin;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConCoa;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConCorImo;
begin
  pAddColunaSql('BAS_BASE__', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_CODEMP', 'Empresa');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConCorInd;
begin
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_CODEMP', 'Empresa');
  pAddColunaSql('BAS_CODGRU', 'Cód. Grupo');
  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConCsn;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConDac;
begin
  pAddColunaSql('BAS_CODFML', 'Código');
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
//  pAddColunaSql('BAS_CODGRU', 'Cód. Grupo');
  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
  If FopcConsulta = conDacGroupFML Then
    FstrGroup := ' GROUP BY BAS_CODFML, BAS_BASE__';
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConDca;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConDox;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESGRA', 'Peso Granel');
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConDu2;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESGRA', 'Peso em Gramas');
  pAddColunaSql('BAS_TIPO__', 'Tipo');
  pAddColunaSql('BAS_LINHA_', 'Linha');
//  pAddColunaSql('BAS_QUALID', 'Qualidade');
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConDup;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESGRA', 'Peso em Gramas');
  pAddColunaSql('BAS_TIPO__', 'Tipo');
  pAddColunaSql('BAS_LINHA_', 'Linha');
  pAddColunaSql('BAS_QUALID', 'Qualidade');
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConDux;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESGRA', 'Peso em Gramas');
  pAddColunaSql('BAS_TIPO__', 'Tipo');
  pAddColunaSql('BAS_LINHA_', 'Linha');
//  pAddColunaSql('BAS_QUALID', 'Qualidade');
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;


procedure TGerenciaConsultasBaseTinta.pPreparaConEUC;
begin
  pAddColunaSql('BAS_DESCRI', 'Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddFinalSql;
//  FstrGroup := ' GROUP BY BAS_PRODUT ';
  pSetarRetorno('BAS_PRODUT', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMae;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMax;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_CONTEU', 'Conteudo', 4);
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMaz;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMon;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição da base');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_ACABAM', 'Acabamento');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMza;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_LINHA_', 'Linha');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EFEITO', 'Efeito');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAjt;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;


procedure TGerenciaConsultasBaseTinta.pPreparaConMzd;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_LINHA_', 'Linha');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EFEITO', 'Efeito');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConMzi;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição da base');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConPfa;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODBAR', 'Código Barra');
  pAddColunaSql('BAS_SKUFAB', 'Sku');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConPPG_NEX;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_TIPO__', 'Tipo');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConPro;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');


  FstrSQL := FstrSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM  ';
  FstrSQL := FstrSQL + '   PRT_CADBAS AS B ';

  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE '
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE ';

  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConRec;
begin
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConRei;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_UNIDAD', 'Código Unidade');
  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConRen;
begin
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConRep;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PESESP', 'Peso Específico');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Embalagem');

  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConSal;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição');
  pAddColunaSql('BAS_LINHA_', 'Linha');
  pAddColunaSql('BAS_PESBAS', 'Peso Base');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConSay;
begin
  pAddColunaSql('BAS_CODBAS','Base');
  pAddColunaSql('BAS_BASE__', 'Descrição Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_DESEMB', 'Embalagem');
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  If FblnComProdutos Then
    FstrSQL := FstrSQL + '   INNER JOIN SAY_CADEMB ON BAS_DESEMB = EMB_DESEMB '
  Else
    FstrSQL := FstrSQL + '   LEFT JOIN SAY_CADEMB ON BAS_DESEMB = EMB_DESEMB ';
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConSta;
begin
  pAddColunaSql('BAS_CODBAS','Base');
  pAddColunaSql('BAS_DESBAS','Descrição');
  pAddColunaSql('BAS_VOLUME','Volume');
  pAddColunaSql('BAS_PESESP','Peso Específico');
  pAddColunaSql('BAS_CODITE','Código do Item');
  pAddColunaSql('ITE_DESITE','Descrição do Item');
  pAddColunaSql('ITE_REFERE','Referência do Item');
  pAddFinalSql;
  FstrGroup := ' GROUP BY BAS_CODBAS ';
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConStaWeb;
begin
  pAddColunaSql('BAS_CODBAS','Base');
  pAddColunaSql('BAS_DESBAS','Descrição');
  pAddColunaSql('BAS_EMBALA','Embalagem');
  pAddColunaSql('BAS_PESESP','Peso Específico');
  pAddColunaSql('BAS_CODITE','Código do Item');
  pAddColunaSql('ITE_DESITE','Descrição do Item');
  pAddColunaSql('ITE_REFERE','Referência do Item');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConSuv;
begin
  pAddColunaSql('SUV_CODBAS', 'Código Base');
  pAddColunaSql('SUV_CODFML', 'Código Formula');
  pAddColunaSql('SUV_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('SUV_CODUNI', 'Código Unidade');
  pAddColunaSql('UNI_SIGUNI', 'Unidade');
  pAddColunaSql('SUV_DESCRI', 'Descrição Base');
  pAddColunaSql('SUV_MARGEM', 'Margem', 2);
  pAddColunaSql('SUV_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('SUV_PREVEN', 'Preço Venda', 2);

  FstrSQL := FstrSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM  ';
  FstrSQL := FstrSQL + ' 	' + FstrTabela + ' AS B ';
  FstrSQL := FstrSQL + IfThen(FblnComProdutos, ' INNER', ' LEFT') + ' JOIN CADITE I ON B.SUV_CODITE = I.ITE_CODITE ';
  FstrSQL := FStrSQL + ' INNER JOIN CADUNI U ON B.SUV_CODUNI = U.UNI_CODUNI     ';

  pSetarRetorno('SUV_CODBAS', 'SUV_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConTex;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_DESEMB', 'Descrição Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConUni;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Descrição Base');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddFinalSql;
  pSetarOrdenacao(['BAS_PRODUT']);
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConVel;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_PRODUT', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_CODUNI', 'Unidade');

  FstrSQL := FstrSQL + '   B.AUTOINCREM  ';
  FstrSQL := FstrSQL + ' FROM            ';
  FstrSQL := FstrSQL + '   VEL_CADBAS B  ';
  FstrSQL := FstrSQL + '   LEFT JOIN CADUNI ON UNI_CODUNI = BAS_CODUNI  ';

  FstrSQL := FstrSQL + IfThen(FblnComProdutos, ' INNER', ' LEFT') + ' JOIN CADITE  ON BAS_CODITE = ITE_CODITE ';

  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConZyn;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PESPEC', 'Peso Especifico');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConFar;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_DENSID', 'Densidade');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_EMBALA', 'Embalagem',4);
  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
End;

procedure TGerenciaConsultasBaseTinta.pPreparaConFut;
begin
  pAddColunaSql('BAS_CODFML', 'Fórmula');
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConGbc;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConGen;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_OBSERV', 'Observação');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConJot;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;

end;

procedure TGerenciaConsultasBaseTinta.pPreparaConGla;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_LINHA_', 'Linha/Grupo');
  pAddColunaSql('BAS_DESBAS', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PESBAS', 'Peso Base');
  pAddColunaSql('BAS_VALBAS', 'Valor Base');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODEMP');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConGlo;
begin
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('ITE_CODITE');
  pAddFinalSqL;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');

end;

procedure TGerenciaConsultasBaseTinta.pPreparaConHyd;
begin
  pAddColunaSql('BAS_BASE__', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_CODEMB', 'Cód. Embalagem');
  pAddColunaSql('EMB_DESEMB', 'Embalagem');
  pAddColunaSql('EMB_CODUNI', 'Unidade');
  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
  FstrSQL := FstrSQL + '   LEFT JOIN INT_CADEMB E ON BAS_CODEMB = EMB_CODEMB  ';
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConInk;
begin
  pAddColunaSql('BAS_BASE__', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_CONTEU', 'Conteudo');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('ITE_CODITE');

  pAddFinalSqL;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConInt;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_CODEMB', 'Cód. Embalagem');
  pAddColunaSql('EMB_DESEMB', 'Embalagem');
  pAddColunaSql('EMB_CODUNI', 'Unidade');
  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
  FstrSQL := FstrSQL + '   LEFT JOIN INT_CADEMB E ON BAS_CODEMB = EMB_CODEMB  ';
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLec;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('BAS_CATALI', 'Catálise');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PESESP', 'Peso Específico');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Embalagem');

  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLei;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConIqu;
begin
  pAddColunaSql('BAS_BASE__', 'Código Base');
  pAddColunaSQL('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_EMBALA', 'Embalagem', 2);
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');
  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConKil;
begin
  pAddColunaSql('BAS_CODFML', 'Código Formula');
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_CODEMP');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  IF FopcConsulta  = conKild Then
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConKin;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConKre;
begin
  pAddColunaSql('BAS_BASE__', 'Código Base');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_CONTEU', 'Conteúdo');
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLaz;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESBAS', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddFinalSql;
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLca;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referencia');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_PESESP', 'Peso Especifico', 3);
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConAlv;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');


  FstrSQL := FstrSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM  ';
  FstrSQL := FstrSQL + '   ALV_CADBAS AS B ';

  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE '
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE ';

  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLik;
begin
  pAddColunaSql('BAS_BASE__', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição Base');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarOrdenacao(['BAS_BASE__']);
  pSetarRetorno('BAS_BASE__', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLkc;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('BAS_UNIDAD', 'Código Unidade');
  pAddColunaSql('BAS_CONTEU', 'Conteudo');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLks;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODPRO', 'Código Produto');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('BAS_CODUNI', 'Código Unidade');
  pAddColunaSql('BAS_CODGRU', 'Grupo');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConLuz;
begin
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_UNIDAD', 'Unidade');
  pAddColunaSql('BAS_EMBALA', 'Embalagem');
  pAddColunaSql('BAS_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('ITE_CODITE');

  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_PRODUT');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConSky;
begin
  pAddColunaSql('BAS_CODPRO', 'Código Produto');
  pAddColunaSql('BAS_CODBAS', 'Código Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_PESESP', 'Peso Especifico');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('BAS_CODUNI', 'Código Unidade');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_EMBALA', 'Emablagem');
  pAddColunaSql('BAS_ICMS__',  'ICMS');
  pAddColunaSql('BAS_IPI___',  'IPI');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConSol;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição');
  pAddColunaSql('BAS_CODITE', 'Código Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('BAS_PRECUS', 'Preço de Custo', 2);
  pAddColunaSql('BAS_PREVEN', 'Preço de Venda', 2);
  pAddColunaSql('BAS_MARGEM', 'Margem', 2);
  pAddColunaSql('BAS_CODUNI', 'Código Unidade');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');
end;

procedure TGerenciaConsultasBaseTinta.pPreparaConSpa;
begin
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_PRODUT', 'Produto');
  pAddColunaSql('BAS_CODUNI', 'Unidade');
  pAddColunaSql('BAS_DESCRI', 'Descrição da base');
  pAddColunaSql('BAS_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddFinalSql;
  pSetarRetorno('BAS_CODBAS', 'BAS_DESCRI');

end;

procedure TGerenciaConsultasBaseTinta.pPreparaWanda;
begin
  FstrSQL := 'SELECT SQL_NO_CACHE ';
  pAddColunaSql('BAS_LINHA_', 'Linha');
  pAddColunaSql('BAS_CODBAS', 'Base');
  pAddColunaSql('BAS_DESBAS', 'Descricao');
  If FopcConsulta in [conWanda, conWandaPro] Then
  Begin
    if FopcConsulta = conWanda Then
      pAddColunaSql('BAS_PESBAS', 'Peso Específico');
    pAddColunaSql('BAS_CODITE', 'Código do Item');
    pAddColunaSql('ITE_DESITE', 'Descrição do Item');
    pAddColunaSql('ITE_REFERE', 'Referência do Item');
    If FopcConsulta = conWandaPro Then
      pAddColunaSql('BAS_EMBALA', 'Embalagem');
  End;

  pAddFinalSql;

  If FopcConsulta in [conWandaLinha, conWandaLinha] Then
     FstrGroup := 'GROUP BY BAS_LINHA_, BAS_CODBAS, BAS_DESBAS';
  pSetarOrdenacao(['BAS_LINHA_']);
end;

procedure TGerenciaConsultasBaseTinta.pAddFinalSql;
begin
  FstrSQL := FstrSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM  ';
  FstrSQL := FstrSQL + ' 	' + FstrTabela + ' AS B ';

  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE '
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE ';

  If FopcConsulta in [conDup] Then
  Begin
    If fCfgSis('EMPBDU',varBoolean) Then
      FstrWhere := FstrWhere + ' AND BAS_CODEMP = ' + QuotedStr(VS_strCodEmp);
  End
  Else If FopcConsulta in [conDux] Then
  Begin
    If fCfgSis('EMPBDX',varBoolean) Then
      FstrWhere := FstrWhere + ' AND BAS_CODEMP = ' + QuotedStr(VS_strCodEmp);
  End
  Else If FopcConsulta in [conDu2] Then
  Begin
    If fCfgSis('EMPBD2',varBoolean) Then
      FstrWhere := FstrWhere + ' AND BAS_CODEMP = ' + QuotedStr(VS_strCodEmp);
  End;
end;

procedure TGerenciaConsultasBaseTinta.pSetarOrdenacao(Ordenacao: TArrayString);
begin
  If Length(Ordenacao) = 0 Then
     FarrOrdenacao := ['BAS_CODBAS']
  Else
    FarrOrdenacao := Ordenacao;
end;

procedure TGerenciaConsultasBaseTinta.pSetarRetorno(CampoBase, CampoDescricaoBase: String);
begin
  FstrCampoBase := CampoBase;
  FstrCampoDescricaoBase := CampoDescricaoBase;
end;

{ TGerenciaConsultaTinta }

constructor TGerenciaConsultaTinta.Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = '');
begin

  FOpcConsulta := opcConsulta;
  pSetSiglaTinta;
  pSetNomeTinta;

  If (CampoRelacionamento <> '') Then
  begin
    FobjConsulta := TDefTintaRelacionamento.Create;
    TDefTintaRelacionamento(FobjConsulta).FCampoRelacionamento := campoRelacionamento;
  End
  Else
    FobjConsulta := TDefConsulta.Create;

  If FstrWhere = '' Then
    FstrWhere := ' WHERE TRUE ';
end;

destructor TGerenciaConsultaTinta.Destroy;
begin
  FreeAndNil(FobjConsulta);
end;

procedure TGerenciaConsultaTinta.pAddColunaSql(Campo: String = ''; NomeGrid: String = ''; Decimal: integer = 0;  blnVirgula: Boolean = True);
begin
  FStrSql := FstrSQL + '  ' + Campo + IfThen(blnVirgula, ', ', '');
  If NomeGrid <> '' Then
     pAddNomeColuna(NomeGrid);
  If NomeGrid <> '' Then
     pAddFiltros(Campo);
  If Decimal > 0 Then
  Begin
     objConsulta.pFormataDecimal(Campo, Decimal);
     SetLength(FFormats, Succ(Length(FFormats)));
     FFormats[High(FFormats)].strNomeCampo  := Campo;
     FFormats[High(FFormats)].strFormat     := '#0.' + Format('%0.' + IntToStr(Decimal) + 'd', [0]);
  End;
end;

procedure TGerenciaConsultaTinta.pAddFiltros(strNomCol: String);
begin
    SetLength(FarrCampoFiltro, Succ(Length(FarrCampoFiltro)));
    FarrCampoFiltro[High(FarrCampoFiltro)] := strNomCol;
end;

procedure TGerenciaConsultaTinta.pAddNomeColuna(strNomCol: String);

begin
  SetLength(FarrTitCol, Succ(Length(FarrTitCol)));
  FarrTitCol[High(arrTitCol)] := strNomCol;
end;

procedure TGerenciaConsultaTinta.pFormatarCampos(qryTabela: TUniQuery);
  var strCampo: TFormat;
begin
  If Assigned(qryTabela) Then
    For strCampo in FFormats do
      TFloatField(qryTabela.FieldByName(strCampo.strNomeCampo)).DisplayFormat := strCampo.strFormat;
end;

procedure TGerenciaConsultaTinta.pSetNomeTinta;
begin
  Case FopcConsulta Of
    conAdt: FstrNomeTinta := 'Advance TintoSystem';
    conAjt: FstrNomeTinta := 'Anjo Automotiva';
    conAdv: FstrNomeTinta := 'Advance';
    conAdvCor: FstrNomeTinta := 'Advance';
    conAja: FstrNomeTinta := 'Anjo Sintética';
    conAnj: FstrNomeTinta := 'Anjo';
    conAnn: FstrNomeTinta := 'Annetta';
    conAle: FstrNomeTinta := 'Alessi';
    conAut: FstrNomeTinta := 'Auto';
    conBau: FstrNomeTinta := 'Bautech';
    conQua: FstrNomeTinta := 'Qualyvinil';
    conBel: FstrNomeTinta := 'BellaCor';
    conCia: FstrNomeTinta := 'Ciacollor';
    conJot: FstrNomeTinta := 'Jotun';
    conMEg: FstrNomeTinta := 'Mega Tintas';
    conGra: FstrNomeTinta := 'Grafftex';
    conBza: FstrNomeTinta := 'Brasimix Automotiva';
    conBzi, conBziLinha: FstrNomeTinta := 'Brasimix Imobiliária';
    conBzc: FstrNomeTinta := 'BrazilianColor Automotiva';
    conCal: FstrNomeTinta := 'Calamar';
    conCorImo: FstrNomeTinta := 'Coral Imobiliária';
    conCorInd: FstrNomeTinta := 'Coral Industrial';
    conDac, conDacGroupFML: FstrNomeTinta := 'Dacar';
    conDox: FstrNomeTinta := 'Standox';
    conDup: FstrNomeTinta := 'Axalta';
    conDux: FstrNomeTinta := 'Duxone Global';
    conDu2: FstrNomeTinta := 'Duxone Global 2';
    conEuc: FstrNomeTinta := 'Eucatex';
    conFar: FstrNomeTinta := 'Farben Automotiva';
    conFut: FstrNomeTinta := 'Futura';
    conGen: FstrNomeTinta := 'General';
    conGla: FstrNomeTinta := 'Glasurit';
    conGlo: FstrNomeTinta := 'Global Color';
    conHyd: FstrNomeTinta := 'Hydronorth Imobiliária';
    conInt: FstrNomeTinta := 'International';
    conLec: FstrNomeTinta := 'Lechler Industrial';
    conIqu: FstrNomeTinta := 'Iquine';
    conKil, conKild: FstrNomeTinta  := 'Killing';
    conLaz: FstrNomeTinta := 'Lazzumix';
    conLik: FstrNomeTinta := 'Liko';
    conLks,conLkd: FstrNomeTinta := 'Lukscolor';
    conLkc: FstrNomeTinta := 'Lukscolor 2';
    conMaz: FstrNomeTinta := 'Maza';
    conMza: FstrNomeTinta := 'Maza Automotiva';
    conMzd: FstrNomeTinta := 'Maza Industrial';
    conMzi: FstrNomeTinta := 'Maza Imobiliária';
    conSpa: FstrNomeTinta := 'Sparlack Industrial';
    conFal: FstrNomeTinta := 'Falcão';
    conShw: FstrNomeTinta := 'Sherwin Williams 2';
    conNex: FstrNomeTinta := 'Nexa Autocolor';
    conMon: FstrNomeTinta := 'Montana';
    conPPG: FstrNomeTinta := 'PPG';
    conPPX: FstrNomeTinta := 'PPG/NEXA';
    conRec: FstrNomeTinta := 'Recoa';
    conRei: FstrNomeTinta := 'Renner Imobiliária';
    conRen: FstrNomeTinta := 'Renner Industrial';
    conRsi: FstrNomeTinta := 'Resicolor';
    conSay: FstrNomeTinta := 'Sayerlack';
    conSal: FstrNomeTinta := 'Salcomix';
    conShe: FstrNomeTinta := 'Sherwin Williams';
    conSky: FstrNomeTinta := 'Skymix Automotiva';
    conSol: FstrNomeTinta := 'Color Braz';
    conSta: FstrNomeTinta := 'Starmix';
    conStaWeb: FstrNomeTinta := 'Starmix Web / W-Mix';
    ConSuv: FstrNomeTinta := 'Suvinil';
    conUni: FstrNomeTinta := 'Universo';
    conVel: FstrNomeTinta := 'Velutex Imobiliária';
    conWanda, conWandaLinha: FstrNomeTinta := 'WAN';
    conWandaPro, conWandaProLinha: FstrNomeTinta := 'Color Pro';
    conWeg: FstrNomeTinta := 'Weg';
    conZyn: FstrNomeTinta := 'Zynamix';
    conInk: FstrNomeTinta := 'Inkor';
    conKre: FstrNomeTinta := 'Kresil';
    conKin: FstrNomeTinta := 'Killing Industrial';
    conRob: FstrNomeTinta := 'Roberlo';
    conMax: fstrNomeTinta := 'MaxVinil';
    conAlp: fStrNomeTinta := 'Alter Plus';
    conBsn: fStrNomeTinta := 'Global Bsn';
    conCsn: fStrNomeTinta := 'Global Csn';
    conGbc: fStrNomeTinta := 'Global BC';
    conClb: fStrNomeTinta := 'Colorbraz';
    conBlt: fStrNomeTinta := 'BellaCor - Tintavel';
    conAlk: fStrNomeTinta := 'Autoluks';
    conCoa: fStrNomeTinta := 'Top Coat';
    conMif: fStrNomeTinta := 'Mini Fábrica';
    conC11: fStrNomeTinta := 'Global Cc11';
    conTex: fStrNomeTinta := 'Textura e Cia';
    conChr: fStrNomeTinta := 'Chreon';
    conAds: fStrNomeTinta := 'Advance Str';
    conLei: fStrNomeTinta := 'Leinertex';
    conMae: fStrNomeTinta := 'Maestria';
    conSin: fStrNomeTinta := 'Sinteplast';
    conDca: fStrNomeTinta := 'Dacasa';
    conLuz: fStrNomeTinta := 'Luztol';
    conRep: fStrNomeTinta := 'Renner Performance';
    conPrt: fStrNomeTinta := 'Profissional Tintas';
    conAn2: fStrNomeTinta := 'Anjo Imobiliária 2';
    conRs2: fStrNomeTinta := 'Resicolor 2';
    conLca: fStrNomeTinta := 'Lechler Automotiva';
    conAlv: fStrNomeTinta := 'ALV Industrial';
    conPfa: fStrNomeTinta := 'Profissional Automotiva';
    conAla: fStrNomeTinta := 'ALV Automotiva';
    conBla: fStrNomeTinta := 'Blascor Automotiva';
  End;

end;

procedure TGerenciaConsultaTinta.pSetSiglaTinta;
begin
  Case FopcConsulta Of
    conAdt: FstrSiglaTinta := 'ADT';
    conAdv: FstrSiglaTinta := 'ADV';
    conAdvCor: FstrSiglaTinta := 'ADVCOR';
    conAja: FstrSiglaTinta := 'AJA';
    conAnj: FstrSiglaTinta := 'ANJ';
    conAnn: FstrSiglaTinta := 'ANN';
    conAle: FstrSiglaTinta := 'ALE';
    conAut: FstrSiglaTinta := 'AUT';
    conBau: FstrSiglaTinta := 'BAU';
    conQua: FstrSiglaTinta := 'QUA';
    conBel: FstrSiglaTinta := 'BEL';
    conCia: FstrSiglaTinta := 'CIA';
    conJot: FstrSiglaTinta := 'JOT';
    conMeg: FstrSiglaTinta := 'MEG';
    conGra: FstrSiglaTinta := 'GRA';
    conBza: FstrSiglaTinta := 'BZA';
    conBzi, conBziLinha: FstrSiglaTinta := 'BZI';
    conBzc: FstrSiglaTinta := 'BZC';
    conCal: FstrSiglaTinta := 'CAL';
    conCorImo: FstrSiglaTinta := 'CORIMO';
    conCorInd: FstrSiglaTinta := 'CORIND';
    conDac, conDacGroupFML: FstrSiglaTinta := 'DAC';
    conDox: FstrSiglaTinta := 'DOX';
    conDup: FstrSiglaTinta := 'DUP';
    conDux: FstrSiglaTinta := 'DUX';
    conDu2: FstrSiglaTinta := 'DU2';
    conEuc: FstrSiglaTinta := 'EUC';
    conFar: FstrSiglaTinta := 'FAR';
    conFut: FstrSiglaTinta := 'FUT';
    conGen: FstrSiglaTinta := 'GEN';
    conGla: FstrSiglaTinta := 'GLA';
    conGlo: FstrSiglaTinta := 'GLO';
    conHyd: FstrSiglaTinta := 'HYD';
    conInt: FstrSiglaTinta := 'INT';
    conLec: fstrSiglaTinta := 'LEC';
    conIqu: FstrSiglaTinta := 'IQU';
    conKil: FstrSiglaTinta := 'KILD';
    conKild: FstrSiglaTinta := 'KILD';
    conLaz: FstrSiglaTinta := 'LAZ';
    conLik: FstrSiglaTinta := 'LIK';
    conLks: FstrSiglaTinta := 'LKS';
    conLkd: FstrSiglaTinta := 'LKD';
    conLkc: FstrSiglaTinta := 'LKC';
    conMaz: FstrSiglaTinta := 'MAZ';
    conMza: FstrSiglaTinta := 'MZA';
    conAjt: FstrSiglaTinta := 'AJT';
    conMzd: FstrSiglaTinta := 'MZD';
    conMzi: FstrSiglaTinta := 'MZI';
    conSpa: FstrSiglaTinta := 'SPA';
    conFal: FstrSiglaTinta := 'FAL';
    conShw: FstrSiglaTinta := 'SHW';
    conMon: FstrSiglaTinta := 'MON';
    conNex: FstrSiglaTinta := 'NEX';
    conPPG: FstrSiglaTinta := 'PPG';
    conPPX: FstrSiglaTinta := 'PPX';
    conRec: FstrSiglaTinta := 'REC';
    conRei: FstrSiglaTinta := 'REI';
    conRen: FstrSiglaTinta := 'REN';
    conRsi: FstrSiglaTinta := 'RSI';
    conSay: FstrSiglaTinta := 'SAY';
    conSal: FstrSiglaTinta := 'SAL';
    conShe: FstrSiglaTinta := 'SHE';
    conSky: FstrSiglaTinta := 'SKY';
    conSol: FstrSiglaTinta := 'SOL';
    conSta: FstrSiglaTinta := 'STA';
    conStaWeb: FstrSiglaTinta := 'STW';
    ConSuv: FstrSiglaTinta := 'SUV';
    conUni: FstrSiglaTinta := 'UNI';
    conVel: FstrSiglaTinta := 'VEL';
    conWanda, conWandaLinha: FstrSiglaTinta := 'WAN';
    conWandaPro, conWandaProLinha: FstrSiglaTinta := 'WANPRO';
    conWeg: FstrSiglaTinta := 'WEG';
    conZyn: FstrSiglaTinta := 'ZYN';
    conInk: FstrSiglaTinta := 'INK';
    conKre: FstrSiglaTinta := 'KRE';
    conKin: FstrSiglaTinta := 'KIN';
    conRob: FstrSiglaTinta := 'ROB';
    conMax: FStrSiglaTinta := 'MAX';
    conAlp: FStrSiglaTinta := 'ALP';
    conBsn: FStrSiglaTinta := 'BSN';
    conCsn: FStrSiglaTinta := 'CSN';
    conGbc: FStrSiglaTinta := 'GBC';
    conClb: FStrSiglaTinta := 'CLB';
    conBlt: FStrSiglaTinta := 'BLT';
    conAlk: FStrSiglaTinta := 'ALK';
    conCoa: FStrSiglaTinta := 'COA';
    conMif: FStrSiglaTinta := 'MIF';
    conC11: FStrSiglaTinta := 'C11';
    conTex: FStrSiglaTinta := 'TEX';
    conChr: FStrSiglaTinta := 'CHR';
    conAds: FStrSiglaTinta := 'ADS';
    conLei: FStrSiglaTinta := 'LEI';
    conMae: FStrSiglaTinta := 'MAE';
    conSin: FStrSiglaTinta := 'SIN';
    conDca: FStrSiglaTinta := 'DCA';
    conLuz: FStrSiglaTinta := 'LUZ';
    conRep: FStrSiglaTinta := 'REP';
    conPrt: FStrSiglaTinta := 'PRT';
    conAn2: FStrSiglaTinta := 'AN2';
    conRs2: FStrSiglaTinta := 'RS2';
    conLca: FStrSiglaTinta := 'LCA';
    conAlv: FStrSiglaTinta := 'ALV';
    conPfa: FStrSiglaTinta := 'PFA';
    conAla: FStrSiglaTinta := 'ALA';
    conBla: FStrSiglaTinta := 'BLA';
  End;
end;

{ TGerenciaConsultaEmbalagemTinta }

constructor TGerenciaConsultaEmbalagemTinta.Create(opcConsulta: TTipoTintas);
begin
  Inherited Create(opcConsulta);

  If opcConsulta = conDac Then
    FstrTabela := FstrSiglaTinta + '_UNIDAC'
  Else
    FstrTabela := FstrSiglaTinta + '_CADEMB';

  FstrTituloTela := 'Consulta de Embalagens';
  FstrSQL := ' SELECT SQL_NO_CACHE';
  case opcConsulta of
    conAle : pPreparaAlessi;
    conVel : pPreparaVelutex;
    conSay : pPreparaConSay;
    conAdt : pPreparaConAdt;
    conDac : pPreparaConDac;
    conInt, conHyd, conCal : pPreparaGenerica2;
    conCorImo, conGlo, conAnj, conMzi, conRec, conAnn, conRen, conLik, conShe, conLkd, conIqu, conRsi, conWeg, conAdvCor, conAja: pPreparaGenerica;
  End;
end;

procedure TGerenciaConsultaEmbalagemTinta.pPreparaAlessi;
begin
  pAddColunaSql('E.EMB_NOME__', 'Embalagem');
  pAddColunaSql('E.EMB_QTDEMB', 'Tamanho Embalagem');
  pAddColunaSql('E.EMB_CODUNI', 'Unidade');
  pAddColunaSql('U.UNI_DESUNI', 'Descrição Unidade');
  pAddColunaSql('U.UNI_SIGUNI', 'Sigla Unidade');
  FstrSql := fstrSql + ' E.AUTOINCREM    ';
  FstrSql := fstrSql + ' FROM            ';
  FstrSql := fstrSql + '   ALE_CADEMB  E ';
  FstrSql := fstrSql + '   LEFT JOIN CADUNI U ON EMB_CODUNI = UNI_CODUNI ';

  FstrTituloTela := 'Consulta de Embalagens';
  FarrOrdenacao  := ['EMB_NOME__'];
  FstrTabela     := 'ALE_CADEMB';

  {*Campos de Retorno para os edits*}
  FstrCodUnidade := 'EMB_CODUNI';
  FstrCodEmbalagem := 'EMB_CODUNI';
  FstrQuantidade := 'EMB_QTDEMB'
end;

procedure TGerenciaConsultaEmbalagemTinta.pPreparaConAdt;
begin
  pAddColunaSql('EMB_DESCRI', 'Embalagem');
  pAddColunaSql('EMB_CODEMB', 'Código');
  pAddColunaSql('EMB_CODUNI', 'Unidade');
  FstrSQL := FstrSQL + '   E.AUTOINCREM ';
  FStrSQL := FStrSQL +   ' FROM ' + FstrTabela + ' E';
  FstrTituloTela := 'Consulta de Embalagens';
  FarrOrdenacao  := ['EMB_DESCRI'];

  {*Campos de Retorno para os edits*}
  FstrCodUnidade := 'EMB_CODUNI';
  FstrCodEmbalagem := 'EMB_CODEMB';
end;

procedure TGerenciaConsultaEmbalagemTinta.pPreparaConDac;
begin
  pAddColunaSql('DAC_UNIDAC', 'Unidade Dacar');
  pAddColunaSql('DAC_UNIAUT', 'Unidade Autcom');
  FstrSQL := FstrSQL + '   E.AUTOINCREM ';
  FStrSQL := FStrSQL + ' FROM ' + FstrTabela + ' E';
  FstrTituloTela := 'Relação de Unidades';
  FarrOrdenacao  := ['DAC_UNIDAC'];
end;

procedure TGerenciaConsultaEmbalagemTinta.pPreparaConSay;
begin
  pAddColunaSql('EMB_DESEMB', 'Embalagem');
  pAddColunaSql('EMB_CODUNI', 'Unidade');
  pAddColunaSql('UNI_DESUNI', 'Descrição Unidade');
  pAddColunaSql('UNI_SIGUNI', 'Sigla Unidade');
  pAddColunaSql('EMB_EMBALA', 'Qtd.');
  FstrSQL := FstrSQL + '   E.AUTOINCREM ';
  FStrSQL := FStrSQL + ' FROM ' + FstrTabela + ' E';
  FstrSQL := FstrSQL + '   LEFT JOIN CADUNI  ON UNI_CODUNI = E.EMB_CODUNI';
  FstrTituloTela := 'Consulta de Embalagens';
  FarrOrdenacao  := ['EMB_NOME__'];

  {*Campos de Retorno para os edits*}
  FstrCodUnidade := 'EMB_CODUNI';
  FstrCodEmbalagem := 'EMB_DESEMB';
  FstrQuantidade := 'EMB_EMBALA'
end;

procedure TGerenciaConsultaEmbalagemTinta.pPreparaGenerica2;
begin
  pAddColunaSql('EMB_CODEMB', 'Código');
  If FopcConsulta = conCal Then
    pAddColunaSql('EMB_DESCRI', 'Descrição Embalagem')
  Else
    pAddColunaSql('EMB_DESEMB', 'Descrição Embalagem');
  pAddColunaSql('EMB_TAMEMB', 'Tamanho');
  pAddColunaSql('EMB_CODUNI', 'Unidade');
  pAddColunaSql('UNI_DESUNI', 'Descrição Unidade');
  pAddColunaSql('UNI_SIGUNI', 'Sigla Unidade');
  FstrSQL := FstrSQL + '   E.AUTOINCREM ';
  FStrSQL := FStrSQL +   ' FROM ' + FstrTabela + ' E';
  FstrSQL := FstrSQL + '   INNER JOIN CADUNI  ON E.EMB_CODUNI = UNI_CODUNI  ';
  FstrTituloTela := 'Consulta de Embalagens';
  FarrOrdenacao  := ['EMB_NOME__'];

  {*Campos de Retorno para os edits*}
  FstrCodUnidade := 'EMB_CODUNI';
  FstrCodEmbalagem := 'EMB_CODEMB';
  FstrQuantidade := 'EMB_TAMEMB'

end;

procedure TGerenciaConsultaEmbalagemTinta.pPreparaGenerica;
begin
  pAddColunaSql('EMB_CODEMB', 'Código');
  pAddColunaSql('EMB_QTDEMB', 'Quantidade');
  pAddColunaSql('EMB_UNIDAD', 'Unidade');
  FstrSQL := FstrSQL + '   AUTOINCREM ';
  FStrSQL := FStrSQL +   ' FROM ' + FstrTabela;
  FarrOrdenacao  :=  ['EMB_CODEMB'];

  {*Campos de Retorno para os edits*}
  FstrCodUnidade := 'EMB_CODEMB';
  FstrCodEmbalagem := 'EMB_CODEMB';
  FstrQuantidade := 'EMB_QTDEMB'
end;

procedure TGerenciaConsultaEmbalagemTinta.pPreparaVelutex;
begin
  pAddColunaSql('EMB_TAMEMB', 'Embalagem');
  pAddColunaSql('EMB_PRODUT', 'Produto');
  pAddColunaSql('EMB_MULTPL', 'Multiplicador');

  pAddColunaSql('UNI_CODUNI', 'Código');
  pAddColunaSql('UNI_DESUNI', 'Descrição');
  pAddColunaSql('UNI_SIGUNI', 'Sigla');

  pAddColunaSql('EMB_CODUNI', 'Unidade');

  FStrSQL := FStrSQL + '    E.AUTOINCREM ';
  FStrSQL := FStrSQL + '  FROM VEL_EMBALA E';
  FstrSQL := FstrSQL + ' INNER JOIN CADUNI  ON UNI_CODUNI = E.EMB_CODUNI ';

  FarrOrdenacao  :=  ['EMB_PRODUT'];
//  FstrTabela     := 'CADUNI';

  {*Campos de Retorno para os edits*}
  FstrCodUnidade   := 'UNI_CODUNI';
  FstrCodEmbalagem := 'UNI_CODUNI';
  FstrQuantidade   := 'UNI_PESLIT'
  { ******************************* }
end;



{ TGerenciaConsultaColorante }


constructor TGerenciaConsultaColorante.Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = ''; blnComProdutos: Boolean = True);
begin
  Inherited Create(opcConsulta, campoRelacionamento);
  FblnComProdutos := blnComProdutos;

  FstrTituloTela := 'Consulta de Colorantes';
  FstrTabela := FstrSiglaTinta + '_CADCOL';
  Case opcConsulta of
    conAdt, conAdv, conCal, conFal, conBzi, ConLec, conAds, conRep, conAlv : pPreparaDefaultTodosCampos;

    conAdvCor,
    conAja,
    conAnj,
    conAnn,
    conBau,
    conQua,
    conBel,
    conCia,
    conJot,
    conMeg,
    conGra,
    conGlo,
    conKild,
    conSpa,
    conLik,
    conLkd,
    conRei,
    conSay,
    conRen,
    conRsi,
    conShe,
    conUni,
    conWeg,
    conLkc,
    conInk,
    conKre,
    conMax,
    conAlp,
    conBsn,
    conCsn,
    conGbc,
    conClb,
    conBlt,
    conC11,
    conTex,
    conChr,
    conLei,
    conMae,
    conSin,
    conDca,
    conLuz,
    conPrt,
    conAn2,
    conRs2: pPreparaDefaultSemCOL_PESESP;

    conAle,
    conCorImo,
    conCorInd,
    conDac,
    conEuc,
    conFut,
    conHyd,
    conInt,
    conIqu,
    conKil,
    conMon,
    conLks,
    conMaz,
    conMzi,
    conRec,
    conSol,
    conSuv,
    conShw,
    conVel: pPreparaDefaultSemCOL_PESESP_e_COL_DESCRI;
  end;
  FstrCodColorante := 'COL_CODCOL';
  FstrCodigoItem   := 'COL_CODITE';
end;

procedure TGerenciaConsultaColorante.pPreparaDefaultTodosCampos;
begin
  FstrSQL := FstrSQL + '  SELECT SQL_NO_CACHE ';
  pAddColunaSql('COL_CODCOL', 'Código do Colorante');

  If Not (FopcConsulta in [conFal, conShw, conBzi]) Then
    pAddColunaSql('COL_DESCRI', 'Descrição do Colorante');

  pAddColunaSql('COL_PESESP', 'Peso Específico');
  pAddColunaSql('COL_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');


  If (FopcConsulta in [conAdv,conAdt, conFal, conShw, conAnj, conAja, conCal, conEuc, conHyd, conInt, conLec, conSay, conSuv, conAds, conBzi, conRep, conAlv]) Then
    pAddColunaSql('COL_EMBALA', 'Embalagem',4)
  else if (FopcConsulta in [conAdvCor]) Then
    pAddColunaSql('COL_PESCOL', 'Embalagem',4)
  else if (FopcConsulta in [conDac]) Then
    pAddColunaSql('DAC_EMBALA', 'Embalagem',4);

  If Not (FopcConsulta in [conAdv]) Then
     pAddColunaSql('COL_PRECUS', 'Preço de Custo',4);

  pAddColunaSql('COL_PREVEN', 'Preço de Venda',4);
  pAddColunaSql('COL_MARGEM', 'Margem',4);
  pAddColunaSql('ITE_CODITE');
  FstrSQL := FstrSQL + '  	C.AUTOINCREM "AUTOINCREM"';
  FstrSQL := FstrSQL + '  FROM';
  FstrSQL := FstrSQL + '  	' + FstrTabela + ' AS C ';
  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON I.ITE_CODITE = C.COL_CODITE'
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON I.ITE_CODITE = C.COL_CODITE';

  FarrOrdenacao  :=  ['COL_CODCOL'];
end;

procedure TGerenciaConsultaColorante.pPreparaDefaultSemCOL_PESESP;
begin
  FstrSQL := FstrSQL + '  SELECT SQL_NO_CACHE ';
  pAddColunaSql('COL_CODCOL', 'Código do Colorante');
  pAddColunaSql('COL_DESCRI', 'Descrição do Colorante');


  If (FopcConsulta in [conAdv,conAdt, conAnj, conAja, conBel, conCal, conEuc, conShe, conJot, conHyd, conInt, conSay, conSuv, conMax, conAlp, conBsn,
    conCsn, conGbc, conBlt, conC11, conTex, conChr, conLei, conLik, conCia, conMae, conSin, conDca, conUni, conSpa, conLkd, conGlo, conBau, conLuz, conPrt,
    conAn2, conRs2]) Then
    pAddColunaSql('COL_EMBALA', 'Embalagem',4)
  else if (FopcConsulta in [conAdvCor]) Then
    pAddColunaSql('COL_PESCOL', 'Embalagem',4)
  else if (FopcConsulta in [conDac]) Then
    pAddColunaSql('DAC_EMBALA', 'Embalagem',4);

  If Not (FopcConsulta in [conAnj, conAja, conAdvCor, conLkd, conRsi, conShe, conWeg]) Then
     pAddColunaSql('COL_PRECUS', 'Preço de Custo',4);
  pAddColunaSql('COL_PREVEN', 'Preço de Venda',4);
  pAddColunaSql('COL_MARGEM', 'Margem',4);
  pAddColunaSql('COL_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  If (FopcConsulta in [conRen]) Then
    pAddColunaSql('COL_PRECUS', '',4);

  pAddColunaSql('ITE_CODITE');

  FstrSQL := FstrSQL + '  	C.AUTOINCREM "AUTOINCREM"';
  FstrSQL := FstrSQL + '  FROM';
  FstrSQL := FstrSQL + '  	' + FstrTabela + ' AS C ';
  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON I.ITE_CODITE = C.COL_CODITE'
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON I.ITE_CODITE = C.COL_CODITE';
  FarrOrdenacao  :=  ['COL_CODCOL'];

  {*Campos de Retorno para os edits*}
  FstrCodColorante := 'COL_CODCOL';
  FstrCodigoItem   := 'COL_CODITE';
  { ******************************* }
end;

procedure TGerenciaConsultaColorante.pPreparaDefaultSemCOL_PESESP_e_COL_DESCRI;
begin
  FstrSQL := 'SELECT SQL_NO_CACHE ';
  pAddColunaSql('COL_CODCOL', 'Código do Colorante');
  pAddColunaSql('COL_CODITE', 'Código do Item');
  pAddColunaSql('ITE_DESITE', 'Descrição do Item');
  pAddColunaSql('ITE_REFERE', 'Referência do Item');
  pAddColunaSql('COL_MARGEM', 'Margem',4);
  pAddColunaSql('COL_PREVEN', 'Preço Venda',4);

  If (FopcConsulta in [conAdv,conMon,conAdt, conAnj, conAja, conCal, conEuc, conHyd, conInt, conLec, conSay, conSuv, conShw, conFal, conVel, conRec, conFut, conAle, conRep]) Then
    pAddColunaSql('COL_EMBALA', 'Embalagem',4)
  else if (FopcConsulta in [conAdvCor]) Then
    pAddColunaSql('COL_PESCOL', 'Embalagem',4)
  else if (FopcConsulta in [conDac]) Then
    pAddColunaSql('DAC_EMBALA', 'Embalagem',4);

  If (FopcConsulta in [conMzi]) Then
    pAddColunaSql('COL_PRECUS', '',4);

  pAddColunaSql('ITE_CODITE');

  FstrSQL := FstrSQL + ' C.AUTOINCREM AS "AUTOINCREM"  ';
  FstrSQL := FstrSQL + ' FROM ';
  FstrSQL := FstrSQL + '  	' + FstrTabela + ' AS C ';
  If FblnComProdutos Then
    FstrSQL := FstrSQL + '  	INNER JOIN CADITE I ON I.ITE_CODITE = C.COL_CODITE'
  Else
    FstrSQL := FstrSQL + '  	LEFT JOIN CADITE I ON I.ITE_CODITE = C.COL_CODITE';
  FarrOrdenacao  :=  ['COL_CODCOL'];
end;

{ TGerenciaConsultaMontadora }

constructor TGerenciaConsultaMontadora.Create(opcConsulta: TTipoTintas; CampoRelacionamento: string = '');
begin
  Inherited Create(opcConsulta, CampoRelacionamento);
  FstrTituloTela := 'Consulta de Montadora';
  FstrTabela := FstrSiglaTinta + '_CADMON';
  FStrSQL := 'SELECT SQL_NO_CACHE ';

  Case opcConsulta of
    conSky, conGen, conMZA, conAjt, conMZD, conNex, conPPG, conPPX, conKin, conAlk, conCoa, conMif: pPreparaPadrao;

    conBzc: pPreparaConBra;
    conFar: pPreparaConFar;
    conBla: pPreparaConBla;
  End;

  If Not(opcConsulta In[conFar, conBla]) Then
  Begin
    FstrCodMontadora := 'MON_CODMON';
    FstrDesMontadora := 'MON_DESMON';
  End;
end;

procedure TGerenciaConsultaMontadora.pPreparaConBla;
begin
  pAddColunaSql('MON_CODMON', 'Código');
  pAddColunaSql('MON_DESCRI', 'Descrição');
  FstrSQL := FstrSQL + '   AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela;

  FarrOrdenacao  :=  ['MON_CODMON'];

  FstrCodMontadora := 'MON_CODMON';
  FstrDesMontadora := 'MON_DESCRI';
end;

procedure TGerenciaConsultaMontadora.pPreparaConBra;
begin
  pAddColunaSql('MON_CODMON', 'Código');
  pAddColunaSql('MON_DESCRI', 'Descrição');
  pAddColunaSql('MON_SIGLA_', 'Sigla');
  FstrSQL := FstrSQL + '   AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela;
end;

procedure TGerenciaConsultaMontadora.pPreparaConFar;
begin
  FstrSQL := ' SELECT SQL_NO_CACHE ';
  pAddColunaSql('FAR_CODMON', 'Código');
  pAddColunaSql('FAR_DESMON', 'Montadora');
  FstrSQL := FstrSQL + '  AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS M ';

  FarrOrdenacao  :=  ['FAR_CODMON'];

  FstrCodMontadora := 'FAR_CODMON';
  FstrDesMontadora := 'FAR_DESMON';
end;

procedure TGerenciaConsultaMontadora.pPreparaPadrao;
begin

  Case FopcConsulta Of
    conSky: FstrTabela := 'SKY_CADMON';
    conFar: FstrTabela := 'FAR_CADMON';
    conGen: FstrTabela := 'GEN_CADMON';
    conMza: FstrTabela := 'MZA_CADMON';
    conAjt: FstrTabela := 'AJT_CADMON';
    conMzd: FstrTabela := 'MZD_CADMON';
    conPPG: FstrTabela := 'PPG_CADMON';
    conPPX: FstrTabela := 'PPX_CADMON';
    conKin: FstrTabela := 'KIN_CADMON';
    conAlk: FstrTabela := 'ALK_CADMON';
    conCoa: FstrTabela := 'COA_CADMON';
    conMif: fstrTabela := 'MIF_CADMON';
  End;

  FstrSQL := ' SELECT SQL_NO_CACHE ';

  pAddColunaSql('MON_CODMON', 'Código');

  if FopcConsulta in [conMza, conGen, conAjt,conMzd, conPPG, conPPX, conGen, conNex, conKin, conAlk, conCoa, conMif] Then
    pAddColunaSql('MON_DESCRI', 'Montadora')
  Else
    pAddColunaSql('MON_DESMON', 'Montadora');

  FstrSQL := FstrSQL + '  AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS M ';

  FarrOrdenacao  :=  ['MON_CODMON'];
end;

{ TGerenciaConsultaNovasFormulas }

constructor TGerenciaConsultaNovasFormulas.Create(opcConsulta: TTipoTintas);
begin
  Inherited Create(opcConsulta);
  FstrTabela := FstrSiglaTinta + '_CADNFM';

  FstrSQL := 'SELECT SQL_NO_CACHE ';
  FstrTituloTela := 'Consulta de Novas Fórmulas';
  Case FopcConsulta Of
    ConAdt    : pPreparaConAdt;
    ConAdv    : pPreparaconAdv;
    ConAdvCor : pPraparaConAdvCor;
    conAja    : pPraparaconAja;
    ConAle    : pPreparaConAle;
    ConAnj    : pPreparaComAnj;
    conAnn    : pPraparaconAnn;
    conBau    : pPreparaConBau;
    conQua    : pPreparaConQua;
    conBel    : pPreparaConBel;
    conCia    : pPreparaConCia;
    conJot    : pPreparaConJot;
    conMeg    : pPreparaConMeg;
    conGra    : pPreparaConGra;
    conBza    : pPraparaconBza;
    ConBzi    : pPreparaConBzi;
    conBzc    : pPraparaconBzc;
    conCal    : pPraparaconCal;
    conCorImo : pPreparaconCorImo;
    conCorInd : pPreparaCorInd;
    conDac    : pPraparaconDac;
    conDox    : pPraparaconDox;
    conDup    : pPraparaconDup;
    conDux    : pPraparaconDux;
    conDu2    : pPreparaConDu2;
    conEuc    : pPraparaconEuc;
    conFar    : pPraparaconFar;
    conFut    : pPraparaconFut;
    ConGen    : pPreparaConGen;
    ConGla    : pPraparaConGla;
    ConGlo    : PreparaConGlo;
    conHyd    : pPraparaconHyd;
    conInt    : pPraparaconInt;
    conLec    : pPreparaConLec;
    conIqu    : pPreparaConIqu;
    conKil    : pPraparaconKil;
    conKild   : pPraparaconKild;
    conLaz    : pPraparaconLaz;
    conLik    : PreparaConLik;
    conLkd    : pPraparaconLkd;
    conLks    : pPraparaconLks;
    conLkc    : pPreparaconLkc;
    conMzi    : pPraparaconMzi;
    conSpa    : pPraparaconSpa;
    conFal    : pPraparaconFal;
    conShw    : pPraparaconShw;
    conMon    : pPraparaconMon;
    conMza    : pPreparaConMza;
    conAjt    : pPreparaConAjt;
    conMzd    : pPreparaConMzd;
    conNex    : pPraparaconNex;
    conPPG    : pPraparaconPPG;
    conPPX    : pPraparaconPPX;
    conRec    : pPreparaConRec;
    conRei    : pPraparaconRei;
    conRen    : pPraparaconRen;
    conRsi    : pPraparaconRsi;
    conSay    : pPraparaconSay;
    conSal    : pPraparaconSal;
    conShe    : pPraparaconShe;
    conSky    : pPraparaconSky;
    conSol    : pPraparaconSol;
    conSta    : pPraparaconSta;
    conStaWeb : pPraparaconStaWeb;
    ConSuv    : pPraparaConSuv;
    conUni    : pPraparaconUni;
    conVel    : pPraparaconVel;
    conWandaPro: pPraparaconWanPro;
    conWeg    : pPraparaconWeg;
    conZyn    : pPraparaconZyn;
    conInk    : pPreparaConInk;
    conKre    : pPreparaConKre;
    conKin    : pPreparaConKin;
    conRob    : pPreparaConRob;
    conMax    : pPreparaConMax;
    conAlp    : pPreparaConAlp;
    conBsn    : pPreparaConBsn;
    conCsn    : pPreparaConCsn;
    conGbc    : pPreparaConGbc;
    conClb    : pPreparaConClb;
    conBlt    : pPreparaConBlt;
    conAlk    : pPreparaConAlk;
    conCoa    : pPreparaConCoa;
    conMif    : pPreparaConMif;
    conC11    : pPreparaConC11;
    conTex    : pPreparaConTex;
    conChr    : pPreparaConChr;
    conAds    : pPreparaConAds;
    conLei    : pPreparaConLei;
    conMae    : pPreparaConMae;
    conSin    : pPreparaConSin;
    conDca    : pPreparaConDca;
    conLuz    : pPreparaConLuz;
    conRep    : pPreparaConRep;
    conPrt    : pPreparaConPro;
    conAn2    : pPreparaConAn2;
    conRs2    : pPreparaConRs2;
    conLca    : pPreparaConLca;
    conAlv    : pPreparaConAlv;
    conPfa    : pPreparaConPfa;
    conAla    : pPreparaConAla;
    conBla    : pPreparaConBla;
  End;
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAds;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM ADS_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAdt;
begin
  pAddColunaSql('NFM_IDFORM', 'Formula');
  pAddColunaSql('NFM_CODCOR', 'Código da Cor');
  pAddColunaSql('NFM_CODTEC', 'Código Tecnico');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_CODEMB', 'Código Embalagem');
  pAddColunaSql('NFM_QTDBAS', 'Quantiade Base', 4);
  pAddColunaSql('NFM_QTD_ML', 'Qtd ML.', 4);
  pAddColunaSql('NFM_QTDCAT', 'Quantidade Catalizador', 4);
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODCAT');
  pAddColunaSql('NFM_QTDFIN', '', 4);
  pAddColunaSql('NFM_CODEMP');

  pAddColunaSql('NFM_QTDC01', '', 4);
  pAddColunaSql('NFM_QTDC02', '', 4);
  pAddColunaSql('NFM_QTDC03', '', 4);
  pAddColunaSql('NFM_QTDC04', '', 4);
  pAddColunaSql('NFM_QTDC05', '', 4);
  pAddColunaSql('NFM_QTDC06', '', 4);
  pAddColunaSql('NFM_QTDC07', '', 4);
  pAddColunaSql('NFM_QTDC08', '', 4);
  pAddColunaSql('NFM_QTDC09', '', 4);
  pAddColunaSql('NFM_QTDC10', '', 4);
  pAddColunaSql('NFM_QTDC11', '', 4);
  pAddColunaSql('NFM_QTDC12', '', 4);
  pAddColunaSql('NFM_QTDC13', '', 4);
  pAddColunaSql('NFM_QTDC14', '', 4);
  pAddColunaSql('NFM_QTDC15', '', 4);
  pAddColunaSql('NFM_QTDC16', '', 4);
  pAddColunaSql('NFM_QTDC17', '', 4);
  pAddColunaSql('NFM_QTDC18', '', 4);
  pAddColunaSql('NFM_QTDC19', '', 4);
  pAddColunaSql('NFM_QTDC20', '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ADT_CADNFM AS B ';
  FstrTabela := 'ADT_CADNFM';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaconAdv;
begin

  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CARTA_', 'Carta');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_FORMUL', 'Formula');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_BASE01');
  pAddColunaSql('NFM_BASE02');
  pAddColunaSql('NFM_BASE03');
  pAddColunaSql('NFM_QTDB01', '', 4);
  pAddColunaSql('NFM_QTDB02', '', 4);
  pAddColunaSql('NFM_QTDB03', '', 4);

  pAddColunaSql('NFM_QTDC01', '', 4);
  pAddColunaSql('NFM_QTDC02', '', 4);
  pAddColunaSql('NFM_QTDC03', '', 4);
  pAddColunaSql('NFM_QTDC04', '', 4);
  pAddColunaSql('NFM_QTDC05', '', 4);
  pAddColunaSql('NFM_QTDC06', '', 4);
  pAddColunaSql('NFM_QTDC07', '', 4);
  pAddColunaSql('NFM_QTDC08', '', 4);
  pAddColunaSql('NFM_QTDC09', '', 4);
  pAddColunaSql('NFM_QTDC10', '', 4);
  pAddColunaSql('NFM_QTDC11', '', 4);
  pAddColunaSql('NFM_QTDC12', '', 4);
  pAddColunaSql('NFM_QTDC13', '', 4);
  pAddColunaSql('NFM_QTDC14', '', 4);
  pAddColunaSql('NFM_QTDC15', '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ADV_CADNFM AS B ';

  FstrTabela := 'ADV_CADNFM';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;


procedure TGerenciaConsultaNovasFormulas.pPreparaConJot;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_NOMCOR', 'Nome da Cor');
  pAddColunaSql('NFM_TIPO__', 'Tipo');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');

  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM JOT_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConKin;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_ORIGEM', 'Origem');
  pAddColunaSql('NFM_CODMON', 'Código Montadora');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_ANOCOR', 'Ano Cor');
  pAddColunaSql('MON_DESCRI', 'Montadora');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM KIN_CADNFM F ';
  FstrSql := FstrSql + '   LEFT JOIN KIN_CADMON ON NFM_CODMON = MON_CODMON ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConKre;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Código Base');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ATIVO_');

  For i := 1 To 10 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '');

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConLca;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_A_N_O_', 'Ano Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM LCA_CADNFM F ';
  FarrOrdenacao     :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAlv;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_SISTEM', 'Sistema');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_ATIVAD', 'Fórmula Ativa');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM ALV_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaConAdvCor;
begin
  pAddColunaSql('NFM_CODPRO', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_EMBALA', 'Embalagem', 2);
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_PROKEY', 'Prod. Key');
  pAddColunaSql('NFM_SUBKEY', 'Sub. Key');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_QTD001', '', 2);
  pAddColunaSql('NFM_QTD002', '', 2);
  pAddColunaSql('NFM_QTD003', '', 2);
  pAddColunaSql('NFM_QTD004', '', 2);
  pAddColunaSql('NFM_QTD005', '', 2);
  pAddColunaSql('NFM_QTD006', '', 2);
  pAddColunaSql('NFM_QTD007', '', 2);
  pAddColunaSql('NFM_QTD008', '', 2);
  pAddColunaSql('NFM_QTD009', '', 2);
  pAddColunaSql('NFM_QTD010', '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ADVCOR_CADNFM AS B ';
  FstrTabela := 'ADVCOR_CADNFM';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconAja;
begin
  pAddColunaSql('NFM_CODPRO', 'Código');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_EMBALA', 'Embalagem', 2);
  pAddColunaSql('NFM_PROKEY', 'Prod. Key');
  pAddColunaSql('NFM_SUBKEY', 'Sub. Key');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');

  pAddColunaSql('NFM_QTD001', '', 4);
  pAddColunaSql('NFM_QTD002', '', 4);
  pAddColunaSql('NFM_QTD003', '', 4);
  pAddColunaSql('NFM_QTD004', '', 4);
  pAddColunaSql('NFM_QTD005', '', 4);
  pAddColunaSql('NFM_QTD006', '', 4);
  pAddColunaSql('NFM_QTD007', '', 4);
  pAddColunaSql('NFM_QTD008', '', 4);
  pAddColunaSql('NFM_QTD009', '', 4);
  pAddColunaSql('NFM_QTD010', '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAla;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_TONALI', 'Tonalidade');
  pAddColunaSql('NFM_SYSTEM', 'Sistema');
  pAddColunaSql('NFM_TECNOL', 'Tecnologia');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_ATIVAD', 'Fórmula Ativa');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM ALA_CADNFM F ';
  FarrOrdenacao     :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAle;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_NOMLON', 'Nome Cor Longo');
  pAddColunaSql('NFM_EMBALA', 'Embalagem');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  pAddColunaSql('NFM_QSHO01', '', 2);
  pAddColunaSql('NFM_QSHO02', '', 2);
  pAddColunaSql('NFM_QSHO03', '', 2);
  pAddColunaSql('NFM_QSHO04', '', 2);
  pAddColunaSql('NFM_QSHO05', '', 2);
  pAddColunaSql('NFM_QSHO06', '', 2);
  pAddColunaSql('NFM_QSHO07', '', 2);
  pAddColunaSql('NFM_QSHO08', '', 2);
  pAddColunaSql('NFM_QSHO09', '', 2);
  pAddColunaSql('NFM_QSHO10', '', 2);
  pAddColunaSql('NFM_QSHO11', '', 2);
  pAddColunaSql('NFM_QSHO12', '', 2);
  pAddColunaSql('NFM_QSHO13', '', 2);
  pAddColunaSql('NFM_QSHO14', '', 2);
  pAddColunaSql('NFM_QSHO15', '', 2);
  pAddColunaSql('NFM_QSHO16', '', 2);
  pAddColunaSql('NFM_QSHO17', '', 2);
  pAddColunaSql('NFM_QSHO18', '', 2);
  pAddColunaSql('NFM_QSHO19', '', 2);
  pAddColunaSql('NFM_QSHO20', '', 2);

  pAddColunaSql('NFM_CODEMP');

  FstrSQL := FstrSQL + 'B.AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' +  FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAlk;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_ACABAM', 'Acabamento');
  pAddColunaSql('NFM_CORMON', 'Cor da Montadora');
  pAddColunaSql('MON_DESCRI', 'Descrição da Montadora');
  pAddColunaSql('NFM_VARIAN', 'Variação');
  pAddColunaSql('NFM_ANOINI', 'Ano Inicio');
  pAddColunaSql('NFM_ANOFIN', 'Ano Fim');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM ALK_CADNFM F ';
  FstrSql := FstrSql + '   LEFT JOIN ALK_CADMON ON NFM_CODMON = MON_CODMON ';
  FarrOrdenacao     :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAlp;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código da Base');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');


  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ALP_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAn2;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM AN2_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaComAnj;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODPRO', 'Código');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_EMBALA', 'Embalagem', 2);
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_PROKEY');
  pAddColunaSql('NFM_SUBKEY');
  pAddColunaSql('NFM_CODEMP');

  For i := 1 To 10 do
     pAddColunaSql('NFM_QTD0' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ANJ_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;


procedure TGerenciaConsultaNovasFormulas.pPraparaconAnn;
  Var
   i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_DESPRO', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição Formula');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_GERUNI');
  pAddColunaSql('NFM_ATIVAD');

  For i := 1 To 10 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconBza;
  var i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_CODUNI', 'Código Universal');
  pAddColunaSql('NFM_TIPO__', 'Tipo');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_CODEMP');

  For i := 1 To 10 do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConBau;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM BAU_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';
end;


procedure TGerenciaConsultaNovasFormulas.pPreparaConQua;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM QUA_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConBel;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_COLECA', 'Coleção');

  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM BEL_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';
end;


procedure TGerenciaConsultaNovasFormulas.pPreparaConBla;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_CODUNI', 'Código Universal');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_ANOINI', 'Ano Inicial');
  pAddColunaSql('NFM_ANOFIM', 'Ano Final');
  pAddColunaSql('NFM_CODLIN', 'Codigo Linha');
  pAddColunaSql('NFM_CODMON', 'Codigo Montadora');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_ATIVAD', 'Fórmula Ativa');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM BLA_CADNFM F ';
  FarrOrdenacao     :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConBlt;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCOR', 'Descrição Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM BLT_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConBsn;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCOR', 'Descrição Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM BSN_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConBzi;
  Var
    i: Integer;
Begin
  pAddColunaSql('NFM_CODIGO', 'Código da Formula');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');

  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM BZI_CADNFM AS B ';
  FstrTabela := 'BZI_CADNFM';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
End;

procedure TGerenciaConsultaNovasFormulas.pPreparaConC11;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCOR', 'Descrição Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM C11_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConChr;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_PALETA', 'Paleta');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM CHR_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConCia;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_VOLUME', 'Volume');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM CIA_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';

end;


procedure TGerenciaConsultaNovasFormulas.pPreparaConClb;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_NOMCOR', 'Nome da Cor');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 19 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + '    FROM  ' + FstrTabela + ' AS B ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConCoa;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_ANOCOR', 'Ano');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_CLIENT', 'Cliente');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);
    pAddColunaSql('NFM_QTDD' + Format('%0.2d', [i]), '', 4);
  End;

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM COA_CADNFM F ';
  FarrOrdenacao     :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConLuz;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM LUZ_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConMae;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM MAE_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConMax;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM MAX_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConMeg;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');


  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM MEG_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';

end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConMif;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_ANOCOR', 'Ano');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_CLIENT', 'Cliente');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_PADREF', 'Tipo Fórmula');
  pAddColunaSql('NFM_ORIGEM', 'Origem');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);
    pAddColunaSql('NFM_QTDD' + Format('%0.2d', [i]), '', 4);
  End;

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM MIF_CADNFM F ';
  FarrOrdenacao     :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConGra;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_BASE__', 'Código da Base');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');


  For i := 1 To 20 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM GRA_CADNFM AS B ';
  FarrOrdenacao  :=  ['NFM_DESCRI'];

  FstrCodigoFormula := 'NFM_CODNFM';

end;


procedure TGerenciaConsultaNovasFormulas.pPraparaconBzc;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_TIPO__', 'Tipo');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB', '', 4);
  pAddColunaSql('NFM_CODPRO');
  pAddColunaSql('NFM_CODIGO');
  pAddColunaSql('NFM_CODUNI');
  pAddColunaSql('NFM_CODMON');
  pAddColunaSql('NFM_REVISA');
  pAddColunaSql('NFM_ESPECI');
  pAddColunaSql('NFM_CODPRE');
  pAddColunaSql('NFM_CODSUF');
  pAddColunaSql('NFM_PUBLIC');
  pAddColunaSql('NFM_PUBDTA');
  pAddColunaSql('NFM_AUTORI');
  pAddColunaSql('NFM_REVISD');

  pAddColunaSql('NFM_ACRMOB', '', 4);  pAddColunaSql('NFM_QTDC01', '', 4);  pAddColunaSql('NFM_QTDC02', '', 4);
  pAddColunaSql('NFM_QTDC03', '', 4);  pAddColunaSql('NFM_QTDC04', '', 4);  pAddColunaSql('NFM_QTDC05', '', 4);
  pAddColunaSql('NFM_QTDC06', '', 4);  pAddColunaSql('NFM_QTDC07', '', 4);  pAddColunaSql('NFM_QTDC08', '', 4);
  pAddColunaSql('NFM_QTDC09', '', 4);  pAddColunaSql('NFM_QTDC10', '', 4);  pAddColunaSql('NFM_QTDC11', '', 4);
  pAddColunaSql('NFM_QTDC12', '', 4);  pAddColunaSql('NFM_QTDC13', '', 4);  pAddColunaSql('NFM_QTDC14', '', 4);
  pAddColunaSql('NFM_QTDC15', '', 4);  pAddColunaSql('NFM_QTDC16', '', 4);  pAddColunaSql('NFM_QTDC17', '', 4);
  pAddColunaSql('NFM_QTDC18', '', 4);  pAddColunaSql('NFM_QTDC19', '', 4);  pAddColunaSql('NFM_QTDC20', '', 4);
  pAddColunaSql('NFM_QTDD01', '', 4);  pAddColunaSql('NFM_QTDD02', '', 4);  pAddColunaSql('NFM_QTDD03', '', 4);
  pAddColunaSql('NFM_QTDD04', '', 4);  pAddColunaSql('NFM_QTDD05', '', 4);  pAddColunaSql('NFM_QTDD06', '', 4);
  pAddColunaSql('NFM_QTDD07', '', 4);  pAddColunaSql('NFM_QTDD08', '', 4);  pAddColunaSql('NFM_QTDD09', '', 4);
  pAddColunaSql('NFM_QTDD10', '', 4);  pAddColunaSql('NFM_QTDD11', '', 4);  pAddColunaSql('NFM_QTDD12', '', 4);
  pAddColunaSql('NFM_QTDD13', '', 4);  pAddColunaSql('NFM_QTDD14', '', 4);  pAddColunaSql('NFM_QTDD15', '', 4);
  pAddColunaSql('NFM_QTDD16', '', 4);  pAddColunaSql('NFM_QTDD17', '', 4);  pAddColunaSql('NFM_QTDD18', '', 4);
  pAddColunaSql('NFM_QTDD19', '', 4);  pAddColunaSql('NFM_QTDD20', '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconCal;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_KEY1__', 'Key 1');
  pAddColunaSql('NFM_KEY2__', 'Key 2');
  pAddColunaSql('NFM_KEY3__', 'Key 3');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
     pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaconCorImo;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
//  pAddColunaSql('NFM_CODITE', 'Código Item');
//  pAddColunaSql('ITE_DESITE', 'Descrição Item');
//  pAddColunaSql('ITE_REFERE', 'Referência');
  pAddColunaSql('NFM_DESCRI', 'Descrição Formula');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_DESPRO');
  pAddColunaSql('NFM_GERUNI');
  pAddColunaSql('NFM_ATIVAD');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + ' F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM CORIMO_CADNFM F';
//  FstrSQL := FstrSQL + ' LEFT JOIN CADITE ON ITE_CODITE = F.NFM_CODITE';

  FstrTabela := 'CORIMO_CADNFM';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;


procedure TGerenciaConsultaNovasFormulas.pPraparaconDac;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODPRO', 'Código Produto');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_TIPMED');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_TIPMED');

  For i:= 1 To 15 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconDox;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CATEGO', 'Categoria');
  pAddColunaSql('NFM_QUALID', 'Qualidade');
  pAddColunaSql('NFM_ANOFIN', 'Ano Início');
  pAddColunaSql('NFM_ANOINI', 'Ano Fim');
  pAddColunaSql('NFM_PAIS__', 'País');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);

  pAddColunaSql('NFM_VARIAN');
  pAddColunaSql('NFM_VERSAO');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_ATIVO_');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_DTACAD');
  pAddColunaSql('NFM_MONTAD');

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';

end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconDup;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_QUALID', 'Qualidade');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_CATALI', 'Catalizador');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_ALTERN');
  pAddColunaSql('NFM_CODDIL');
  pAddColunaSql('NFM_QTDDIL', '', 3);
  pAddColunaSql('NFM_CODCAT');
  pAddColunaSql('NFM_QTDCAT', '', 3);
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ATIVO_');
  pAddColunaSql('NFM_ACRMOB', '', 3);

  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);
    pAddColunaSql('NFM_QTDD' + Format('%0.2d', [i]), '', 3);
  End;

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconDux;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_QUALID', 'Qualidade');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
//  pAddColunaSql('NFM_CATALI', 'Catalizador');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_ALTERN');
  pAddColunaSql('NFM_CODDIL');
  pAddColunaSql('NFM_QTDDIL', '', 3);
  pAddColunaSql('NFM_CODCAT');
  pAddColunaSql('NFM_QTDCAT', '', 3);
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ATIVO_');
  pAddColunaSql('NFM_ACRMOB', '', 3);

  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);
  End;

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;


procedure TGerenciaConsultaNovasFormulas.pPraparaconEuc;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCOR', 'Descrição');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_DESBAS', 'Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODSEQ');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 6 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconFar;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_O_E_M_', 'Oem');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_SETOR_', 'Setor');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_DILUID');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);
    pAddColunaSql('NFM_QTDD' + Format('%0.2d', [i]), '', 3);
  End;

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconFut;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODPRO', 'Código Produto');
  pAddColunaSql('NFM_PRODUT', 'Descrição Produto');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_DESBAS', 'Descrição Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_SPRODU');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaConGla;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB', '', 4);

  For i:= 1 To 18 Do
  begin
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);
    pAddColunaSql('NFM_QTDD' + Format('%0.2d', [i]), '', 3);
  End;

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconHyd;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_C_O_R_', 'Cor');
  pAddColunaSql('NFM_CORLON', 'Nome Longo Cor');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconInt;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCOR', 'Cor');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_CODEMB', 'Emabalagem');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_CODINT', 'Código International');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 19 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConLec;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODCOR', 'Cor');
  pAddColunaSql('NFM_DESCOR', 'Descrição da Cor');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 19 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConLei;
Var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM LEI_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaconLkc;
Var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_NOMCOR', 'Nome da Cor');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 19 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + '    FROM  ' + FstrTabela + ' AS B ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconKil;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODPRO', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconKild;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODCOR', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_NOMCOR', 'Nome da Cor');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_CODFML', 'Código Base');
  pAddColunaSql('NFM_CODUNI', 'Unidade');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODCOR'];
  FstrCodigoFormula := 'NFM_CODCOR';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconLaz;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_UNIVER', 'Código Universal');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_REFERE');
  pAddColunaSql('NFM_VOLCON');
  pAddColunaSql('NFM_VOLDIL');
  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);
    pAddColunaSql('NFM_QTDD' + Format('%0.2d', [i]), '', 3);
  End;

  pAddColunaSql('NFM_CODEMP');
  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconLkd;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODPRO', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_EMBALA', 'Embalagem');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_PROKEY', 'Prod. Key');
  pAddColunaSql('NFM_SUBKEY', 'Sub. Key');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTD0' + Format('%0.2d', [i]), '', 2);

  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('AUTOINCREM');

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconLks;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODPRO', 'Produto');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConMza;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_VARIAC', 'Variação');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_OBSERV', 'Observação');
  pAddColunaSql('NFM_CODMON', 'Código Montadora');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('MON_DESCRI', 'Montadora');
  pAddColunaSql('NFM_UNIVER', 'Universal');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_PESFOR','',4);
  pAddColunaSql('NFM_PESCOR','',4);
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM MZA_CADNFM F ';
  FstrSql := FstrSql + '   LEFT JOIN MZA_CADMON ON NFM_CODMON = MON_CODMON ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConAjt;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_ACABAM', 'Acabamento');
  pAddColunaSql('NFM_CORMON', 'Cor da Montadora');
  pAddColunaSql('NFM_VARIAC', 'Variação');
  pAddColunaSql('NFM_CODMON', 'Cód.Montadora');
  pAddColunaSql('MON_DESCRI', 'Descrição da Montadora');
  pAddColunaSql('NFM_ANOINI', 'Ano Inicio');
  pAddColunaSql('NFM_ANOFIM', 'Ano Fim');
  pAddColunaSql('NFM_OBSERV', 'Observação');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM AJT_CADNFM F ';
  FstrSql := FstrSql + '   LEFT JOIN AJT_CADMON ON NFM_CODMON = MON_CODMON ';
  FarrOrdenacao     :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;


procedure TGerenciaConsultaNovasFormulas.pPreparaConMzd;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_VARIAC', 'Variação');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_OBSERV', 'Observação');
  pAddColunaSql('NFM_CODMON', 'Código Montadora');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('MON_DESCRI', 'Montadora');
  pAddColunaSql('NFM_UNIVER', 'Universal');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_PESFOR','',4);
  pAddColunaSql('NFM_PESCOR','',4);
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM MZD_CADNFM F ';
  FstrSql := FstrSql + '   LEFT JOIN MZD_CADMON ON NFM_CODMON = MON_CODMON ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConPfa;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_A_N_O_', 'Ano Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_ATIVAD', 'Fórmula Ativa');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  F.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + '  FROM PFA_CADNFM F ';
  FarrOrdenacao     :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConPro;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM PRT_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconMon;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DESCOR', 'Cor');
  pAddColunaSql('NFM_ACABAM', 'Acabamento');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Cód.Base');
  pAddColunaSql('BAS_DESCRI', 'Descrição da Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 2);

  FstrSQL := fstrSQL + ' B.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := fstrSQL + '  FROM MON_CADNFM B ';
  FstrSQL := fstrSQL + ' INNER JOIN MON_CADBAS ON BAS_CODBAS = NFM_CODBAS ';
  FstrSQL := fstrSQL + '                      AND BAS_UNIDAD = NFM_UNIDAD ';
  FstrSQL := fstrSQL + '                      AND BAS_PRODUT = NFM_PRODUT ';
  FstrSQL := fstrSQL + '                      AND BAS_ACABAM = NFM_ACABAM';


  FstrTabela        := 'MON_CADNFM';
  FarrOrdenacao     := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;


procedure TGerenciaConsultaNovasFormulas.pPraparaconMzi;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_CODUNI', 'Código Unidade');
  pAddColunaSql('NFM_COLNAM', 'Nome do Colorante');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_COLNUM');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconNex;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCOR', 'Descrição');
  pAddColunaSql('NFM_VARIAN', 'Variação');
  pAddColunaSql('NFM_VEICUL', 'Veiculo');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_TIPO__', 'Tipo');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconPPG;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCOR', 'Descrição');
  pAddColunaSql('NFM_VARIAN', 'Variação');
  pAddColunaSql('NFM_VEICUL', 'Veículo');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_TIPO__', 'Tipo');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB', '', 4);
  pAddColunaSql('NFM_ATIVO_');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconPPX;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCOR', 'Descrição');
  pAddColunaSql('NFM_VARIAN', 'Variação');
  pAddColunaSql('NFM_VEICUL', 'Veículo');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_TIPO__', 'Tipo');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB', '', 4);
  pAddColunaSql('NFM_ATIVO_');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConRec;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_DESPRO', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB');
  pAddColunaSql('NFM_GERUNI');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('AUTOINCREM');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  B.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM         ';
  FstrSQL := FstrSQL + FstrTabela + '  AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaconRep;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_PADRAO', 'Padrão Cor');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 19 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConRob;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Fórmula');
  pAddColunaSql('NFM_ANOINI', 'Ano Inicial');
  pAddColunaSql('NFM_ANOFIN', 'Ano Final');
  pAddColunaSql('NFM_MARCA_', 'Marca');
  pAddColunaSql('NFM_SERIE_', 'Serie');
  pAddColunaSql('NFM_NOMCOR', 'Nome da Cor');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB', '', 4);


  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConRs2;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM RS2_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConSin;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM SIN_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConTex;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_CODCOR', 'Código Cor');
  pAddColunaSql('NFM_INTENS', 'Intensidade');
  pAddColunaSql('NFM_CATALO', 'Catálogo');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM TEX_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconRei;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODPRO', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODBAS', 'Cód. Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCOR', 'Descrição Cor');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconRen;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_DESPRO', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_GERUNI');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_IDENTI');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconRsi;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODPRO', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_EMBALA', 'Embalagem');
  pAddColunaSql('NFM_PROKEY', 'Prod. Key');
  pAddColunaSql('NFM_SUBKEY', 'Sub. Key');
  pAddColunaSql('NFM_CODEMP');
  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTD0' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconSal;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_DTACAD');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_ATIVO_');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);
    pAddColunaSql('NFM_QTDD' + Format('%0.2d', [i]), '', 3);
  End;

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconSay;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_DESEMB', 'Descrição Embalagem');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconShe;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODPRO', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_EMBALA', 'Embalagem');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_PROKEY', 'Prod. Key');
  pAddColunaSql('NFM_SUBKEY', 'Sub. Key');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTD0' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconSky;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODPRO', 'Código Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_ANOFAB', 'Ano de Fabricação');
  pAddColunaSql('NFM_CODUNI', 'Código Universal');
  pAddColunaSql('NFM_VARIAN', 'Variante');
  pAddColunaSql('NFM_CORPAI', 'Cor Pai');
  pAddColunaSql('NFM_NACIMP', 'Nacional/Importando');
  pAddColunaSql('NFM_CODMON', 'Código Montadora');
  pAddColunaSql('NFM_CODGRU', 'Código Grupo');
  pAddColunaSql('NFM_CODSGR', 'Código Sub Grupo');
  pAddColunaSql('NFM_CONDIL', 'Concentrado / Diluído');
  pAddColunaSql('NFM_VERSAO', 'Versao');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_ANUANC');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_OBS001');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconSol;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODCOR', 'Código');
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_DESBAS', 'Descrição Base');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_MARCA_', 'Marca');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 6 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconSpa;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_CODUNI', 'Código Unidade');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_REFERE', 'Referência');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconFal;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Código Base');
  pAddColunaSql('NFM_LINHA_', 'Linha');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';

end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconShw;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Código Base');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';

end;


procedure TGerenciaConsultaNovasFormulas.pPraparaconSta;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_CODLIN', 'Linha');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB', '', 4);

  For i:= 1 To 15 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconStaWeb;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Fórmula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_ANOFOR', 'Ano');
  pAddColunaSql('NFM_DESLIN', 'Linha');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_UNIVER', 'Cód. Universal');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ACRMOB', '', 4);

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaConSuv;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_CODPRO', 'Código da Base');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_EMBDIF');
  pAddColunaSql('NFM_ATIVAD');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
 end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconUni;
  var
    i: integer;
Begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCOR', 'Descrição');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Base');

  pAddColunaSql('NFM_CODTIN');
  pAddColunaSql('NFM_CODUNI');
  pAddColunaSql('NFM_GRUPO_');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
End;

procedure TGerenciaConsultaNovasFormulas.pPraparaconVel;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código');
  pAddColunaSql('NFM_CORCOD', 'Color Code');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_CODNOM', 'Código Nome');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODUNI', 'Unidade');
  pAddColunaSql('NFM_NOTA__', 'Nota');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconWanPro;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_ACRMOB');
  pAddColunaSql('NFM_ALTERN');
  pAddColunaSql('NFM_CODDIL');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_NOMLIN');
  pAddColunaSql('NFM_QTDDI4');
  pAddColunaSql('NFM_QTDDIL');
  pAddColunaSql('WAN_CAMADA');

  pAddColunaSql('NFM_QTDC01', '', 3);
  pAddColunaSQL('NFM_QTDD01', '', 3);
  pAddColunaSQL('NFM_QD4101', '', 3);
  pAddColunaSQL('NFM_QTDC02', '', 3);
  pAddColunaSQL('NFM_QTDD02', '', 3);
  pAddColunaSQL('NFM_QD4102', '', 3);
  pAddColunaSQL('NFM_QTDC03', '', 3);
  pAddColunaSQL('NFM_QTDD03', '', 3);
  pAddColunaSQL('NFM_QD4103', '', 3);
  pAddColunaSQL('NFM_QTDC04', '', 3);
  pAddColunaSQL('NFM_QTDD04', '', 3);
  pAddColunaSQL('NFM_QD4104', '', 3);
  pAddColunaSQL('NFM_QTDC05', '', 3);
  pAddColunaSQL('NFM_QTDD05', '', 3);
  pAddColunaSQL('NFM_QD4105', '', 3);
  pAddColunaSQL('NFM_QTDC06', '', 3);
  pAddColunaSQL('NFM_QTDD06', '', 3);
  pAddColunaSQL('NFM_QD4106', '', 3);
  pAddColunaSQL('NFM_QTDC07', '', 3);
  pAddColunaSQL('NFM_QTDD07', '', 3);
  pAddColunaSQL('NFM_QD4107', '', 3);
  pAddColunaSQL('NFM_QTDC08', '', 3);
  pAddColunaSQL('NFM_QTDD08', '', 3);
  pAddColunaSQL('NFM_QD4108', '', 3);
  pAddColunaSQL('NFM_QTDC09', '', 3);
  pAddColunaSQL('NFM_QTDD09', '', 3);
  pAddColunaSQL('NFM_QD4109', '', 3);
  pAddColunaSQL('NFM_QTDC10', '', 3);
  pAddColunaSQL('NFM_QTDD10', '', 3);
  pAddColunaSQL('NFM_QD4110', '', 3);
  pAddColunaSQL('NFM_QTDDIL', '', 3);
  pAddColunaSQL('NFM_QTDDI4', '', 3);
  pAddColunaSQL('NFM_QTDC11', '', 3);
  pAddColunaSQL('NFM_QTDD11', '', 3);
  pAddColunaSQL('NFM_QD4111', '', 3);
  pAddColunaSQL('NFM_QTDC12', '', 3);
  pAddColunaSQL('NFM_QTDD12', '', 3);
  pAddColunaSQL('NFM_QD4112', '', 3);
  pAddColunaSQL('NFM_QTDC13', '', 3);
  pAddColunaSQL('NFM_QTDD13', '', 3);
  pAddColunaSQL('NFM_QD4113', '', 3);
  pAddColunaSQL('NFM_QTDC14', '', 3);
  pAddColunaSQL('NFM_QTDD14', '', 3);
  pAddColunaSQL('NFM_QD4114', '', 3);
  pAddColunaSQL('NFM_QTDC15', '', 3);
  pAddColunaSQL('NFM_QTDD15', '', 3);
  pAddColunaSQL('NFM_QD4115', '', 3);
  pAddColunaSQL('NFM_QTDC16', '', 3);
  pAddColunaSQL('NFM_QTDD16', '', 3);
  pAddColunaSQL('NFM_QD4116', '', 3);
  pAddColunaSQL('NFM_QTDC17', '', 3);
  pAddColunaSQL('NFM_QTDD17', '', 3);
  pAddColunaSQL('NFM_QD4117', '', 3);
  pAddColunaSQL('NFM_QTDC18', '', 3);
  pAddColunaSQL('NFM_QTDD18', '', 3);
  pAddColunaSQL('NFM_QD4118', '', 3);
  pAddColunaSQL('NFM_QTDC19', '', 3);
  pAddColunaSQL('NFM_QTDD19', '', 3);
  pAddColunaSQL('NFM_QD4119', '', 3);
  pAddColunaSQL('NFM_QTDC20', '', 3);
  pAddColunaSQL('NFM_QTDD20', '', 3);
  pAddColunaSQL('NFM_QD4120', '', 3);

  pAddColunaSQL('NFM_ACRMOB', '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconWeg;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODPRO', 'Código');
  pAddColunaSql('NFM_BASE__', 'Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_NOMCOR', 'Nome da Cor');
  pAddColunaSql('NFM_EMBALA', 'Embalagem');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_PROKEY', 'Prod. Key');
  pAddColunaSql('NFM_SUBKEY', 'Sub. Key');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTD0' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;

procedure TGerenciaConsultaNovasFormulas.pPraparaconZyn;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_VEICUL', 'Veículo');
  pAddColunaSql('NFM_A_N_O_', 'Ano');
  pAddColunaSql('NFM_TIPO__', 'Tipo');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDB' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODPRO'];
  FstrCodigoFormula := 'NFM_CODPRO';
end;


procedure TGerenciaConsultaNovasFormulas.pPreparaConCsn;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCOR', 'Descrição Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM CSN_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConDca;
Var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_NOMCOR', 'Nome Cor');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM DCA_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConDu2;
Var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_LINHA_', 'Linha/Grupo');
  pAddColunaSql('NFM_QUALID', 'Qualidade');
  pAddColunaSql('NFM_MONTAD', 'Montadora');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');
  pAddColunaSql('NFM_ALTERN');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ATIVO_');
  pAddColunaSql('NFM_ACRMOB', '', 3);

  For i:= 1 To 20 Do
  Begin
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);
  End;

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConGbc;
var
  i: integer;
begin
  pAddColunaSql('NFM_CODNFM', 'Código Formula');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_CODBAS', 'Código Base');
  pAddColunaSql('NFM_COLECA', 'Coleção');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_DESCOR', 'Descrição Cor');
  pAddColunaSql('NFM_DTACAD', 'Data Cadastro');

  For i := 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + '  FROM GBC_CADNFM AS B  ';
  FarrOrdenacao := ['NFM_CODNFM'];
  FstrCodigoFormula := 'NFM_CODNFM';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConGen;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_VARIAC', 'Variação');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_CODMON', 'Código Montadora');
  pAddColunaSql('MON_DESCRI', 'Montadora');
  pAddColunaSql('NFM_OBSERV', 'Observação');
  pAddColunaSql('NFM_ANOINI', 'Ano Inicial');
  pAddColunaSql('NFM_ANOFIM', 'Ano Final');
  pAddColunaSql('NFM_DTACAD', 'Data de Cadastro');

  For i:= 1 To 20 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 2);

  FstrSQL := fstrSQL + ' B.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := fstrSQL + ' FROM GEN_CADNFM B ';
  FstrSQL := fstrSQL + ' LEFT JOIN GEN_CADMON ON NFM_CODMON = MON_CODMON ';

  FstrTabela := 'GEN_CADNFM';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;



procedure TGerenciaConsultaNovasFormulas.pPreparaCorInd;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código da Formula');
  pAddColunaSql('NFM_CODBAS', 'Código da Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_CODITE', 'Item');
  pAddColunaSql('ITE_DESITE', 'Descrição Item');
  pAddColunaSql('NFM_CODGRU', 'Linha/Grupo');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + '  B.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM         ';
  FstrSQL := FstrSQL + ' CORIND_CADNFM  AS B ';
  FstrSQL := FstrSQL + ' LEFT JOIN CADITE ON ITE_CODITE = NFM_CODITE ';

  FstrTabela := 'BZI_CADNFM';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
End;

procedure TGerenciaConsultaNovasFormulas.PreparaConGlo;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_DESPRO', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_GERUNI');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_CODEMP');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 4);

  FstrSQL := FstrSQL + '  B.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM         ';
  FstrSQL := FstrSQL + FstrTabela + '  AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConInk;
Var
  i: Integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código Formula');
  pAddColunaSql('NFM_BASE__', 'Código Base');
  pAddColunaSql('NFM_PRODUT', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição Formula');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('NFM_ATIVO_');

  For i := 1 To 10 do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + ' AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.pPreparaConIqu;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_DESPRO', 'Produto');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_GERUNI');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('AUTOINCREM');
  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 3);

  FstrSQL := FstrSQL + '  B.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM         ';
  FstrSQL := FstrSQL + FstrTabela + '  AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';
end;

procedure TGerenciaConsultaNovasFormulas.PreparaConLik;
  var
    i: integer;
begin
  pAddColunaSql('NFM_CODIGO', 'Código');
  pAddColunaSql('NFM_CODBAS', 'Base');
  pAddColunaSql('NFM_DESPRO', 'Produto');
  pAddColunaSql('NFM_DESCRI', 'Descrição');
  pAddColunaSql('NFM_UNIDAD', 'Unidade');
  pAddColunaSql('NFM_CODEMB', 'Embalagem');
  pAddColunaSql('NFM_GERUNI');
  pAddColunaSql('NFM_ATIVAD');
  pAddColunaSql('NFM_CODEMP');
  pAddColunaSql('AUTOINCREM');

  For i:= 1 To 10 Do
    pAddColunaSql('NFM_QTDC' + Format('%0.2d', [i]), '', 2);

  FstrSQL := FstrSQL + '  B.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + ' FROM         ';
  FstrSQL := FstrSQL + FstrTabela + '  AS B ';
  FarrOrdenacao  :=  ['NFM_CODIGO'];
  FstrCodigoFormula := 'NFM_CODIGO';

end;

{ TLocalizaPesquisa }

class function TLocalizaPesquisa.fLocalizaOpcConsulta(strNomeTabela: string): TLocalizaPesquisa;
var obj : TLocalizaPesquisa;
begin
   obj := TLocalizaPesquisa.Create(strNomeTabela);
   Result := obj;
end;

constructor TLocalizaPesquisa.create(strNometabela: string);
begin
  FstrTabela := strNomeTabela;
  pProcessar
end;

procedure TLocalizaPesquisa.pProcessar;
  var
    intPosUnderLine: Integer;
begin
  intPosUnderLine := Pos('_', FstrTabela);
  FstrSigla := Copy(FstrTabela, 1, intPosUnderLine -1);
  FstrTabela := Copy(FstrTabela, intPosUnderLine + 1, Length(FstrTabela));
  pLocalizar_opcConsulta;
  pLocalizar_tipoPesquisa;
end;

procedure TLocalizaPesquisa.pLocalizar_opcConsulta;
begin
  If fStrSigla = 'ADT' Then FopcConsulta := conAdt
  Else If fStrSigla = 'ADV' Then FopcConsulta := conAdv
  Else If fStrSigla = 'ADVCOR' Then FopcConsulta := conAdvCor
  Else If fStrSigla = 'AJA' Then FopcConsulta :=  conAja
  Else If fStrSigla = 'ANJ' Then FopcConsulta :=  conAnj
  Else If fStrSigla = 'ANN' Then FopcConsulta :=  conAnn
  Else If fStrSigla = 'ALE' Then FopcConsulta :=  conAle
  Else If fStrSigla = 'AUT' Then FopcConsulta :=  conAut
  Else If fStrSigla = 'BAU' Then FopcConsulta :=  conBau
  Else If fStrSigla = 'QUA' Then FopcConsulta :=  conQua
  Else If fStrSigla = 'BEL' Then FopcConsulta :=  conBel
  Else If fStrSigla = 'CIA' Then FopcConsulta :=  conCia
  Else If fStrSigla = 'MEG' Then FopcConsulta :=  conMeg
  Else If fStrSigla = 'GRA' Then FopcConsulta :=  conGra
  Else If fStrSigla = 'BZA' Then FopcConsulta :=  conBza
  Else If fStrSigla = 'JOT' Then FopcConsulta :=  conJot
  Else If fStrSigla = 'BZI' Then FopcConsulta :=  conBzi
  Else If fStrSigla = 'BZC' Then FopcConsulta :=  conBzc
  Else If fStrSigla = 'CAL' Then FopcConsulta :=  conCal
  Else If fStrSigla = 'CORIMO' Then FopcConsulta :=  conCorImo
  Else If fStrSigla = 'CORIND' Then FopcConsulta :=  conCorInd
  Else If fStrSigla = 'DAC' Then FopcConsulta := conDac
  Else If fStrSigla = 'DOX' Then FopcConsulta := conDox
  Else If fStrSigla = 'DUP' Then FopcConsulta := conDup
  Else If fStrSigla = 'DUX' Then FopcConsulta := conDux
  Else if fStrSigla = 'DU2' Then FopcConsulta := conDu2
  Else If fStrSigla = 'EUC' Then FopcConsulta := conEuc
  Else If fStrSigla = 'FAR' Then FopcConsulta := conFar
  Else If fStrSigla = 'FUT' Then FopcConsulta := conFut
  Else If fStrSigla = 'GEN' Then FopcConsulta := conGen
  Else If fStrSigla = 'GLA' Then FopcConsulta := conGla
  Else If fStrSigla = 'GLO' Then FopcConsulta := conGlo
  Else If fStrSigla = 'HYD' Then FopcConsulta := conHyd
  Else If fStrSigla = 'INT' Then FopcConsulta := conInt
  Else If fStrSigla = 'LEC' Then fopcConsulta := conLec
  Else If fStrSigla = 'IQU' Then FopcConsulta := conIqu
  Else If fStrSigla = 'KIL' Then FopcConsulta := conKil
  Else If fStrSigla = 'KILD' Then FopcConsulta := conKild
  Else If fStrSigla = 'LAZ' Then FopcConsulta := conLaz
  Else If fStrSigla = 'LIK' Then FopcConsulta := conLik
  Else If fStrSigla = 'LKS' Then FopcConsulta := conLks
  Else If fStrSigla = 'LKD' Then FopcConsulta := conLkd
  Else If fStrSigla = 'LKC' Then FopcConsulta := conLkc
  Else If fStrSigla = 'MAZ' Then FopcConsulta := conMaz
  Else If fStrSigla = 'MZA' Then FopcConsulta := conMza
  Else If fStrSigla = 'MZD' Then FopcConsulta := conMzd
  Else If fStrSigla = 'MZI' Then FopcConsulta := conMzi
  Else If fStrSigla = 'AJT' Then FopcConsulta := conAjt
  Else If fStrSigla = 'SPA' Then FopcConsulta := conSpa
  Else If fStrSigla = 'FAL' Then FopcConsulta := conFal
  Else If fStrSigla = 'SHW' Then FopcConsulta := conShw
  Else If fStrSigla = 'MON' Then FopcConsulta := conMon
  Else If fStrSigla = 'NEX' Then FopcConsulta := conNex
  Else If fStrSigla = 'PPG' Then FopcConsulta := conPPG
  Else If fStrSigla = 'PPX' Then FopcConsulta := conPPX
  Else If fStrSigla = 'REC' Then FopcConsulta := conRec
  Else If fStrSigla = 'REI' Then FopcConsulta := conRei
  Else If fStrSigla = 'REN' Then FopcConsulta := conRen
  Else If fStrSigla = 'RSI' Then FopcConsulta := conRsi
  Else If fStrSigla = 'SAY' Then FopcConsulta := conSay
  Else If fStrSigla = 'SAL' Then FopcConsulta := conSal
  Else If fStrSigla = 'SHE' Then FopcConsulta := conShe
  Else If fStrSigla = 'SKY' Then FopcConsulta := conSky
  Else If fStrSigla = 'SOL' Then FopcConsulta := conSol
  Else If fStrSigla = 'STA' Then FopcConsulta := conSta
  Else If fStrSigla = 'STW' Then FopcConsulta := conStaWeb
  Else If fStrSigla = 'SUV' Then FopcConsulta := ConSuv
  Else If fStrSigla = 'UNI' Then FopcConsulta := conUni
  Else If fStrSigla = 'VEL' Then FopcConsulta := conVel
  Else If fStrSigla = 'WEG' Then FopcConsulta := conWeg
  Else if fStrSigla = 'WAN' Then FopcConsulta := conWanda
  Else if fStrSigla = 'WANPRO' Then FopcConsulta := conWandaPro
  Else if fStrSigla = 'ZYN' Then FopcConsulta := conZyn
  Else If fStrSigla = 'INK' Then FopcConsulta := conInk
  Else If fStrSigla = 'KRE' Then FopcConsulta := conKre
  Else If fStrSigla = 'KIN' Then FOpcConsulta := conKin
  Else If fStrSigla = 'ROB' Then FOpcConsulta := conRob
  Else If fStrSigla = 'MAX' Then FOpcConsulta := conMax
  Else If fStrSigla = 'ALP' Then FOpcConsulta := conAlp
  Else If fStrSigla = 'BSN' Then FOpcConsulta := conBsn
  Else If fStrSigla = 'CSN' Then FOpcConsulta := conCsn
  Else If fStrSigla = 'GBC' Then FOpcConsulta := conGbc
  Else If fStrSigla = 'CLB' Then FOpcConsulta := conClb
  Else If fStrSigla = 'BLT' Then FOpcConsulta := conBlt
  Else If fStrSigla = 'ALK' Then FOpcConsulta := conAlk
  Else If fStrSigla = 'COA' Then FOpcConsulta := conCoa
  Else If fStrSigla = 'MIF' Then FOpcConsulta := conMif
  Else If fStrSigla = 'C11' Then FOpcConsulta := conC11
  Else If fStrSigla = 'TEX' Then FOpcConsulta := conTex
  Else If fStrSigla = 'CHR' Then FOpcConsulta := conChr
  Else If fStrSigla = 'ADS' Then FOpcConsulta := conAds
  Else If fStrSigla = 'LEI' Then FOpcConsulta := conLei
  Else If fStrSigla = 'MAE' Then FOpcConsulta := conMae
  Else If fStrSigla = 'SIN' Then FOpcConsulta := conSin
  Else If fStrSigla = 'DCA' Then FOpcConsulta := conDca
  Else If fStrSigla = 'LUZ' Then FOpcConsulta := conLuz
  Else If fStrSigla = 'REP' Then FOpcConsulta := conRep
  Else if fStrSigla = 'PRT' Then FOpcConsulta := conPrt
  Else if fStrSigla = 'AN2' Then FOpcConsulta := conAn2
  Else If fStrSigla = 'RS2' Then FOpcConsulta := conRs2
  Else If fStrSigla = 'LCA' Then FOpcConsulta := conLca
  Else If fStrSigla = 'ALV' Then FOpcConsulta := conAlv
  Else If fStrSigla = 'PFA' Then FOpcConsulta := conPfa
  Else If fStrSigla = 'ALA' Then FOpcConsulta := conAla
  Else If fStrSigla = 'BLA' Then FOpcConsulta := conBla;
end;

procedure TLocalizaPesquisa.pLocalizar_tipoPesquisa;
begin
  If FstrTabela = 'CADBAS' Then FTipoPesquisas := tpBase
  Else If FstrTabela = 'CADCOL' Then FTipoPesquisas := tpColorante
  Else If FstrTabela = 'CADNFM' Then FTipoPesquisas := tpFormula
  Else If Pos(FstrTabela, 'CADEMB_UNIDAC_') > 0 Then FTipoPesquisas := tpEmbalagem
  Else If FstrTabela = 'CADMON' Then FTipoPesquisas := tpMontadora
  Else if FstrTabela = 'CAD' + FstrSigla Then FTipoPesquisas := tpCadastro
  Else if FstrTabela = 'CADACB' + FstrSigla Then FTipoPesquisas := tpAcabamentos
  Else If FstrTabela = 'CADLIN' Then FTipoPesquisas := tpLinha;
end;

{ TDefBaseTintaAgupada }

constructor TDefTintaRelacionamento.Create;
begin
  cxsSemRelacionado := TcxStyle.Create(nil);
  cxsSemRelacionado.TextColor := clRed;
end;

destructor TDefTintaRelacionamento.destroy;
begin
  FreeAndNil(cxsSemRelacionado)
end;

function TDefTintaRelacionamento.fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;


  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;
    If ADataSet.FindField(strCampo) <> nil Then
      Result := AView.GetColumnByFieldName(strCampo).Index;
  end;
  function fGetValor(ColumnIndex: Integer): Variant;
  begin
    Result := null;
    ARowInfo := AView.DataController.GetRowInfo(ARecord.Index);
    With AView, DataController Do
      If ColumnIndex > -1 Then
      Begin
        Result := Values[ARowInfo.RecordIndex, ColumnIndex];
      End;
  end;
begin
  Result := nil;
  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If (fGetValor(fIdxColumn(FCampoRelacionamento)) =  Null) or (fGetValor(fIdxColumn(FCampoRelacionamento)) =  '')Then
       Result := cxsSemRelacionado
  End;
end;

{ TGerenciaConsultaCadastro }

constructor TGerenciaConsultaCadastro.Create(opcConsulta: TTipoTintas; CampoRelacionamento: string);
begin
  Inherited Create(opcConsulta, campoRelacionamento);
  If Length(FstrSiglaTinta) = 3 Then
     FstrTabela :=  FstrSiglaTinta + cTabelaBase + FstrSiglaTinta
  Else If Length(FstrSiglaTinta) = 6 Then
     FstrTabela :=  FstrSiglaTinta + cTabelaBase + Copy(FstrSiglaTinta, 1, 3);

  FstrSQL := 'SELECT SQL_NO_CACHE ';
  FstrTituloTela := 'Consulta de Cadastros de Tintas';

  case FopcConsulta Of
    conBzi   : pPreparaConBzi;
    conCorImo: pPreparaConCorImo;
    conCorInd: pPreparaConCorInd;
    conLks   : pPreparaConLks;
    conPPG   : pPreparaConPPG;
    conPPX   : pPreparaConPPX;
    conSTA   : pPreparaComSTA;
    conRei   : pPreparaComRei;
  End;
end;

procedure TGerenciaConsultaCadastro.pPreparaComRei;
begin
  pAddColunaSql('R.REI_DESCRI', 'Descricao');
  pAddColunaSql('R.REI_REFERE', 'Referencia');
  pAddColunaSql('R.REI_UNIDAD', 'Unidade');
  pAddColunaSql('R.REI_CODITE', 'Cód. Item');
  pAddColunaSql('I.ITE_DESITE', 'Base');
  FstrSQL := FstrSQL + '  R.REI_PREVEN, ';
  FstrSQL := FstrSQL + '  R.REI_PRECUS, ';
  FstrSQL := FstrSQL + '  R.AUTOINCREM ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + FstrTabela;
  FstrSQL := FstrSQL + 'LEFT JOIN CADITE I ON I.ITE_CODITE =  REI_CODITE';
  FarrOrdenacao  :=  ['REI_DESCRI'];
end;

procedure TGerenciaConsultaCadastro.pPreparaComSTA;
begin
  pAddColunaSql('STA_NOMCOR', 'Descrição');
  pAddColunaSql('STA_CODLIN', 'Linha');
  pAddColunaSql('STA_MONTAD', 'Montadora');
  pAddColunaSql('STA_UNIVER', 'Cod. Universal');
  pAddColunaSql('STA_ANOCOR', 'Ano');
  FstrSql := FstrSQL + 'AUTOINCREM ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + FstrTabela;
  FarrOrdenacao  :=  ['STA_NOMCOR'];
end;

procedure TGerenciaConsultaCadastro.pPreparaConBzi;
begin
  pAddColunaSql('BZI_DESCRI', 'Descrição');
  pAddColunaSql('BZI_REFERE', 'Referencia');
  pAddColunaSql('BZI_CODIGO', 'Código');
  pAddColunaSql('BZI_UNIDAD', 'Unidade');
  pAddColunaSql('BZI_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('BZI_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('BZI_CODITE', 'Cód. Item');
  pAddColunaSql('ITE_DESITE', 'Item');
  FstrSql := FstrSQL + 'BZI_CADBZI.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + FstrTabela;
  FstrSQL := FstrSQL + 'LEFT JOIN CADITE I ON I.ITE_CODITE =  BZI_CODITE';
  FarrOrdenacao  :=  ['BZI_DESCRI'];
end;

procedure TGerenciaConsultaCadastro.pPreparaConCorImo;
begin
  pAddColunaSql('COR_DESCRI', 'Descricao');
  pAddColunaSql('COR_UNIDAD', 'Unidade');
  pAddColunaSql('COR_CODIGO', 'Codigo');
  pAddColunaSql('COR_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('COR_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('COR_COLCUS', 'Pr. Custo Colorante', 2);
  pAddColunaSql('COR_COLVEN', 'Pr. Venda Colorante', 2);
  pAddColunaSql('COR_CODITE', 'Cód. Item');
  pAddColunaSql('ITE_DESITE', 'Item');
  FstrSQL := FstrSQL + '  CORIMO_CADCOR.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + FstrTabela;
  FstrSQL := FstrSQL + 'LEFT JOIN CADITE I ON I.ITE_CODITE =  COR_CODITE';
  FarrOrdenacao  :=  ['COR_DESCRI'];
end;

procedure TGerenciaConsultaCadastro.pPreparaConCorInd;
begin
  pAddColunaSql('COR_DESCRI', 'Descricao');
  pAddColunaSql('COR_UNIDAD', 'Unidade');
  pAddColunaSql('COR_CODIGO', 'Codigo');
  pAddColunaSql('COR_PRECUS', 'Preço Custo', 2);
  pAddColunaSql('COR_PREVEN', 'Preço Venda', 2);
  pAddColunaSql('COR_COLCUS', 'Pr. Custo Colorante', 2);
  pAddColunaSql('COR_COLVEN', 'Pr. Venda Colorante', 2);
  pAddColunaSql('COR_CODITE', 'Cód. Item');
  pAddColunaSql('ITE_DESITE', 'Item');
  FstrSQL := FstrSQL + '  CORIND_CADCOR.AUTOINCREM AS "AUTOINCREM" ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + FstrTabela;
  FstrSQL := FstrSQL + 'LEFT JOIN CADITE I ON I.ITE_CODITE =  COR_CODITE';
  FarrOrdenacao  :=  ['COR_DESCRI'];
end;

procedure TGerenciaConsultaCadastro.pPreparaConLks;
begin
  pAddColunaSql('S.LKS_DESCRI', 'Descricao');
  pAddColunaSql('S.LKS_REFERE', 'Referencia');
  pAddColunaSql('S.LKS_UNIDAD', 'Unidade');
  pAddColunaSql('S.LKS_CODITE', 'Cód. Item');
  pAddColunaSql('I.ITE_DESITE', 'Base');
  pAddColunaSql('S.LKS_PREVEN', 'Preço de Venda');
  FstrSQL := FstrSQL + '  S.AUTOINCREM ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + FstrTabela + ' AS S ';
  FstrSQL := FstrSQL + 'LEFT JOIN CADITE I ON I.ITE_CODITE =  S.LKS_CODITE';
  FarrOrdenacao  :=  ['LKS_DESCRI'];
end;

procedure TGerenciaConsultaCadastro.pPreparaConPPG;
begin
  pAddColunaSql('PPG_DESCOR', 'Descrição Cor');
  pAddColunaSql('PPG_VEICUL', 'Veiculo');
  pAddColunaSql('PPG_MONTAD', 'Montadora');
  pAddColunaSql('PPG_A_N_O_', 'Ano');
  pAddColunaSql('PPG_TIPO__', 'Tipo');
  pAddColunaSql('PPG_CODCOR', 'Cód. Cor');
  pAddColunaSql('PPG_CODATC', 'Cód. PPG');
  pAddColunaSql('PPG_PREVEN_GL');
  pAddColunaSql('PPG_PRECUS');
  pAddColunaSql('PPG_PREVEN');
  FstrSQL := FstrSQL + '  AUTOINCREM ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + '  PPG_CADPPG ';
  FarrOrdenacao  :=  ['PPG_DESCOR'];
  FObjConsulta.pIncluiSubConsulta('PPG_PRECUS_GL', '(PPG_PRECUS * 3.6)');
  FObjConsulta.pIncluiSubConsulta('PPG_PREVEN_GL', '(PPG_PREVEN * 3.6)');
end;


procedure TGerenciaConsultaCadastro.pPreparaConPPX;
begin
  pAddColunaSql('PPX_DESCOR', 'Descrição Cor');
  pAddColunaSql('PPX_VEICUL', 'Veiculo');
  pAddColunaSql('PPX_MONTAD', 'Montadora');
  pAddColunaSql('PPX_A_N_O_', 'Ano');
  pAddColunaSql('PPX_TIPO__', 'Tipo');
  pAddColunaSql('PPX_CODCOR', 'Cód. Cor');
  pAddColunaSql('PPX_CODATC', 'Cód. PPG');
  pAddColunaSql('PPX_PREVEN_GL');
  pAddColunaSql('PPX_PRECUS');
  pAddColunaSql('PPX_PREVEN');
  FstrSQL := FstrSQL + '  AUTOINCREM ';
  FstrSQL := FstrSQL + 'FROM ';
  FstrSQL := FstrSQL + '  PPX_CADPPX ';
  FarrOrdenacao  :=  ['PPX_DESCOR'];
  FObjConsulta.pIncluiSubConsulta('PPX_PRECUS_GL', '(PPX_PRECUS * 3.6)');
  FObjConsulta.pIncluiSubConsulta('PPX_PREVEN_GL', '(PPX_PREVEN * 3.6)');
end;


{ TGerenciaNomeTintaPesqEmbalagens }

constructor TGerenciaNomeTintaPesqEmbalagens.Create(strTabelaEmb: String);
begin
  pSetNomeTintaEmb(strTabelaEmb);
end;

procedure TGerenciaNomeTintaPesqEmbalagens.pSetNomeTintaEmb(strTabelaEmb: String);
begin
  FstrNomeTintaEmb := '';

  strTabelaEmb := Copy(strTabelaEmb,1,(Pos('_', strTabelaEmb) - 1));

  If strTabelaEmb = 'ADVCOR' Then FstrNomeTintaEmb := 'Advance';
  If strTabelaEmb = 'ADV' Then FstrNomeTintaEmb := 'Advance';
  If strTabelaEmb = 'LKD' Then FstrNomeTintaEmb := 'Lukscolor';
  If strTabelaEmb = 'RSI' Then FstrNomeTintaEmb := 'Resicolor';
  If strTabelaEmb = 'ANJ' Then FstrNomeTintaEmb := 'Anjo';
  If strTabelaEmb = 'WEG' Then FstrNomeTintaEmb := 'Weg';
  If strTabelaEmb = 'IQU' Then FstrNomeTintaEmb := 'Iquine';
  If strTabelaEmb = 'LIK' Then FstrNomeTintaEmb := 'Liko';
  If strTabelaEmb = 'REC' Then FstrNomeTintaEmb := 'Recoa';
  If strTabelaEmb = 'GLO' Then FstrNomeTintaEmb := 'Global Color';
  If strTabelaEmb = 'AJA' Then FstrNomeTintaEmb := 'Anjo Sintética';
  If strTabelaEmb = 'REN' Then FstrNomeTintaEmb := 'Renner Industrial';
  If strTabelaEmb = 'ANN' Then FstrNomeTintaEmb := 'Anneta';
end;

{ TGerenciaConsultaLinha }

constructor TGerenciaConsultaLinha.Create(opcConsulta: TTipoTintas;
  CampoRelacionamento: string);
begin
  Inherited Create(opcConsulta, CampoRelacionamento);
  FstrTituloTela := 'Consulta de Linha';
  FstrTabela := FstrSiglaTinta + '_CADLIN';
  FStrSQL := 'SELECT SQL_NO_CACHE ';

  Case opcConsulta of
    conCoa, conAds, conMif, conBla: pPreparaPadrao;
  End;

  FstrCodLinha := 'LIN_CODLIN';
  FstrDesLinha := 'LIN_DESCRI';
end;

procedure TGerenciaConsultaLinha.pPreparaPadrao;
begin
  Case FopcConsulta Of
    conCoa: FstrTabela := 'COA_CADLIN';
    conAds: FstrTabela := 'ADS_CADLIN';
    conMif: FstrTabela := 'MIF_CADLIN';
    conBla: FstrTabela := 'BLA_CADLIN';
  End;

  FstrSQL := ' SELECT SQL_NO_CACHE ';

  pAddColunaSql('LIN_CODLIN', 'Código');
  pAddColunaSql('LIN_DESCRI', 'Linha');

  FstrSQL := FstrSQL + '  AUTOINCREM ';
  FstrSQL := FstrSQL + ' FROM ' + FstrTabela + ' AS L ';

  FarrOrdenacao  :=  ['LIN_CODLIN'];
end;

end.

