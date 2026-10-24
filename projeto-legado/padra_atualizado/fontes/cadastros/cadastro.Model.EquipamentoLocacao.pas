unit cadastro.Model.EquipamentoLocacao;

interface

uses
  cadastro.Model.AcessorioLocacao, System.Generics.Collections,
  Classes, SysUtils, Uni, untCadLote, untTypesLocEqu;

type

  TEquipamentoItemAcessorio = class;
  TNegociacaoDiaria = class;

  TEquipamentoLocacaoPrincipal = class 
  private
    FAnoFab: Integer;
    FAutInc: String;
    FCodigo: String;
    FCodIte: String;
    FDesIte: String;
    FDatAqu: TDateTime;
    FDescri: String;
    FDtaVen: TDateTime;
    FDtUlMn: TDateTime;
    FEspecf: String;
    FGarant: Integer;
    FLocFis: String;
    FModelo: String;
    FNSerie: String;
    FRpUlMn: String;
    FStatus: String;
    FValAqu: Double;
    FValLoc: Double;
    FVlLocD: Double;
    FDscVen: Double;
    FDscSGe: Double;
    FDscGer: Double;
    FVlrCau: Double;
    FMensagem: String;
    FobjCadLot: TCadLot;
    FBlnTrv: Boolean;
    FSlMensagemTrava: TStringList;
    FNumLot: String;
    FVlrAqu: Double;
    FVlLocM: Double;
    FCodEqu: String;
    FDesEqu: String;
    FNumPat: String;
    FblnSemSerie: Boolean;

    FListaItens  : TList<TEquipamentoItemAcessorio>;
    FListaDiarias: TList<TNegociacaoDiaria>;


    function fValidarItemEhEquipamentoLocacao(const strImpLst, strRealoc, strTipLoc: String; blnListarTodos: Boolean): Boolean;

    function GetAnoFab: Integer;
    function GetAutInc: String;
    function GetCodigo: String;
    function GetCodIte: String;
    function GetDesIte: String;
    function GetDatAqu: TDateTime;
    function GetDescri: String;
    function GetDtaVen: TDateTime;
    function GetDtUlMn: TDateTime;
    function GetEspecf: String;
    function GetGarant: Integer;
    function GetLocFis: String;
    function GetModelo: String;
    function GetNSerie: String;
    function GetRpUlMn: String;
    function GetStatus: String;
    function GetValAqu: Double;
    function GetValLoc: Double;
    function GetLItens: TList<TEquipamentoItemAcessorio>;
    function GetDiaria: TList<TNegociacaoDiaria>;
    function GetMensagem: String;

    procedure SetAutInc(const AValue: String);
    procedure SetCodigo(const AValue: String);
    procedure SetDescri(const AValue: String);
    procedure SetNSerie(const AValue: String);
    procedure SetDatAqu(const AValue: TDateTime);
    procedure SetValAqu(const AValue: Double);
    procedure SetValLoc(const AValue: Double);
    procedure SetGarant(const AValue: Integer);
    procedure SetDtUlMn(const AValue: TDateTime);
    procedure SetRpUlMn(const AValue: String);
    procedure SetModelo(const AValue: String);
    procedure SetAnoFab(const AValue: Integer);
    procedure SetEspecf(const AValue: String);
    procedure SetLocFis(const AValue: String);
    procedure SetCodIte(const AValue: String);
    procedure SetDesIte(const AValue: String);
    procedure SetDtaven(const AValue: TDateTime);
    procedure SetStatus(const AValue: String);
    procedure SetLItens(const AValue: TList<TEquipamentoItemAcessorio>);
    procedure SetDiaria(const AValue: TList<TNegociacaoDiaria>);

    function GetVlLocD: Double;
    procedure SetVlLocD(const AValue: Double);
    function GetVlrCau: Double;
    function GetVlrDscGer: Double;
    function GetVlrDscSGe: Double;
    function GetVlrDscVen: Double;
    procedure SetVlrCau(const AValue: Double);
    procedure SetVlrDscGer(const AValue: Double);
    procedure SetVlrDscSGe(const AValue: Double);
    procedure SetVlrDscVen(const AValue: Double);
    function GetTrvInc: Boolean;
    procedure SetTrvInc(const AValue: Boolean);
    function GetMsgTrv: String;
    function GetNumLot: String;
    procedure SetNumLot(const AValue: String);
    function GetVlrAqu: Double;
    procedure SetVlrAqu(const AValue: Double);
    function GetVlLocM: Double;
    procedure SetVlLocM(const AValue: Double);
    procedure SetCodEquOS(const AValue: String);
    function GetCodEquOS: String;
    function GetDesEquOS: String;
    procedure SetDesEquOS(const AValue: String);
    function GetNumPat: String;
    procedure SetNumPat(const AValue: String);
    function GetblnSemSerie: Boolean;
    procedure SetblnSemSerie(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pCarregaEquipamento(const strAutInc: String = ''; const strCodEqu: String = '');
    procedure pCarregaNegociacaoDiarias(const strAutInc: String);
    procedure pCarregaConsultaNegociacaoDiarias(const strAutInc: String);
    procedure pLimparItens;
    procedure pLimparDiarias;
    procedure pExcluirDiarias;
    procedure pExcluirItens;
    procedure pCarregaItensAcessorios;

    function AddItem: TEquipamentoItemAcessorio;
    function AddNegociacaoDiaria: TNegociacaoDiaria;
    function fValidaItemLocacao(strCodIte: String; blnListarTodos: Boolean = False): Boolean;
    function fVerificaAcessorio(const aCodAcl: string): Boolean;
    function fValidarDiariaNegociacao(const aQtdDia: Integer): Boolean;
    function fRemoveDiaria(const aDia: Integer): Boolean;
    function fRemoveAcessorio(const aCodAcl: String): Boolean;
    function fValidarEquipamento: Boolean;
    function fValorDescontoMaximo(const intNlv: Integer): Double;
    function fValidarItemAssociadoEquipamento(const strCodIte: String): Boolean;

    procedure pLimpar;
    class procedure pAtivarEquipamento(const strAutInc: String);

    property AutInc: String read GetAutInc write SetAutInc;
    property Codigo: String read GetCodigo write SetCodigo;
    property Descricao: String read GetDescri write SetDescri;
    property NumSerie: String read GetNSerie write SetNSerie;
    property DataAquisicao: TDateTime read GetDatAqu write SetDatAqu;
    property ValorAquisicao: Double read GetValAqu write SetValAqu;
    property ValorLocacao: Double read GetValLoc write SetValLoc;
    property Garantia: Integer read GetGarant write SetGarant;
    property DataUltimaManutencao: TDateTime read GetDtUlMn write SetDtUlMn;
    property ResponsavelUltimaManutencao: String read GetRpUlMn write SetRpUlMn;
    property Modelo: String read GetModelo write SetModelo;
    property AnoFabricacao: Integer read GetAnoFab write SetAnoFab;
    property Especificacao: String read GetEspecf write SetEspecf;
    property LocalizacaoFisica: String read GetLocFis write SetLocFis;
    property CodigoItem: String read GetCodIte write SetCodIte;
    property DataVenda: TDateTime read GetDtaVen write SetDtaven;
    property Status: String read GetStatus write SetStatus;
    property Acessorios: TList<TEquipamentoItemAcessorio> read GetLItens write SetLItens;
    property Diarias: TList<TNegociacaoDiaria> read GetDiaria write SetDiaria;
    property Mensagem: String read GetMensagem;
    property DescricaoItem: String read GetDesIte write SetDesIte;
    property ValorLocacaoDiaria: Double read GetVlLocD write SetVlLocD;
    property ValorDescontoVendedor: Double read GetVlrDscVen write SetVlrDscVen;
    property ValorDescontoSubGerente: Double read GetVlrDscSGe write SetVlrDscSGe;
    property ValorDescontoGerente: Double read GetVlrDscGer write SetVlrDscGer;
    property ValorCaucao: Double read GetVlrCau write SetVlrCau;
    property TravaInclusao: Boolean read GetTrvInc write SetTrvInc;
    property MensagemTravaInclusao: String read GetMsgTrv;
    property NumLoteItem: String read GetNumLot write SetNumLot;
    property ValorAqu: Double read GetVlrAqu write SetVlrAqu;
    property ValorLocacaoMensal: Double read GetVlLocM write SetVlLocM;
    property CodEquipamentoOS: String read GetCodEquOS write SetCodEquOS;
    property DesEquipamentoOS: String read GetDesEquOS write SetDesEquOS;
    property NumPatrimonio: String read GetNumPat write SetNumPat;
    property blnNaoPossuiSerie: Boolean read GetblnSemSerie write SetblnSemSerie;
  End;

  TEquipamentoItemAcessorio = class
  [weak]
  private
    FAutInc: String;
    FCodigo: String;
    FEqlLoc: TEquipamentoLocacaoPrincipal;
    FAclLoc: TEquipamentoLocacaoAcessorio;
    FQtdAcl: Double;
    FqryInsert: TUniQuery;
    FqryDelete: TUniQuery;
    FVlrAdc: Double;

    function GetAutInc: String;
    function GetCodigo: String;
    function GetQtdAcl: Double;
    function GetEqlLoc: TEquipamentoLocacaoPrincipal;
    function GetAclLoc: TEquipamentoLocacaoAcessorio;

    procedure SetAutInc(const AValue: String);
    procedure SetCodigo(const AValue: String);
    procedure SetQtdAcl(const AValue: Double);
    procedure SetEqlLoc(const AValue: TEquipamentoLocacaoPrincipal);
    procedure SetAclLoc(const AValue: TEquipamentoLocacaoAcessorio);
    function GetVlrAdc: Double;
    procedure SetVlrAdc(const AValue: Double);
  public
    constructor Create(Owner: TEquipamentoLocacaoPrincipal);
    destructor Destroy; override;

    function fInserir: Boolean;
    function fExcluir: Boolean;

    property AutInc: String read GetAutInc write SetAutInc;
    property Codigo: String read GetCodigo write SetCodigo;
    property Quantidade: Double read GetQtdAcl write SetQtdAcl;
    property Equipamento: TEquipamentoLocacaoPrincipal read GetEqlLoc write SetEqlLoc;
    property Acessorio: TEquipamentoLocacaoAcessorio read GetAclLoc write SetAclLoc;
    property ValorAdicional: Double read GetVlrAdc write SetVlrAdc;
  end;

  TNegociacaoDiaria = Class
  [weak]
  private
    FAutInc: String;
    FCodigo: String;
    FQtdDia: Integer;
    FVlrTot: Double;
    FVlrDia: Double;
    FEqlLoc: TEquipamentoLocacaoPrincipal;
    FqryInsert: TUniQuery;
    FqryDelete: TUniQuery;

    function GetAutInc: String;
    function GetCodigo: String;
    function GetQtdDia: Integer;
    function GetVlrDia: Double;
    function GetVlrTot: Double;
    procedure SetAutInc(const AValue: String);
    procedure SetCodigo(const AValue: String);
    procedure SetQtdDia(const AValue: Integer);
    procedure SetVlrDia(const AValue: Double);
    procedure SetVlrTot(const AValue: Double);
  public
    constructor Create(Owner: TEquipamentoLocacaoPrincipal);
    destructor Destroy; override;

    procedure pAdicionaValorDiaria(const aQtdDia: Integer; const aVlrTot: Double);
    function fInserir: Boolean;
    function fExcluir: Boolean;

    property AutInc: String read GetAutInc write SetAutInc;
    property Codigo: String read GetCodigo write SetCodigo;
    property ValorDiaria: Double read GetVlrDia write SetVlrDia;
    property QuantidadeDias: Integer read GetQtdDia write SetQtdDia;
    property ValorTotal: Double read GetVlrTot write SetVlrTot;
  End;

  THerancaCadEquLoc = Class
  private
    FobjEqu: TEquipamentoLocacaoPrincipal;

    function getObjEqu: TEquipamentoLocacaoPrincipal;
  public
    constructor Create;
    destructor Destroy; override;

    function fHerdarCadEquLoc(const strCodEqu: String): Boolean;
    property objEqu: TEquipamentoLocacaoPrincipal read getObjEqu;
  End;

implementation

uses
  untFuncoesSimples, untFuncoesLocEqu, DateUtils;

{ TEquipamentoLocacaoPrincipal }

function TEquipamentoLocacaoPrincipal.AddItem: TEquipamentoItemAcessorio;
var
  intCont: Integer;
begin
  FListaItens.add(TEquipamentoItemAcessorio.Create(Self));
  intCont := FListaItens.Count -1;
  Result  := FListaItens[intCont];
end;

function TEquipamentoLocacaoPrincipal.AddNegociacaoDiaria: TNegociacaoDiaria;
var
  intCont: Integer;
begin
  FListaDiarias.add(TNegociacaoDiaria.Create(Self));
  intCont := FListaDiarias.Count -1;
  Result  := FListaDiarias[intCont];
end;

constructor TEquipamentoLocacaoPrincipal.Create;
begin
  inherited;

  FListaItens  := TList<TEquipamentoItemAcessorio>.Create;
  FListaDiarias:= TList<TNegociacaoDiaria>.Create;
  FobjCadLot := TCadLot.Create(nil);
  FSlMensagemTrava := TStringList.Create;
end;

destructor TEquipamentoLocacaoPrincipal.Destroy;
begin
  FreeAndNil(FListaItens);
  FreeAndNil(FListaDiarias);
  FreeAndNil(FobjCadLot);
  FreeAndNil(FSlMensagemTrava);

  inherited;

end;

function TEquipamentoLocacaoPrincipal.GetAnoFab: Integer;
begin
  Result := FAnoFab;
end;

function TEquipamentoLocacaoPrincipal.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TEquipamentoLocacaoPrincipal.GetblnSemSerie: Boolean;
begin
  Result := FblnSemSerie;
end;

function TEquipamentoLocacaoPrincipal.GetCodEquOS: String;
begin
  Result := FCodEqu;
end;

function TEquipamentoLocacaoPrincipal.GetCodigo: String;
begin
  Result := FCodigo;
end;

function TEquipamentoLocacaoPrincipal.GetCodIte: String;
begin
  Result := FCodIte;
end;

function TEquipamentoLocacaoPrincipal.GetDatAqu: TDateTime;
begin
  Result := FDatAqu;
end;

function TEquipamentoLocacaoPrincipal.GetDescri: String;
begin
  Result := FDescri;
end;

function TEquipamentoLocacaoPrincipal.GetDesEquOS: String;
begin
  Result := FDesEqu;
end;

function TEquipamentoLocacaoPrincipal.GetDesIte: String;
begin
  Result := FDesIte;
end;

function TEquipamentoLocacaoPrincipal.GetDiaria: TList<TNegociacaoDiaria>;
begin
  Result := FListaDiarias;
end;

function TEquipamentoLocacaoPrincipal.GetDtaVen: TDateTime;
begin
  Result := FDtaVen;
end;

function TEquipamentoLocacaoPrincipal.GetDtUlMn: TDateTime;
begin
  Result := FDtUlMn;
end;

function TEquipamentoLocacaoPrincipal.GetEspecf: String;
begin
  Result := FEspecf;
end;

function TEquipamentoLocacaoPrincipal.GetGarant: Integer;
begin
  Result := FGarant;
end;

function TEquipamentoLocacaoPrincipal.GetLItens: TList<TEquipamentoItemAcessorio>;
begin
  Result := FListaItens;
end;

function TEquipamentoLocacaoPrincipal.GetLocFis: String;
begin
  Result := FLocFis;
end;

function TEquipamentoLocacaoPrincipal.GetMensagem: String;
begin
  Result := FMensagem;
end;

function TEquipamentoLocacaoPrincipal.GetModelo: String;
begin
  Result := FModelo;
end;

function TEquipamentoLocacaoPrincipal.GetMsgTrv: String;
begin
  Result := FSlMensagemTrava.Text;
end;

function TEquipamentoLocacaoPrincipal.GetNSerie: String;
begin
  Result := FNSerie;
end;

function TEquipamentoLocacaoPrincipal.GetNumLot: String;
begin
  Result := FNumLot;
end;

function TEquipamentoLocacaoPrincipal.GetNumPat: String;
begin
  Result := FNumPat;
end;

function TEquipamentoLocacaoPrincipal.GetRpUlMn: String;
begin
  Result := FRpUlMn;
end;

function TEquipamentoLocacaoPrincipal.GetStatus: String;
begin
  Result := FStatus;
end;

function TEquipamentoLocacaoPrincipal.GetTrvInc: Boolean;
begin
  Result := FBlnTrv;
end;

function TEquipamentoLocacaoPrincipal.GetValAqu: Double;
begin
  Result := FValAqu;
end;

function TEquipamentoLocacaoPrincipal.GetValLoc: Double;
begin
  Result := FValLoc;
end;

function TEquipamentoLocacaoPrincipal.GetVlLocD: Double;
begin
  Result := FVlLocD;
end;

function TEquipamentoLocacaoPrincipal.GetVlLocM: Double;
begin
  Result := FVlLocM;
end;

function TEquipamentoLocacaoPrincipal.GetVlrAqu: Double;
begin
  Result := FVlrAqu;
end;

function TEquipamentoLocacaoPrincipal.GetVlrCau: Double;
begin
  Result := FVlrCau;
end;

function TEquipamentoLocacaoPrincipal.GetVlrDscGer: Double;
begin
  Result := FDscGer;
end;

function TEquipamentoLocacaoPrincipal.GetVlrDscSGe: Double;
begin
  Result := FDscSGe;
end;

function TEquipamentoLocacaoPrincipal.GetVlrDscVen: Double;
begin
  Result := FDscVen;
end;

procedure TEquipamentoLocacaoPrincipal.SetAnoFab(const AValue: Integer);
begin
  FAnoFab := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetblnSemSerie(const Value: Boolean);
begin
  FblnSemSerie := Value;
end;

procedure TEquipamentoLocacaoPrincipal.SetCodEquOS(const AValue: String);
begin
  FCodEqu := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetCodigo(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetCodIte(const AValue: String);
begin
  FCodIte := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetDatAqu(const AValue: TDateTime);
begin
  FDatAqu := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetDescri(const AValue: String);
begin
  FDescri := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetDesEquOS(const AValue: String);
begin
  FDesEqu := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetDesIte(const AValue: String);
begin
  FDesIte := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetDiaria(
  const AValue: TList<TNegociacaoDiaria>);
begin
  FListaDiarias := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetDtaVen(const AValue: TDateTime);
begin
  FDtaVen := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetDtUlMn(const AValue: TDateTime);
begin
  FDtUlMn := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetEspecf(const AValue: String);
begin
  FEspecf := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetGarant(const AValue: Integer);
begin
  FGarant := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetLItens(
  const AValue: TList<TEquipamentoItemAcessorio>);
begin
  FListaItens := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetLocFis(const AValue: String);
begin
  FLocFis := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetModelo(const AValue: String);
begin
  FModelo := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetNSerie(const AValue: String);
begin
  FNSerie := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetNumLot(const AValue: String);
begin
  FNumLot := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetNumPat(const AValue: String);
begin
  FNumPat := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetRpUlMn(const AValue: String);
begin
  FRpUlMn := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetStatus(const AValue: String);
begin
  FStatus := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetTrvInc(const AValue: Boolean);
begin
  FBlnTrv := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetValAqu(const AValue: Double);
begin
  FValAqu := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetValLoc(const AValue: Double);
begin
  FValLoc := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetVlLocD(const AValue: Double);
begin
  FVlLocD := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetVlLocM(const AValue: Double);
begin
  FVlLocM := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetVlrAqu(const AValue: Double);
begin
  FVlrAqu := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetVlrCau(const AValue: Double);
begin
  FVlrCau := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetVlrDscGer(const AValue: Double);
begin
  FDscGer := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetVlrDscSGe(const AValue: Double);
begin
  FDscSGe := AValue;
end;

procedure TEquipamentoLocacaoPrincipal.SetVlrDscVen(const AValue: Double);
begin
  FDscVen := AValue;
end;

class procedure TEquipamentoLocacaoPrincipal.pAtivarEquipamento(const strAutInc: String);
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.DisableControls;
    qryUpdate.SQL.Add('UPDATE CADEQL SET EQL_STATUS = "A", EQL_DTALIB = :DTALIB, EQL_HRALIB = :HRALIB, EQL_OPELIB = :OPELIB WHERE AUTOINCREM = :AUTINC');
    qryUpdate.ParamByName('AUTINC').AsString := strAutInc;
    qryUpdate.ParamByName('DTALIB').AsDateTime := Today;
    qryUpdate.ParamByName('HRALIB').AsDateTime := fNow();
    qryUpdate.ParamByName('OPELIB').AsString := strLoginUsuarioLogado;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TEquipamentoLocacaoPrincipal.pCarregaConsultaNegociacaoDiarias(
  const strAutInc: String);
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  item: TNegociacaoDiaria;
  fltVlrDiaria: Double;
begin
  pLimparDiarias;

  fltVlrDiaria := fCampoTabela('EQL_VLLOCD', 'CADEQL', ['AUTOINCREM'], [strAutInc], False);

  item := AddNegociacaoDiaria;
  item.QuantidadeDias := 1;
  item.ValorDiaria := fltVlrDiaria;
  item.ValorTotal := fltVlrDiaria;

  SQLSelect := 'SELECT EQUNGD.AUTOINCREM, ' +
               '       EQN_CODIGO,        ' +
               '       EQN_CODEQU,        ' +
               '       EQN_QTDDIA,        ' +
               '       EQN_VLRDIA,        ' +
               '       EQN_VLRTOT         ' +
               'FROM EQUNGD '+
               ' WHERE EQN_SEQEQU = :EQN_SEQEQU ' +
               ' ORDER BY EQN_QTDDIA';
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('EQN_SEQEQU').AsString := strAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      While Not qryConsulta.EOF Do
      Begin
        item := AddNegociacaoDiaria;
        item.AutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;
        item.Codigo := qryConsulta.FieldByName('EQN_CODIGO').AsString;
        item.QuantidadeDias := qryConsulta.FieldByName('EQN_QTDDIA').AsInteger;
        item.ValorDiaria := qryConsulta.FieldByName('EQN_VLRDIA').AsFloat;
        item.ValorTotal := qryConsulta.FieldByName('EQN_VLRTOT').AsFloat;

        qryConsulta.Next;
      End;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TEquipamentoLocacaoPrincipal.pCarregaEquipamento(const strAutInc: String = ''; const strCodEqu: String = '');
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  PrecoContrato: TPrecoContrato;
  intDecUni: Integer;
  objCadLot: TCadLot;
begin
  pLimpar;

  PrecoContrato :=  TPrecoContrato(fCfgSis('PRECTR', varInteger));
  intDecUni := fCfgSis('DECUNI', VarInteger);

  SQLSelect := 'SELECT CADEQL.AUTOINCREM, ' +
               '       EQL_CODIGO,        ' +
               '       EQL_DESCRI,        ' +
               '       EQL_NSERIE,        ' +
               '       EQL_DTAAQU,        ' +
               '       EQL_VALAQU,        ' +
               '       EQL_VALLOC,        ' +
               '       EQL_GARANT,        ' +
               '       EQL_DTULMN,        ' +
               '       EQL_RPULMN,        ' +
               '       EQL_MODELO,        ' +
               '       EQL_ANOFAB,        ' +
               '       EQL_ESPECF,        ' +
               '       EQL_LOCFIS,        ' +
               '       EQL_CODITE,        ' +
               '       EQL_DTAVEN,        ' +
               '       EQL_STATUS,        ' +
               '       I.ITE_DESITE,      ' +
               '       EQL_VLLOCD,        ' +
               '       EQL_DSCVEN,        ' +
               '       EQL_DSCSGE,        ' +
               '       EQL_DSCGER,        ' +
               '       EQL_VLRCAU,        ' +
               '       G.ITE_PREVE1,      ' +
               '       G.ITE_PREVE2,      ' +
               '       G.ITE_PREVE3,      ' +
               '       G.ITE_PREVE4,      ' +
               '       G.ITE_PREVE5,      ' +
               '       G.ITE_PREVE6,      ' +
               '       G.ITE_PREVE7,      ' +
               '       G.ITE_PRECUS,      ' +
               '       G.ITE_PREMED,      ' +
               '       G.ITE_PRECOM,      ' +
               '       G.ITE_DESF01,      ' +
               '       G.ITE_DESF02,      ' +
               '       G.ITE_DESF03,      ' +
               '       G.ITE_DESF04,      ' +
               '       G.ITE_DESF05,      ' +
               '       G.ITE_DESF06,      ' +
               '       EQL_VLLOCM,        ' +
               '       EQL_CODEQU,        ' +
               '       EQU_DESCRI,        ' +
               '       EQL_NUMPAT,        ' +
               '       EQL_SEMSER         ' +
               'FROM CADEQL               ' +
               ' INNER JOIN CADITE I ON (I.ITE_CODITE = EQL_CODITE)    ' +
               ' INNER JOIN ITEGER G ON (I.ITE_CODITE = G.ITE_CODITE ) ' +
               ' LEFT  JOIN CADEQU S ON (EQL_CODEQU = EQU_CODIGO )     ' +
               'WHERE TRUE ';

  If Not fEmptyStr(strAutInc) Then
    SQLSelect := SQLSelect +  ' AND CADEQL.AUTOINCREM = :AUTOINCREM ';

  If Not fEmptyStr(strCodEqu) Then
    SQLSelect := SQLSelect +  ' AND CADEQL.EQL_CODIGO = :EQL_CODIGO ';

  SQLSelect := SQLSelect +  ' AND G.ITE_CODEMP = :ITE_CODEMP ';

  qryConsulta := fCriaQuery;
  objCadLot := TCadLot.Create(Nil);
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    If qryConsulta.Params.FindParam('AUTOINCREM') <> Nil Then
      qryConsulta.ParamByName('AUTOINCREM').AsString := strAutInc;
    If qryConsulta.Params.FindParam('EQL_CODIGO') <> Nil Then
      qryConsulta.ParamByName('EQL_CODIGO').AsString := strCodEqu;
    qryConsulta.ParamByName('ITE_CODEMP').AsString := VS_strCodEmp;

    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      FAnoFab := qryConsulta.FieldByName('EQL_ANOFAB').AsInteger;
      FAutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;
      FCodigo := qryConsulta.FieldByName('EQL_CODIGO').AsString;
      FCodIte := qryConsulta.FieldByName('EQL_CODITE').AsString;
      FDatAqu := qryConsulta.FieldByName('EQL_DTAAQU').AsDateTime;
      FDescri := qryConsulta.FieldByName('EQL_DESCRI').AsString;
      FDtaVen := qryConsulta.FieldByName('EQL_DTAVEN').AsDateTime;
      FDtUlMn := qryConsulta.FieldByName('EQL_DTULMN').AsDateTime;
      FEspecf := qryConsulta.FieldByName('EQL_ESPECF').AsString;
      FGarant := qryConsulta.FieldByName('EQL_GARANT').AsInteger;
      FLocFis := qryConsulta.FieldByName('EQL_LOCFIS').AsString;
      FModelo := qryConsulta.FieldByName('EQL_MODELO').AsString;
      FNSerie := qryConsulta.FieldByName('EQL_NSERIE').AsString;
      FRpUlMn := qryConsulta.FieldByName('EQL_RPULMN').AsString;
      FStatus := qryConsulta.FieldByName('EQL_STATUS').AsString;
      FValAqu := qryConsulta.FieldByName('EQL_VALAQU').AsFloat;
      FValLoc := qryConsulta.FieldByName('EQL_VALLOC').AsFloat;
      FVlLocD := qryConsulta.FieldByName('EQL_VLLOCD').AsFloat;
      FDscVen := qryConsulta.FieldByName('EQL_DSCVEN').AsFloat;
      FDscSGe := qryConsulta.FieldByName('EQL_DSCSGE').AsFloat;
      FDscGer := qryConsulta.FieldByName('EQL_DSCGER').AsFloat;
      FDesIte := qryConsulta.FieldByName('ITE_DESITE').AsString;
      FVlrCau := qryConsulta.FieldByName('EQL_VLRCAU').AsFloat;
      FVlLocM := qryConsulta.FieldByName('EQL_VLLOCM').AsFloat;

      Case PrecoContrato of
        preCompraLiq: Begin
                        FVlrAqu := untfuncoesSimples.fCalculaPrecoCompraLiq(qryConsulta.FieldByName('ITE_PRECOM').AsFloat,
                                                                            qryConsulta.FieldByName('ITE_DESF01').AsFloat,
                                                                            qryConsulta.FieldByName('ITE_DESF02').AsFloat,
                                                                            qryConsulta.FieldByName('ITE_DESF03').AsFloat,
                                                                            qryConsulta.FieldByName('ITE_DESF04').AsFloat,
                                                                            qryConsulta.FieldByName('ITE_DESF05').AsFloat,
                                                                            qryConsulta.FieldByName('ITE_DESF06').AsFloat,
                                                                            intDecUni);
                      End;
        preCusto    : FVlrAqu := qryConsulta.FieldByName('ITE_PRECUS').AsFloat;
        preMedio    : FVlrAqu := qryConsulta.FieldByName('ITE_PREMED').AsFloat;
        preTabela1  : FVlrAqu := qryConsulta.FieldByName('ITE_PREVE1').AsFloat;
        preTabela2  : FVlrAqu := qryConsulta.FieldByName('ITE_PREVE2').AsFloat;
        preTabela3  : FVlrAqu := qryConsulta.FieldByName('ITE_PREVE3').AsFloat;
        preTabela4  : FVlrAqu := qryConsulta.FieldByName('ITE_PREVE4').AsFloat;
        preTabela5  : FVlrAqu := qryConsulta.FieldByName('ITE_PREVE5').AsFloat;
        preTabela6  : FVlrAqu := qryConsulta.FieldByName('ITE_PREVE6').AsFloat;
        preTabela7  : FVlrAqu := qryConsulta.FieldByName('ITE_PREVE7').AsFloat;
        preCaucao   : FVlrAqu := qryConsulta.FieldByName('EQL_VLRCAU').AsFloat
        Else
          FVlrAqu := qryConsulta.FieldByName('ITE_PRECUS').AsFloat;
      End;

      If ((objCadLot.tplTipLot = tplArmazem) And (fEmptyStr(FNumLot))) Then
      Begin
        FNumLot := objCadLot.fRetArmazemPrincipalLocacaoDeEquipamento(FCodIte);
      End;

      FCodEqu := qryConsulta.FieldByName('EQL_CODEQU').AsString;
      FDesEqu := qryConsulta.FieldByName('EQU_DESCRI').AsString;
      FNumPat := qryConsulta.FieldByName('EQL_NUMPAT').AsString;
      FblnSemSerie := IIF(qryConsulta.FieldByName('EQL_SEMSER').AsString = 'S', True, False);

      pCarregaItensAcessorios;
      pCarregaNegociacaoDiarias(FAutInc);
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
    FreeAndNil(objCadLot);
  End;
end;

procedure TEquipamentoLocacaoPrincipal.pCarregaItensAcessorios;
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  itemAcessorio: TEquipamentoItemAcessorio;
begin
  pLimparItens;

  SQLSelect := 'SELECT EQUACL.AUTOINCREM, ' +
               '       EQA_CODIGO, ' +
               '       EQA_CODACL, ' +
               '       EQA_QTDACL, ' +
               '       EQA_CODEQU, ' +
               '       ACL_DESCRI, ' +
               '       EQA_SEQACL, ' +
               '       EQA_SEQACL, ' +
               '       EQA_VLRADC  ' +
               'FROM EQUACL '+
               ' INNER JOIN CADACL ON (EQA_CODACL = ACL_CODIGO) ' +
               ' WHERE EQA_SEQEQU = :EQA_SEQEQU ' +
               ' ORDER BY EQA_CODIGO';
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('EQA_SEQEQU').AsString := FAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      While Not qryConsulta.EOF Do
      Begin
        itemAcessorio := AddItem;
        itemAcessorio.AutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;
        itemAcessorio.Codigo := qryConsulta.FieldByName('EQA_CODIGO').AsString;
        itemAcessorio.Acessorio.AutInc    := qryConsulta.FieldByName('EQA_SEQACL').AsString;
        itemAcessorio.Acessorio.Codigo    := qryConsulta.FieldByName('EQA_CODACL').AsString;
        itemAcessorio.Acessorio.Descricao := qryConsulta.FieldByName('ACL_DESCRI').AsString;
        itemAcessorio.Acessorio.fCarregaAcessorio(itemAcessorio.Acessorio.Codigo);
        itemAcessorio.Quantidade := qryConsulta.FieldByName('EQA_QTDACL').AsFloat;
        itemAcessorio.ValorAdicional := qryConsulta.FieldByName('EQA_VLRADC').AsFloat;
        If itemAcessorio.ValorAdicional <= 0 Then
        Begin
          itemAcessorio.ValorAdicional := itemAcessorio.Acessorio.ValorAdicional;
        End;

        qryConsulta.Next;
      End;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TEquipamentoLocacaoPrincipal.pCarregaNegociacaoDiarias(const strAutInc: String);
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  item: TNegociacaoDiaria;
begin
  pLimparDiarias;

  SQLSelect := 'SELECT EQUNGD.AUTOINCREM, ' +
               '       EQN_CODIGO,        ' +
               '       EQN_CODEQU,        ' +
               '       EQN_QTDDIA,        ' +
               '       EQN_VLRDIA,        ' +
               '       EQN_VLRTOT         ' +
               'FROM EQUNGD '+
               ' WHERE EQN_SEQEQU = :EQN_SEQEQU ' +
               ' ORDER BY EQN_QTDDIA';
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('EQN_SEQEQU').AsString := strAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      While Not qryConsulta.EOF Do
      Begin
        item := AddNegociacaoDiaria;
        item.AutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;
        item.Codigo := qryConsulta.FieldByName('EQN_CODIGO').AsString;
        item.QuantidadeDias := qryConsulta.FieldByName('EQN_QTDDIA').AsInteger;
        item.ValorDiaria := qryConsulta.FieldByName('EQN_VLRDIA').AsFloat;
        item.ValorTotal := qryConsulta.FieldByName('EQN_VLRTOT').AsFloat;

        qryConsulta.Next;
      End;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TEquipamentoLocacaoPrincipal.pExcluirDiarias;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.DisableControls;
    qryDelete.SQL.Add('DELETE FROM EQUNGD WHERE EQN_SEQEQU = :EQN_SEQEQU');
    qryDelete.ParamByName('EQN_SEQEQU').AsString := FAutInc;
    qryDelete.ExecSQL;

    pLimparDiarias;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TEquipamentoLocacaoPrincipal.pLimpar;
begin
  FAnoFab := 0;
  FAutInc := EmptyStr;
  FCodigo := EmptyStr;
  FCodIte := EmptyStr;
  FDesIte := EmptyStr;
  FDatAqu := 0;
  FDescri := EmptyStr;
  FDtaVen := 0;
  FDtUlMn := 0;
  FEspecf := EmptyStr;
  FGarant := 0;
  FLocFis := EmptyStr;
  FModelo := EmptyStr;
  FNSerie := EmptyStr;
  FRpUlMn := EmptyStr;
  FStatus := EmptyStr;
  FValAqu := 0;
  FValLoc := 0;
  FVlLocD := 0;
  FDscVen := 0;
  FDscSGe := 0;
  FDscGer := 0;
  FVlrCau := 0;
  FMensagem  := EmptyStr;
  FBlnTrv := False;
  FVlLocM := 0;
  FCodEqu := EmptyStr;
  FDesEqu := EmptyStr;
  FNumPat := EmptyStr;
  FblnSemSerie := False;

  pLimparItens;
  pLimparDiarias;
end;

procedure TEquipamentoLocacaoPrincipal.pLimparDiarias;
begin
  FListaDiarias.Clear;
end;

procedure TEquipamentoLocacaoPrincipal.pExcluirItens;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.DisableControls;
    qryDelete.SQL.Add('DELETE FROM EQUACL WHERE EQA_SEQEQU = :EQA_SEQEQU');
    qryDelete.ParamByName('EQA_SEQEQU').AsString := FAutInc;
    qryDelete.ExecSQL;

    pLimparItens;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TEquipamentoLocacaoPrincipal.pLimparItens;
begin
  FListaItens.Clear;
end;

function TEquipamentoLocacaoPrincipal.fRemoveAcessorio(
  const aCodAcl: String): Boolean;
var
  intCont: Integer;
begin
  Result := False;
  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCont].FAclLoc.Codigo = aCodAcl Then
    Begin
      FListaItens.Delete(intCont);
      Result := True;
      Break;
    End;
  End;
end;

function TEquipamentoLocacaoPrincipal.fRemoveDiaria(
  const aDia: Integer): Boolean;
var
  intCont: Integer;
begin
  Result := False;
  For intCont := 0 to FListaDiarias.Count-1 Do
  Begin
    If FListaDiarias[intCont].FQtdDia = aDia Then
    Begin
      FListaDiarias.Delete(intCont);
      Result := True;
      Break;
    End;
  End;
end;

function TEquipamentoLocacaoPrincipal.fValidarEquipamento: Boolean;
var
  intCnt: Integer;
begin
  FBlnTrv := False;
  Result := True;
  FMensagem := EmptyStr;
  FSlMensagemTrava.Clear;

  If fEmptyStr(FCodigo) Then
  Begin
    FMensagem := 'Equipamento não encontrado.';
    Result := False;
    Exit;
  End;

  If FStatus = 'I' Then
  Begin
    FMensagem := 'Equipamento Inativo.';
    Result := False;
    Exit;
  End;

  If FStatus = 'B' Then
  Begin
    FMensagem := 'Equipamento Bloqueado.';
    Result := False;
    Exit;
  End;

  If (FobjCadLot.tplTipLot = tplArmazem) Then
  Begin
    If (not FobjCadLot.fExisteLotePrincipalAluguelEquipamento(FCodIte, VS_strCodEmp) ) Then
    Begin
      FMensagem := 'Equipamento '+ FCodigo + ' - ' + FDescri + ' sem armazém principal para locação de equipamentos!';
      Result := False;
      Exit;
    End;
  End;

  If fValidaItemLocacao(FCodIte, True) Then
  Begin
    For intCnt := 0 to FListaItens.Count-1 Do
    Begin
      Result := FListaItens[intCnt].Acessorio.fValidaAcessorio(True);
      If Not Result Then
      Begin
        FBlnTrv := True;
        FMensagem := FListaItens[intCnt].Acessorio.MensagemTrava;
        FSlMensagemTrava.Clear;

        If FListaItens[intCnt].Acessorio.blnCodigoItemValido Then
        Begin
          FSlMensagemTrava.Add('O acessório do equipamento está com um status que não permite a contratação do mesmo. Verifique o cadastro do  ' +
                              ' equipamento e depois, tente novamente. ');
          FSlMensagemTrava.Add('');
          FSlMensagemTrava.Add('Acessório: '+ FListaItens[intCnt].Acessorio.Codigo + ' - ' + FListaItens[intCnt].Acessorio.Descricao);
          FSlMensagemTrava.Add('Status atual: ' + fObtemDescricaoSitEquipamentoLocacao(FListaItens[intCnt].Acessorio.Status));
        End
        Else
        If Not FListaItens[intCnt].Acessorio.blnCodigoItemValido Then
        Begin
          FSlMensagemTrava.Add('');
          FSlMensagemTrava.Add('O produto vinculado ao acessório do equipamento está com um status que não permite a contratação do mesmo. Verifique o cadastro do  ' +
                              ' equipamento e depois, tente novamente. ');
          FSlMensagemTrava.Add('');
          FSlMensagemTrava.Add('Produto: '+ FListaItens[intCnt].Acessorio.CodigoItem  + ' - ' + FListaItens[intCnt].Acessorio.DescricaoItem);
        End;
        FSlMensagemTrava.Add('');
        FSlMensagemTrava.Add('Status que impedem a contratação: ' + FMensagem);

        Break;
      End;
    End;
  End
  Else
  Begin
    FBlnTrv := True;
    FMensagem := FSlMensagemTrava.Text;
    FSlMensagemTrava.Clear;
    FSlMensagemTrava.Add('O produto vinculado ao equipamento está com um status que não permite a contratação do mesmo. Verifique o cadastro do  ' +
                         ' equipamento e depois, tente novamente. ');
    FSlMensagemTrava.Add('');
    FSlMensagemTrava.Add('Produto: '+ FCodIte + ' - ' + FDesIte);
    FSlMensagemTrava.Add('Status atual: ' + fObtemDescricaoSitEquipamentoLocacao(FStatus));
    FSlMensagemTrava.Add('');
    FSlMensagemTrava.Add('Status que impedem a contratação: ');
    FSlMensagemTrava.Add(FMensagem);

    Result := False;
  End;

end;

function TEquipamentoLocacaoPrincipal.fValidarItemAssociadoEquipamento(
  const strCodIte: String): Boolean;
var
  SQLSelectEql: String;
  SQLSelectAcl: String;
  qryConsulta: TUniQuery;
begin

  SQLSelectEql := 'SELECT EQL_CODITE,    ' +
                  '       EQL_CODIGO,    ' +
                  '       EQL_DESCRI,    ' +
                  '       I.ITE_CODITE,  ' +
                  '       I.ITE_DESITE   ' +
                  'FROM CADEQL           ' +
                  ' INNER JOIN CADITE I ON (I.ITE_CODITE = EQL_CODITE)    ' +
                  ' INNER JOIN ITEGER G ON (I.ITE_CODITE = G.ITE_CODITE ) ' +
                  '   WHERE EQL_CODITE = :EQL_CODITE  ';
  If Not fEmptyStr(FCodigo) Then
    SQLSelectEql := SQLSelectEql +  '   AND   EQL_CODIGO <> :EQL_CODIGO ';

  SQLSelectAcl := 'SELECT ACL_CODITE,    ' +
                  '       ACL_CODIGO,    ' +
                  '       ACL_DESCRI,    ' +
                  '       I.ITE_CODITE,  ' +
                  '       I.ITE_DESITE   ' +
                  'FROM CADACL           ' +
                  ' INNER JOIN CADITE I ON (I.ITE_CODITE = ACL_CODITE)    ' +
                  ' INNER JOIN ITEGER G ON (I.ITE_CODITE = G.ITE_CODITE ) ' +
                  '   WHERE ACL_CODITE = :EQL_CODITE ';

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelectEql);
    qryConsulta.ParamByName('EQL_CODITE').AsString := strCodIte;
    If Not fEmptyStr(FCodigo) Then
      qryConsulta.ParamByName('EQL_CODIGO').AsString := FCodigo;
    qryConsulta.Open;

    Result := qryConsulta.IsEmpty;
    If Result Then
    Begin
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add(SQLSelectAcl);
      qryConsulta.ParamByName('EQL_CODITE').AsString := strCodIte;
      qryConsulta.Open;

      Result := qryConsulta.IsEmpty;

      If Not Result Then
        FMensagem := 'O item "' + qryConsulta.FieldByName('ITE_CODITE').AsString + ' - ' + qryConsulta.FieldByName('ITE_DESITE').AsString + '"' +
                     ' já está associado ao acessório "' + qryConsulta.FieldByName('ACL_CODIGO').AsString + ' - ' + qryConsulta.FieldByName('ACL_DESCRI').AsString + '". ' +
                     'Não é permitido associar o mesmo item em dois equipamentos diferentes!';
    End
    Else
    Begin
      FMensagem := 'O item "' + qryConsulta.FieldByName('ITE_CODITE').AsString + ' - ' + qryConsulta.FieldByName('ITE_DESITE').AsString + '"' +
                   ' já está associado ao equipamento "' + qryConsulta.FieldByName('EQL_CODIGO').AsString + ' - ' + qryConsulta.FieldByName('EQL_DESCRI').AsString + '". ' +
                   'Não é permitido associar o mesmo item em dois equipamentos diferentes!';
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

function TEquipamentoLocacaoPrincipal.fValidarItemEhEquipamentoLocacao(
  const strImpLst, strRealoc, strTipLoc: String; blnListarTodos: Boolean): Boolean;
begin
  Result := True;

  If strImpLst = 'N' Then
  Begin
    Result := False;
    FBlnTrv := True;
    FMensagem := 'Este item setá setado como "Imprime Lista = Não" e não pode ser vinculado ao equipamento."';
    FSlMensagemTrava.Add(FMensagem);
    FSlMensagemTrava.Add('');
    If Not blnListarTodos Then
      Exit;
  End;

  If Not (strRealoc = 'S') Then
  Begin
    Result := False;
    FBlnTrv := True;
    FMensagem := 'Este item está configurado em seu cadastro para não realizar locação e por isto, não pode ser vinculado ao equipamento."';
    FSlMensagemTrava.Add(FMensagem);
    FSlMensagemTrava.Add('');
    If Not blnListarTodos Then
      Exit;
  End;

  If strTipLoc = 'A' Then
  Begin
    Result := False;
    FBlnTrv := True;
    FMensagem := 'Este item está configurado em seu cadastro como produto acessório para locação e não como um produto principal. '+
                 'Sendo assim, não é permitido vincular o item ao cadastro. Se for necessário, realize o ajuste e depois tente novamente.';
    FSlMensagemTrava.Add(FMensagem);
    FSlMensagemTrava.Add('');
    If Not blnListarTodos Then
      Exit;
  End;
end;

function TEquipamentoLocacaoPrincipal.fValorDescontoMaximo(
  const intNlv: Integer): Double;
begin
  Case intNlv Of
    1 : Result := FDscVen;
    2 : Result := FDscSGe;
    3 : Result := FDscGer
    Else
      Result := FDscGer;
  End;
end;

function TEquipamentoLocacaoPrincipal.fValidaItemLocacao(strCodIte: String; blnListarTodos: Boolean = False): Boolean;
var
  qryConsulta: TUniQuery;
begin
  Result := True;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    Try
      qryConsulta.SQL.Add('SELECT I.ITE_TIPLOC, I.ITE_REALOC, I.ITE_ITEATI, G.ITE_IMPLIS,');
      qryConsulta.SQL.Add('       I.ITE_CODITE, I.ITE_DESITE   ');
      qryConsulta.SQL.Add('  FROM CADITE I                     ');
      qryConsulta.SQL.Add('   INNER JOIN ITEGER G              ');
      qryConsulta.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE ');
      qryConsulta.SQL.Add(' WHERE I.ITE_CODITE = :CODITE');
      qryConsulta.SQL.Add('   AND G.ITE_CODEMP = :CODEMP');
      qryConsulta.ParamByName('CODITE').AsString := strCodIte;
      qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryConsulta.Open;

      If (qryConsulta.isEmpty) Then
      Begin
        Result := False;
        FMensagem := 'Item não localizado.';
        Exit;
      End;

      If qryConsulta.FieldByName('ITE_ITEATI').AsString = 'N' Then
      Begin
        FBlnTrv := True;
        Result := False;
        FMensagem := 'Este item está inativo e não pode ser vinculado ao equipamento.';
        FSlMensagemTrava.Add(FMensagem);
        FSlMensagemTrava.Add('');
        If Not blnListarTodos Then
          Exit;
      End;

      If Not fValidarItemEhEquipamentoLocacao(qryConsulta.FieldByName('ITE_IMPLIS').AsString,
                                              qryConsulta.FieldByName('ITE_REALOC').AsString,
                                              qryConsulta.FieldByName('ITE_TIPLOC').AsString,
                                              blnListarTodos) Then
      Begin
        Result := False;
        FBlnTrv := True;
        If Not blnListarTodos Then
          Exit;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fValidaItemEquipamentoLocacao]');
        Result := False;
      End;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End
end;

function TEquipamentoLocacaoPrincipal.fValidarDiariaNegociacao(const aQtdDia: Integer): Boolean;
var
  intCnt: Integer;
begin
  Result := True;
  For intCnt := 0 to FListaDiarias.Count -1 Do
  Begin
    If FListaDiarias[intCnt].QuantidadeDias = (aQtdDia) Then
    Begin
      FMensagem := 'O número de dias foi informado para negociação já foi informado. Verifique!';
      Result := False;
      Break;
    End;
  End;
end;

function TEquipamentoLocacaoPrincipal.fVerificaAcessorio(const aCodAcl: string): Boolean;
var
  intCnt: Integer;
begin
  Result := True;
  For intCnt := 0 to  FListaItens.Count -1 Do
  Begin
    If FListaItens[intCnt].Acessorio.Codigo = (aCodAcl) Then
    Begin
      FMensagem := 'Acessório já foi informado para este equipamento. Verifique!';
      Result := False;
      Break;
    End;
  End;
end;

{ TEquipamentoItemAcessorio }

constructor TEquipamentoItemAcessorio.Create(Owner: TEquipamentoLocacaoPrincipal);
begin
  FEqlLoc := Owner;
  FAclLoc := TEquipamentoLocacaoAcessorio.Create;

  FqryInsert := fCriaQuery;
  FqryInsert.DisableControls;

  FqryDelete := fCriaQuery;
  FqryDelete.DisableControls;
end;

destructor TEquipamentoItemAcessorio.Destroy;
begin
  FreeAndNil(FAclLoc);
  FreeAndNil(FqryInsert);
  FreeAndNil(FqryDelete);

  inherited;
end;

function TEquipamentoItemAcessorio.fExcluir: Boolean;
begin
  Try
    Try
      FqryDelete.SQL.Clear;
      FqryDelete.SQL.Add('DELETE FROM EQUACL WHERE AUTOINCREM = :AUTOINCREM');
      FqryDelete.ParamByName('AUTOINCREM').AsString := FAutInc;
      FqryDelete.ExecSQL;

      Result := True;
    Except
      Result := False;
    End;
  Finally
    FqryDelete.Close;
  End;
end;

function TEquipamentoItemAcessorio.fInserir: Boolean;
begin
  Try
    Try
      FAutInc := fRetAutoIncrem('EQUACL', VS_strCodEmp);
      FCodigo := fAtualizaProCod('EQUACL', 'EQA_CODIGO');

      FqryInsert.SQL.Add('INSERT INTO EQUACL (AUTOINCREM, EQA_CODIGO, EQA_CODACL, EQA_QTDACL, EQA_CODEQU, EQA_SEQEQU, EQA_SEQACL, EQA_VLRADC)' +
                        'VALUES (:AUTOINCREM, :EQA_CODIGO, :EQA_CODACL, :EQA_QTDACL, :EQA_CODEQU, :EQA_SEQEQU, :EQA_SEQACL, :EQA_VLRADC)');
      FqryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
      FqryInsert.ParamByName('EQA_CODIGO').AsString := FCodigo;
      FqryInsert.ParamByName('EQA_CODEQU').AsString := FEqlLoc.Codigo;
      FqryInsert.ParamByName('EQA_CODACL').AsString := FAclLoc.Codigo;
      FqryInsert.ParamByName('EQA_QTDACL').AsFloat  := FQtdAcl;
      FqryInsert.ParamByName('EQA_SEQEQU').AsString := FEqlLoc.AutInc;
      FqryInsert.ParamByName('EQA_SEQACL').AsString := FAclLoc.AutInc;
      FqryInsert.ParamByName('EQA_VLRADC').AsFloat  := FVlrAdc;

      FqryInsert.ExecSQL;
      Result := True;
    Except
      Result := False;
    End;
  Finally
    FqryInsert.Close;
  End;
end;

function TEquipamentoItemAcessorio.GetAclLoc: TEquipamentoLocacaoAcessorio;
begin
  Result := FAclLoc;
end;

function TEquipamentoItemAcessorio.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TEquipamentoItemAcessorio.GetCodigo: String;
begin
  Result := FCodigo;
end;

function TEquipamentoItemAcessorio.GetEqlLoc: TEquipamentoLocacaoPrincipal;
begin
  Result := FEqlLoc;
end;

function TEquipamentoItemAcessorio.GetQtdAcl: Double;
begin
  Result := FQtdAcl;
end;

function TEquipamentoItemAcessorio.GetVlrAdc: Double;
begin
  Result := FVlrAdc;
end;

procedure TEquipamentoItemAcessorio.SetAclLoc(
  const AValue: TEquipamentoLocacaoAcessorio);
begin
  FAclLoc := AValue;
end;

procedure TEquipamentoItemAcessorio.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TEquipamentoItemAcessorio.SetCodigo(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TEquipamentoItemAcessorio.SetEqlLoc(
  const AValue: TEquipamentoLocacaoPrincipal);
begin
  FEqlLoc := AValue;
end;

procedure TEquipamentoItemAcessorio.SetQtdAcl(const AValue: Double);
begin
  FQtdAcl := AValue;
end;

procedure TEquipamentoItemAcessorio.SetVlrAdc(const AValue: Double);
begin
  FVlrAdc := AValue;
end;

{ TNegociacaoDiaria }

constructor TNegociacaoDiaria.Create(Owner: TEquipamentoLocacaoPrincipal);
begin
  FEqlLoc := Owner;

  FqryInsert := fCriaQuery;
  FqryInsert.DisableControls;

  FqryDelete := fCriaQuery;
  FqryDelete.DisableControls;
end;

destructor TNegociacaoDiaria.Destroy;
begin

  inherited;
end;

function TNegociacaoDiaria.fExcluir: Boolean;
begin
  Try
    FqryDelete.SQL.Clear;
    FqryDelete.SQL.Add('DELETE FROM EQUNGD WHERE AUTOINCREM = :AUTOINCREM');
    FqryDelete.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryDelete.ExecSQL;

    Result := True;
  Finally
    FqryDelete.Close;
  End;
end;

function TNegociacaoDiaria.fInserir: Boolean;
Begin
  Try
    FAutInc := fRetAutoIncrem('EQUNGD', VS_strCodEmp);
    FCodigo := fAtualizaProCod('EQUNGD', 'EQN_CODIGO');

    FqryInsert.SQL.Clear;
    FqryInsert.SQL.Add('INSERT INTO EQUNGD (AUTOINCREM, EQN_CODIGO, EQN_CODEQU, EQN_QTDDIA, EQN_VLRDIA, EQN_VLRTOT, EQN_SEQEQU)' +
                     'VALUES (:AUTOINCREM, :EQN_CODIGO, :EQN_CODEQU, :EQN_QTDDIA, :EQN_VLRDIA, :EQN_VLRTOT, :EQN_SEQEQU)');
    FqryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryInsert.ParamByName('EQN_CODIGO').AsString := FCodigo;
    FqryInsert.ParamByName('EQN_CODEQU').AsString := FEqlLoc.Codigo;
    FqryInsert.ParamByName('EQN_SEQEQU').AsString := FEqlLoc.AutInc;
    FqryInsert.ParamByName('EQN_QTDDIA').AsInteger:= FQtdDia;
    FqryInsert.ParamByName('EQN_VLRDIA').AsFloat  := FVlrDia;
    FqryInsert.ParamByName('EQN_VLRTOT').AsFloat  := FVlrTot;

    FqryInsert.ExecSQL;
    Result := True;
  Finally
    FqryInsert.Close;
  End;
End;

function TNegociacaoDiaria.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TNegociacaoDiaria.GetCodigo: String;
begin
  Result := FCodigo;
end;

function TNegociacaoDiaria.GetQtdDia: Integer;
begin
  Result := FQtdDia;
end;

function TNegociacaoDiaria.GetVlrDia: Double;
begin
  Result := FVlrDia;
end;

function TNegociacaoDiaria.GetVlrTot: Double;
begin
  Result := FVlrTot;
end;

procedure TNegociacaoDiaria.pAdicionaValorDiaria(const aQtdDia: Integer;
  const aVlrTot: Double);
begin
  FVlrTot := aVlrTot;
  FQtdDia := aQtdDia;
  FVlrDia := FVlrTot / FQtdDia;
end;

procedure TNegociacaoDiaria.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TNegociacaoDiaria.SetCodigo(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TNegociacaoDiaria.SetQtdDia(const AValue: Integer);
begin
  FQtdDia := AValue;
end;

procedure TNegociacaoDiaria.SetVlrDia(const AValue: Double);
begin
  FVlrDia := AValue;
end;

procedure TNegociacaoDiaria.SetVlrTot(const AValue: Double);
begin
  FVlrTot := AValue;
end;

{ THerancaCadEquLoc }

constructor THerancaCadEquLoc.Create;
begin
  FobjEqu := TEquipamentoLocacaoPrincipal.Create;
end;

destructor THerancaCadEquLoc.Destroy;
begin
  FreeAndNil(FobjEqu);

  inherited;
end;

function THerancaCadEquLoc.fHerdarCadEquLoc(const strCodEqu: String): Boolean;
begin
  If fEmptyStr(strCodEqu) Then
    Exit(False);

  Try
    FobjEqu.pCarregaEquipamento('', strCodEqu);
    FobjEqu.NumSerie := EmptyStr;
    FobjEqu.DataVenda := 0;
    FobjEqu.Codigo := EmptyStr;
    FobjEqu.AutInc := EmptyStr;

    Result := True;
  Except
    Result := False;
  End;
end;

function THerancaCadEquLoc.getObjEqu: TEquipamentoLocacaoPrincipal;
begin
  Result := FobjEqu;
end;

end.
