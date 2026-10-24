unit untOcorrenciaCRM;

interface

uses
  System.Classes,
  System.strUtils,
  SysUtils,
  untTypesCRM,
  untIFuncoesCRM,
  untAtualizaOcorrenciasCRM,
  ImportacaoDados.Controller.Prospecto,
  Uni;
type

  IOcorrenciaCRM = Interface
  ['{57D8910A-E8EC-43B9-8B6B-6B83B1F60D5A}']
    function AutInc: String;
    function CodOco(const AValue: String): IOcorrenciaCRM;
    function CodEmp(const AValue: String): IOcorrenciaCRM;
    function CodToc(const AValue: String): IOcorrenciaCRM;
    function CodCli(const AValue: String): IOcorrenciaCRM;
    function CodCoc(const AValue: String): IOcorrenciaCRM;
    function OpeOco(const AValue: String): IOcorrenciaCRM;
    function CodOpe(const AValue: String): IOcorrenciaCRM;
    function Descri(const AValue: String): IOcorrenciaCRM;
    function Tip_FC(const AValue: String): IOcorrenciaCRM;
    function CodSit(const AValue: String): IOcorrenciaCRM;
    function DtaAge(const AValue: TDateTime): IOcorrenciaCRM;
    function HraAge(const AValue: TDateTime): IOcorrenciaCRM;
    function CodAca(const AValue: String): IOcorrenciaCRM;
    function EspPcg(const AValue: String): IOcorrenciaCRM;
    function NumCot(const AValue: String): IOcorrenciaCRM;
    function SeqLag(const AValue: String): IOcorrenciaCRM;
    function strCpf(const AValue: String): IOcorrenciaCRM;
    function Parcel(const AValue: String): IOcorrenciaCRM;
    function Serie_(const AValue: String): IOcorrenciaCRM;
    function NumDoc(const AValue: String): IOcorrenciaCRM;
    function EspDoc(const AValue: String): IOcorrenciaCRM;
    function OpeHis(const AValue: String): IOcorrenciaCRM;
    function ArqDev(const AValue: String): IOcorrenciaCRM;
    function blnEnvCli(const AValue: Boolean): IOcorrenciaCRM;
    function blnEnvUsu(const AValue: Boolean): IOcorrenciaCRM;
    function MailDescri(const AValue: String): IOcorrenciaCRM;
    function MailCli(const AValue: String): IOcorrenciaCRM;
    function MailUsu(const AValue: String): IOcorrenciaCRM;
    function CodGoc(const AValue: String): IOcorrenciaCRM;
    function NomFrm(const AValue: String): IOcorrenciaCRM;
    function CodMotFinOco(const AValue: String): IOcorrenciaCRM;
    function AcaFat(const AValue: TAcaoFatCRM): IOcorrenciaCRM;
    function blnImpSfa(const AValue: Boolean): IOcorrenciaCRM;
    function DtaInc(const AValue: TDateTime): IOcorrenciaCRM;
    function HraInc(const AValue: TDateTime): IOcorrenciaCRM;
    function Assunt(const AValue: String): IOcorrenciaCRM;

    procedure pSetAtuOcoCRMInterno;
    procedure pInserirOcorrenciaRecorrente;
    procedure pEnviarEmailSemPerguntar(const srtTitulo: String);
    procedure pProcessarOcorrencia(const objAtuCrm: TAtuOcoCrm = Nil);
    procedure pInserirOcorrencia;
    procedure pCarregarOcorrenciaInterna; overload;
    procedure pFinalizarOcorrencia(const strObs, strCodOpe: String);
    procedure pReabreOcorrencia;
    procedure pExecutarAposProcessamentoOco;

    function fCarregarOcorrenciaCod(const strTip_FC: String; strCodOco: String; strCodEmp: String): IOcorrenciaCRM;
  end;

  TOcorrenciaCRM = class (TInterfacedObject, IOcorrenciaCRM)
  protected
    FAcaFat: TAcaoFatCRM;
    FObjAtuOcoCRM: TAtuOcoCrm;
    FObjProspectoCtr: TProspectoController;
    FCodOco: String;
    FAutInc: String;
    FCodEmp: String;
    FCodToc: String;
    FCodCli: String;
    FCodCoc: String;
    FOpeOco: String;
    FCodOpe: String;
    FDescri: String;
    FProtoc: String;
    FEmerge: String;
    FAgeCom: String;
    FTip_FC: String;
    FCodSit: String;
    FDtaAge: TDateTime;
    FHraAge: TDateTime;
    FCodAca: String;
    FEspPcg: String;
    FNumCot: String;
    FSeqLag: String;
    FstrCpf: String;
    FParcel: String;
    FSerie_: String;
    FNumDoc: String;
    FEspDoc: String;
    FOpeHis: String;
    FBlnEnvUsu: Boolean;
    FBlnEnvCli: Boolean;
    FArqDev: String;
    FMailDe: String;
    FMailCli: String;
    FMailUsu: String;
    FNomCli: String;
    FCodGoc: String;
    FDesGoc: String;
    FNomFrm: String;
    FCodMotFinOco: String;
    FblnImpSfa: Boolean;
    FDtaInc: TDateTime;
    FHraInc: TDateTime;
    FAssunt: String;
  private
    procedure pSetAtuOcoCRMInterno;
    procedure pCarregarOcorrenciaInterna; overload;
    procedure pExecutarAposProcessamentoOco; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;

    function AutInc: String;
    function CodOco(const AValue: String): IOcorrenciaCRM;
    function CodEmp(const AValue: String): IOcorrenciaCRM;
    function CodToc(const AValue: String): IOcorrenciaCRM;
    function CodCli(const AValue: String): IOcorrenciaCRM;
    function CodCoc(const AValue: String): IOcorrenciaCRM;
    function OpeOco(const AValue: String): IOcorrenciaCRM;
    function CodOpe(const AValue: String): IOcorrenciaCRM;
    function Descri(const AValue: String): IOcorrenciaCRM;
    function Protoc(const AValue: String): IOcorrenciaCRM;
    function Emerge(const AValue: String): IOcorrenciaCRM;
    function AgeCom(const AValue: String): IOcorrenciaCRM;
    function Tip_FC(const AValue: String): IOcorrenciaCRM;
    function CodSit(const AValue: String): IOcorrenciaCRM;
    function DtaAge(const AValue: TDateTime): IOcorrenciaCRM;
    function HraAge(const AValue: TDateTime): IOcorrenciaCRM;
    function CodAca(const AValue: String): IOcorrenciaCRM;
    function EspPcg(const AValue: String): IOcorrenciaCRM;
    function NumCot(const AValue: String): IOcorrenciaCRM;
    function SeqLag(const AValue: String): IOcorrenciaCRM;
    function strCpf(const AValue: String): IOcorrenciaCRM;
    function Parcel(const AValue: String): IOcorrenciaCRM;
    function Serie_(const AValue: String): IOcorrenciaCRM;
    function NumDoc(const AValue: String): IOcorrenciaCRM;
    function EspDoc(const AValue: String): IOcorrenciaCRM;
    function OpeHis(const AValue: String): IOcorrenciaCRM;
    function ArqDev(const AValue: String): IOcorrenciaCRM;
    function blnEnvCli(const AValue: Boolean): IOcorrenciaCRM;
    function blnEnvUsu(const AValue: Boolean): IOcorrenciaCRM;
    function MailDescri(const AValue: String): IOcorrenciaCRM;
    function MailCli(const AValue: String): IOcorrenciaCRM;
    function MailUsu(const AValue: String): IOcorrenciaCRM;
    function CodGoc(const AValue: String): IOcorrenciaCRM;
    function NomFrm(const AValue: String): IOcorrenciaCRM;
    function CodMotFinOco(const AValue: String): IOcorrenciaCRM;
    function AcaFat(const AValue: TAcaoFatCRM): IOcorrenciaCRM;
    function blnImpSfa(const AValue: Boolean): IOcorrenciaCRM;
    function DtaInc(const AValue: TDateTime): IOcorrenciaCRM;
    function HraInc(const AValue: TDateTime): IOcorrenciaCRM;
    function Assunt(const AValue: String): IOcorrenciaCRM;

    procedure pLimpar;
    procedure pInserirOcorrenciaRecorrente;
    procedure pEnviarEmailSemPerguntar(const srtTitulo: String);
    procedure pProcessarOcorrencia(const objAtuCrm: TAtuOcoCrm = Nil); virtual;
    procedure pInserirOcorrencia; virtual;
    procedure pFinalizarOcorrencia(const strObs, strCodOpe: String); virtual;
    procedure pReabreOcorrencia;

    function fCarregarOcorrenciaCod(const strTip_FC: String; strCodOco: String; strCodEmp: String): IOcorrenciaCRM;
    class function fNew: IOcorrenciaCRM; virtual; abstract;
  End;

  TAtuOcoCrmRecorrente = class (TOcorrenciaCRM)
  private
    procedure pExecutarAposProcessamentoOco; override;
  public
    constructor Create;

    procedure pEnviarEmailSemPerguntar(const srtTitulo: String);

    class function fNew: IOcorrenciaCRM; override;
  End;

  TAtuOcoCrmCliente = class (TOcorrenciaCRM)
  protected
    constructor Create;
  private
    function fRetornaCodProspecto(const strCodCli: String): String;
    procedure pExecutarAposProcessamentoOco; override;
  public
    class function fNew: IOcorrenciaCRM; override;
  End;

  TAtuOcoCrmProspecto = class (TOcorrenciaCRM)
  protected
    constructor Create;
  private
    procedure pGravarLogAlteraCategoria(const strCodCrmAnt, strCatCrmPro: String);
    procedure pAtualizarCadastroProspectoPeloCompl;
    procedure pAtualizarProspectoFinalizacaoOcorrencia;
    procedure pAtualizarCategoriaProspecto(const strCatAtu: String);
  public
    procedure pProcessarOcorrencia(const objAtuCrm: TAtuOcoCrm = Nil); override;
    procedure pExecutarAposProcessamentoOco; override;
    procedure pFinalizarOcorrencia(const strObs, strCodOpe: String); override;

    class function fNew: IOcorrenciaCRM; override;
  End;

  TAtuOcoCrmFornecedor = class (TOcorrenciaCRM)
  protected
    constructor Create;
  private
    procedure pExecutarAposProcessamentoOco; override;
  public
    class function fNew: IOcorrenciaCRM; override;
  End;

implementation

uses
  untFuncoesSimples, untTypesSistema, untTEnvioEmail, untFuncoesCRM,
  untProximoCodigo;

{ TOcorrenciaCRM }

function TOcorrenciaCRM.AcaFat(const AValue: TAcaoFatCRM): IOcorrenciaCRM;
begin
  FAcaFat := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.AgeCom(
  const AValue: String): IOcorrenciaCRM;
begin
  FAgeCom := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.ArqDev(const AValue: String): IOcorrenciaCRM;
begin
  FArqDev := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.Assunt(const AValue: String): IOcorrenciaCRM;
begin
  FAssunt := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.AutInc: String;
begin
  Result := FAutInc;
end;

function TOcorrenciaCRM.blnEnvCli(const AValue: Boolean): IOcorrenciaCRM;
begin
  FBlnEnvCli := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.blnEnvUsu(const AValue: Boolean): IOcorrenciaCRM;
begin
  FBlnEnvUsu := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.blnImpSfa(const AValue: Boolean): IOcorrenciaCRM;
begin
  FblnImpSfa := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodAca(
  const AValue: String): IOcorrenciaCRM;
begin
  FCodAca := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodCli(
  const AValue: String): IOcorrenciaCRM;
begin
  FCodCli := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodCoc(
  const AValue: String): IOcorrenciaCRM;
begin
  FCodCoc := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodEmp(
  const AValue: String): IOcorrenciaCRM;
begin
  FCodEmp := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodGoc(const AValue: String): IOcorrenciaCRM;
begin
  FCodGoc := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodMotFinOco(const AValue: String): IOcorrenciaCRM;
begin
  FCodMotFinOco := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodOco(const AValue: String): IOcorrenciaCRM;
begin
  FCodOco := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodOpe(
  const AValue: String): IOcorrenciaCRM;
begin
  FCodOpe := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodSit(
  const AValue: String): IOcorrenciaCRM;
begin
  FCodSit := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.CodToc(
  const AValue: String): IOcorrenciaCRM;
begin
  FCodToc := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.Descri(
  const AValue: String): IOcorrenciaCRM;
begin
  FDescri := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.DtaAge(
  const AValue: TDateTime): IOcorrenciaCRM;
begin
  FDtaAge := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.DtaInc(const AValue: TDateTime): IOcorrenciaCRM;
begin
  FDtaInc := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.Emerge(
  const AValue: String): IOcorrenciaCRM;
begin
  FEmerge := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.EspDoc(
  const AValue: String): IOcorrenciaCRM;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.EspPcg(
  const AValue: String): IOcorrenciaCRM;
begin
  FEspPcg := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.HraAge(
  const AValue: TDateTime): IOcorrenciaCRM;
begin
  FHraAge := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.HraInc(const AValue: TDateTime): IOcorrenciaCRM;
begin
  FHraInc := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.MailCli(const AValue: String): IOcorrenciaCRM;
begin
  FMailCli := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.MailDescri(const AValue: String): IOcorrenciaCRM;
begin
  FMailDe := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.MailUsu(const AValue: String): IOcorrenciaCRM;
begin
  FMailUsu := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.NomFrm(const AValue: String): IOcorrenciaCRM;
begin
  FNomFrm := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.NumCot(
  const AValue: String): IOcorrenciaCRM;
begin
  FNumCot := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.NumDoc(
  const AValue: String): IOcorrenciaCRM;
begin
  FNumDoc := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.OpeHis(const AValue: String): IOcorrenciaCRM;
begin
  FOpeHis := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.OpeOco(
  const AValue: String): IOcorrenciaCRM;
begin
  FOpeOco := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.Parcel(
  const AValue: String): IOcorrenciaCRM;
begin
  FParcel := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.Protoc(
  const AValue: String): IOcorrenciaCRM;
begin
  FProtoc := AValue;
  Result := Self;
end;

procedure TOcorrenciaCRM.pSetAtuOcoCRMInterno;
begin
  FObjAtuOcoCRM.afcAcaFat := IIF(FAcaFat <> FObjAtuOcoCRM.afcAcaFat, FAcaFat, FObjAtuOcoCRM.afcAcaFat);
  FObjAtuOcoCRM.strAutInc := IIF(Not fEmptyStr(FAutInc), FAutInc, FObjAtuOcoCRM.strAutInc);
  FObjAtuOcoCRM.strCodOco := IIF(Not fEmptyStr(FCodOco), FCodOco, FObjAtuOcoCRM.strCodOco);
  FObjAtuOcoCRM.strCodEmp := IIF(Not fEmptyStr(FCodEmp), FCodEmp, FObjAtuOcoCRM.strCodEmp);
  FObjAtuOcoCRM.strCodToc := IIF(Not fEmptyStr(FCodToc), FCodToc, FObjAtuOcoCRM.strCodToc);
  FObjAtuOcoCRM.strCodCli := IIF(Not fEmptyStr(FCodCli), FCodCli, FObjAtuOcoCRM.strCodCli);
  FObjAtuOcoCRM.strCodCoc := IIF(Not fEmptyStr(FCodCoc), FCodCoc, FObjAtuOcoCRM.strCodCoc);
  FObjAtuOcoCRM.strCodOpe := IIF(Not fEmptyStr(FCodOpe), FCodOpe, FObjAtuOcoCRM.strCodOpe);
  FObjAtuOcoCRM.strDescri := IIF(Not fEmptyStr(FDescri), FDescri, FObjAtuOcoCRM.strDescri);
  FObjAtuOcoCRM.strTip_FC := IIF(Not fEmptyStr(FTip_FC), FTip_FC, FObjAtuOcoCRM.strTip_FC);
  FObjAtuOcoCRM.strCodSit := IIF(Not fEmptyStr(FCodSit), FCodSit, FObjAtuOcoCRM.strCodSit);
  FObjAtuOcoCRM.strDtaAge := IIF(FDtaAge > 0, FDtaAge, FObjAtuOcoCRM.strDtaAge);
  FObjAtuOcoCRM.strHorAge := IIF(FHraAge > 0, FHraAge, FObjAtuOcoCRM.strHorAge);
  FObjAtuOcoCRM.strCodAca := IIF(Not fEmptyStr(FCodAca), FCodAca, FObjAtuOcoCRM.strCodAca);
  FObjAtuOcoCRM.strNumDoc := IIF(Not fEmptyStr(FNumDoc), FNumDoc, FObjAtuOcoCRM.strNumDoc);
  FObjAtuOcoCRM.strEspDoc := IIF(Not fEmptyStr(FEspDoc), FEspDoc, FObjAtuOcoCRM.strEspDoc);
  FObjAtuOcoCRM.strSeqLag := IIF(Not fEmptyStr(FSeqLag), FSeqLag, FObjAtuOcoCRM.strSeqLag);
  FObjAtuOcoCRM.strCpfCli := IIF(Not fEmptyStr(FstrCpf), FstrCpf, FObjAtuOcoCRM.strCpfCli);
  FObjAtuOcoCRM.strParcel := IIF(Not fEmptyStr(FParcel), FParcel, FObjAtuOcoCRM.strParcel);
  FObjAtuOcoCRM.strOpeHis := IIF(Not fEmptyStr(FOpeHis), FOpeHis, FObjAtuOcoCRM.strOpeHis);
  FObjAtuOcoCRM.strArqDev := IIF(Not fEmptyStr(FArqDev), FArqDev, FObjAtuOcoCRM.strArqDev);
  FObjAtuOcoCRM.strCodGoc := IIF(Not fEmptyStr(FCodGoc), FCodGoc, FObjAtuOcoCRM.strCodGoc);
  FObjAtuOcoCRM.strAssunto := IIF(Not fEmptyStr(FAssunt), FAssunt, FObjAtuOcoCRM.strAssunto);

  FObjAtuOcoCRM.blnEnvCli := FBlnEnvCli;
  FObjAtuOcoCRM.blnEnvUsu := FBlnEnvUsu;
  FObjAtuOcoCRM.strEmailDesci := FMailDe;
  FObjAtuOcoCRM.strEmailCli := FMailCli;
  FObjAtuOcoCRM.strEmailUsu := FMailUsu;
  FObjAtuOcoCRM.strNomFrm := FNomFrm;
  FDesGoc := fRetDescGoc(FCodGoc);
  If FTip_Fc = 'P' Then
    FNomCli := fRetNomProspectoATIVO(FCodCli)
  Else
  If FTip_Fc = 'F' Then
    FNomCli := fRetNomCliente(FCodCli)
  Else
    FNomCli := fRetNomFornecedor(FCodCli);
  FObjAtuOcoCRM.strNomCli := FNomCli;
  FObjAtuOcoCRM.blnImpSfa := FblnImpSfa;
  FObjAtuOcoCRM.strDtaInc := FDtaInc;
  FObjAtuOcoCRM.strHorInc := FHraInc;
end;

function TOcorrenciaCRM.SeqLag(
  const AValue: String): IOcorrenciaCRM;
begin
  FSeqLag := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.Serie_(
  const AValue: String): IOcorrenciaCRM;
begin
  FSerie_ := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.strCpf(
  const AValue: String): IOcorrenciaCRM;
begin
  FstrCpf := AValue;
  Result := Self;
end;

function TOcorrenciaCRM.Tip_FC(
  const AValue: String): IOcorrenciaCRM;
begin
  FTip_FC := AValue;
  Result := Self;
end;

constructor TOcorrenciaCRM.Create;
begin
  FObjAtuOcoCRM := TAtuOcoCrm.Create(Nil);
  FObjProspectoCtr := TProspectoController.Create;
end;

destructor TOcorrenciaCRM.Destroy;
begin

  inherited;

  If Assigned(FObjAtuOcoCRM) Then
    FreeAndNil(FObjAtuOcoCRM);

  If Assigned(FObjProspectoCtr) Then
    FreeAndNil(FObjProspectoCtr);
end;

procedure TOcorrenciaCRM.pInserirOcorrencia;
begin
  pSetAtuOcoCRMInterno;
  FObjAtuOcoCRM.pInsereNovaOcorrencia;
end;

procedure TOcorrenciaCRM.pInserirOcorrenciaRecorrente;
var
  blnComita: Boolean;
Begin
  blnComita := false;
  FCodOco := fGetProximoCodigoEmTransacao('MOVOCO', 'OCO_CODOCO');
  FAutInc := fRetAutoIncrem('MOVOCO', VS_strCodEmp);
  FOpeHis := strLoginUsuarioLogado;
  FObjAtuOcoCRM.strDtaInc := VS_Date;
  FObjAtuOcoCRM.strHorInc := fNow();
  pSetAtuOcoCRMInterno;

  Try
    If (not fInTransaction) Then
    Begin
      fStartTransaction;
      blnComita := true;
    End;

    FObjAtuOcoCRM.pInsereNovaOcorrencia(True);
    FObjAtuOcoCRM.pGravarMensagemOperadorOcorrencia(tpInclusao, FCodOco, FCodEmp, FTip_Fc);

    If FBlnEnvCli or FBlnEnvUsu Then
      pEnviarEmailSemPerguntar('Nova ocorrência CRM ');

    If blnComita Then
      fCommit;

  Except
    On E: Exception Do
    Begin
      If blnComita Then
      Begin
        fRollBack;
      End;

      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TOcorrenciaCRM.pLimpar;
begin
  FAcaFat := afcNenhum;
  FCodOco := '';
  FAutInc := '';
  FCodEmp := '';
  FCodToc := '';
  FCodCli := '';
  FCodCoc := '';
  FOpeOco := '';
  FCodOpe := '';
  FDescri := '';
  FProtoc := '';
  FEmerge := '';
  FAgeCom := '';
  FTip_FC := '';
  FCodSit := '';
  FDtaAge := 0;
  FHraAge := 0;
  FCodAca := '';
  FEspPcg := '';
  FNumCot := '';
  FSeqLag := '';
  FstrCpf := '';
  FParcel := '';
  FSerie_ := '';
  FNumDoc := '';
  FEspDoc := '';
  FOpeHis := '';
  FBlnEnvUsu := False;
  FBlnEnvCli := False;
  FArqDev := '';
  FMailDe := '';
  FMailCli := '';
  FMailUsu := '';
  FNomCli := '';
  FCodGoc := '';
  FDesGoc := '';
  FAssunt := '';
  FNomFrm := EmptyStr;
  FCodMotFinOco := EmptyStr;
  FObjAtuOcoCRM.pLimpar;
end;

procedure TOcorrenciaCRM.pProcessarOcorrencia(const objAtuCrm: TAtuOcoCrm = Nil);
begin
  If Assigned(objAtuCrm) Then
  Begin
    FObjAtuOcoCRM := objAtuCrm;
    FCodCli := FObjAtuOcoCRM.strCodCli;
    fCodEmp := FObjAtuOcoCRM.strCodEmp;
    FCodOco := FObjAtuOcoCRM.strCodOco;
    FCodToc := FObjAtuOcoCRM.strCodToc;
    FCodCoc := FObjAtuOcoCRM.strCodCoc;
    FEspDoc := FObjAtuOcoCRM.strEspDoc;
    FNumDoc := FObjAtuOcoCRM.strNumOrc;
    FAcaFat := FObjAtuOcoCRM.afcAcaFat;
  End
  Else
    pSetAtuOcoCRMInterno;

  FObjAtuOcoCRM.pProcessaFatOcorrenciasCRM;
  pExecutarAposProcessamentoOco;
end;

procedure TOcorrenciaCRM.pReabreOcorrencia;
begin
  pSetAtuOcoCRMInterno;
  FObjAtuOcoCRM.pReabreOcorrencia(FCodOco,
                                  FCodEmp,
                                  FDescri,
                                  FCodCoc,
                                  FCodToc,
                                  FCodOpe);
end;

procedure TOcorrenciaCRM.pCarregarOcorrenciaInterna;
begin
  FObjAtuOcoCRM.pCarregaOcorrencia(FTip_FC,
                                   FCodOco,
                                   FCodEmp);
  pSetAtuOcoCRMInterno;
end;

function TOcorrenciaCRM.fCarregarOcorrenciaCod(const strTip_FC: String;
                                               strCodOco: String;
                                               strCodEmp: String): IOcorrenciaCRM;
begin
  Try
    FTip_FC := strTip_FC;
    FCodOco := strCodOco;
    FCodEmp := strCodEmp;
    pCarregarOcorrenciaInterna;
  Finally
    Result := Self;
  End;
end;

procedure TOcorrenciaCRM.pEnviarEmailSemPerguntar(const srtTitulo: String);
Var
  blnDevolucao : Boolean;
  Anexos: TStringArray;
  blnAdicionaUmParagrafoPorLinha: Boolean;
begin
  If Not Assigned(FObjAtuOcoCRM) Then
    Exit;

  blnDevolucao := (fCfgSis('VENDEV', varString) = FCodToc) And (FTip_Fc = 'C') ;
  blnAdicionaUmParagrafoPorLinha := True;

  If blnDevolucao And FileExists(FArqDev) Then
    pAddDados(Anexos, FArqDev);

  TEnvioEmail.EnviarEmail(Nil,
                          strLoginUsuarioLogado,
                          srtTitulo,
                          fRetornaParaMovOcorrencias(IIF(FBlnEnvCli, FObjAtuOcoCRM.strEmailCli, ''),
                                                     IIF(FBlnEnvUsu, FObjAtuOcoCRM.strEmailUsu, '')),
                          [],
                          [],
                          TEnvioEmail.ContruirArrayMensagem(fFormataTextoMovOcorrencias(FObjAtuOcoCRM.strCodCli,
                                                            FObjAtuOcoCRM.strNomCli,
                                                            FObjAtuOcoCRM.strCodGOc,
                                                            FObjAtuOcoCRM.strDesGoc,
                                                            DateTimeToStr(FObjAtuOcoCRM.strDtaInc),
                                                            FormatDateTime('hh:mm', FObjAtuOcoCRM.strHorInc),
                                                            '',
                                                            '',
                                                            FObjAtuOcoCRM.strCodToc,
                                                            FObjAtuOcoCRM.strDesToc,
                                                            FObjAtuOcoCRM.strCodOpe,
                                                            FObjAtuOcoCRM.strNomOpe_Des,
                                                            FObjAtuOcoCRM.strDescri,
                                                            FObjAtuOcoCRM.strCodCoc,
                                                            FObjAtuOcoCRM.strDesCoc,
                                                            FObjAtuOcoCRM.strTip_Fc,
                                                            FObjAtuOcoCRM.strProtocolo,
                                                            blnDevolucao,
                                                            '',
                                                            '',
                                                            '',
                                                            FObjAtuOcoCRM.strSeqLag)),
                          Anexos,
                          False,False, '','', 0,False,
                          '','','','',0,0,0,'',
                          '',0,False,'',Nil,'',
                          '',False,False,'S','N', '','',
                          blnAdicionaUmParagrafoPorLinha,
                          False, False);
End;

procedure TOcorrenciaCRM.pFinalizarOcorrencia(const strObs, strCodOpe: String);
begin
  pSetAtuOcoCRMInterno;
  FObjAtuOcoCRM.pFinalizaOcorrencia(strObs, strCodOpe);
end;

{ TAtuOcoCrmRecorrente }

constructor TAtuOcoCrmRecorrente.Create;
begin
  inherited;
end;

class function TAtuOcoCrmRecorrente.fNew: IOcorrenciaCRM;
begin
  inherited;

  Result := TAtuOcoCrmRecorrente.Create();
end;

procedure TAtuOcoCrmRecorrente.pEnviarEmailSemPerguntar(
  const srtTitulo: String);
begin
  inherited;
end;


procedure TAtuOcoCrmRecorrente.pExecutarAposProcessamentoOco;
begin
  inherited;
end;

{ TAtuOcoCrmProspecto }

constructor TAtuOcoCrmProspecto.Create;
begin
  inherited;

  FTip_FC := 'P';
end;

class function TAtuOcoCrmProspecto.fNew: IOcorrenciaCRM;
begin
   Result := TAtuOcoCrmProspecto.Create();
end;

procedure TAtuOcoCrmProspecto.pAtualizarCadastroProspectoPeloCompl;
var
  blnAtuCatLead: Boolean;
  strCatCrmPro: String;
  strCodCrmAnt: String;
begin
  If (Not fEmptyStr(FCodCoc)) Then
  Begin
    blnAtuCatLead := (fCampoTabela('COC_ALTLEA', 'CADCOC', ['COC_CODCOC'], [FCodCoc]) = 'S');
    If blnAtuCatLead Then
    Begin
      strCatCrmPro := fCfgSis('CATLEA', varString);
      strCodCrmAnt := FObjProspectoCtr.Prospecto.CrmCat;
      FObjProspectoCtr.pAtualizarCategoriaCrm(strCatCrmPro);
      pGravarLogAlteraCategoria(strCodCrmAnt, strCatCrmPro);
    End;
  End;
end;

procedure TAtuOcoCrmProspecto.pAtualizarCategoriaProspecto(
  const strCatAtu: String);
var
  strCodCrmAnt: String;
begin
  If Not fEmptyStr(strCatAtu) Then
  Begin
    strCodCrmAnt := FObjProspectoCtr.Prospecto.CrmCat;
    FObjProspectoCtr.pAtualizarCategoriaCrm(strCatAtu);
    pGravarLogAlteraCategoria(strCodCrmAnt, strCatAtu);
  End;

end;

procedure TAtuOcoCrmProspecto.pExecutarAposProcessamentoOco;
var
  strCodCliPro: String;
begin
  inherited;

  If fEmptyStr(FObjAtuOcoCRM.strCodCli) Then
    pSetAtuOcoCRMInterno;

  If fEmptyStr(FObjProspectoCtr.Prospecto.AutInc) Then
    FObjProspectoCtr.pCarregarProspecto(FCodCli);

  Case FObjAtuOcoCRM.afcAcaFat Of
    afcOrcamento             : Begin
                                 If FObjProspectoCtr.Prospecto.CrmCat = fCfgSis('CATPRO') Then
                                 Begin
                                   pGravarLogAlteraCategoria(FObjProspectoCtr.Prospecto.CrmCat, fCfgSis('CATLEA'));
                                   FObjProspectoCtr.Prospecto.CrmCat := fCfgSis('CATLEA');
                                 End;

                                 pAtualizarCategoriaProspecto(fCfgSis('CATOPO', varString));
                               End;
    afcOrcamentoFaturado,
    afcPedidoFaturado        : pAtualizarCategoriaProspecto(fCfgSis('CATVND', varString));
    afcBaixaPedidoNaoEntregue: Begin
                                 strCodCliPro := fCampoTabela('PRO_CODCLI', 'PROSPE', ['PRO_CODPRO'], [FCodCli]);
                                 IF fEmptystr(strCodCliPro) Then
                                 Begin
                                   strCodCliPro := fCfgSis('CONCRM', varString);
                                 End;

                                 If (Not fExisteOrcamentoPendente(strCodCliPro, FNumDoc, FObjProspectoCtr.Prospecto.CodPro)) And
                                    (Not fExistePedidoPendente(strCodCliPro, FNumDoc, FObjProspectoCtr.Prospecto.CodPro)) Then
                                   pAtualizarCategoriaProspecto(fCfgSis('CATLEA', varString));

                                 TLogCatProspecto.fNew
                                                 .strEmpDoc(FCodEmp)
                                                 .strEspDoc(FEspDoc)
                                                 .strNumDoc(FNumDoc)
                                                 .pRemoverLogCatOportunidade;
                               End;
  End;

  pAtualizarCadastroProspectoPeloCompl;
end;

procedure TAtuOcoCrmProspecto.pFinalizarOcorrencia(const strObs, strCodOpe: String);
begin
  inherited;

  pAtualizarProspectoFinalizacaoOcorrencia;
End;

procedure TAtuOcoCrmProspecto.pGravarLogAlteraCategoria(const strCodCrmAnt, strCatCrmPro: String);
begin
  TLogCatProspecto.fNew
                  .strSeqPro(FObjProspectoCtr.Prospecto.AutInc)
                  .strCatAnt(strCodCrmAnt)
                  .strCatAtu(strCatCrmPro)
                  .strCodMot(FCodMotFinOco)
                  .strEmpDoc(FCodEmp)
                  .strEspDoc(FEspDoc)
                  .strNumDoc(FNumDoc)
                  .strStaPro(FObjProspectoCtr.Prospecto.StaPro)
                  .pGravaLogAlteracaoCategoria
                  ;
end;

procedure TAtuOcoCrmProspecto.pProcessarOcorrencia(const objAtuCrm: TAtuOcoCrm = Nil);
begin
  inherited;
end;

procedure TAtuOcoCrmProspecto.pAtualizarProspectoFinalizacaoOcorrencia;
var
  qryMotivo: TUniQuery;
  strMotStatus: String;
  strCodCatAnt: String;
begin
  If fEmptyStr(FCodMotFinOco) Then
    Exit;

  qryMotivo := fCriaQuery();
  Try
    If fEmptyStr(FObjProspectoCtr.Prospecto.AutInc) Then
      FObjProspectoCtr.pCarregarProspecto(FCodCli);

    qryMotivo.Close;
    qryMotivo.SQL.Clear;
    qryMotivo.SQL.Add('SELECT MOT_STAT_D, ');
    qryMotivo.SQL.Add('       MOT_STAT_I, ');
    qryMotivo.SQL.Add('       MOT_STAT_A, ');
    qryMotivo.SQL.Add('       MOT_CODCAT  ');
    qryMotivo.SQL.Add('  FROM MOTOCO ');
    qryMotivo.SQL.Add(' WHERE MOT_CODIGO = :CODIGO ');
    qryMotivo.ParamByName('CODIGO').AsString := FCodMotFinOco;
    qryMotivo.Open;

    If qryMotivo.IsEmpty Then
      Exit;

    strCodCatAnt := FObjProspectoCtr.Prospecto.CrmCat;

    If Not fEmptyStr(qryMotivo.FieldByName('MOT_CODCAT').AsString) Then
    Begin
      FObjProspectoCtr.pAtualizarCategoriaCrm(qryMotivo.FieldByName('MOT_CODCAT').AsString);
    End;

    If (qryMotivo.FieldByName('MOT_STAT_D').AsString = 'S') or (qryMotivo.FieldByName('MOT_STAT_I').AsString = 'S') or
       (qryMotivo.FieldByName('MOT_STAT_A').AsString = 'S') Then
    Begin
      If qryMotivo.FieldByName('MOT_STAT_D').AsString = 'S' Then
        strMotStatus := arrStatPro[tstProspeComContatoVendaNaoPassivel];

      If qryMotivo.FieldByName('MOT_STAT_I').AsString = 'S' Then
        strMotStatus := arrStatPro[tstProspeSemContatoVendaPassivel];

      If qryMotivo.FieldByName('MOT_STAT_A').AsString = 'S' Then
        strMotStatus := arrStatPro[tstProspeComContatoVendaPassivel];

      FObjProspectoCtr.pAtualizarStatusProspecto(strMotStatus);
    End;

    pGravarLogAlteraCategoria(strCodCatAnt, qryMotivo.FieldByName('MOT_CODCAT').AsString);
  Finally
    FreeAndNil(qryMotivo);
  End;
end;

{ TAtuOcoCrmCliente }

constructor TAtuOcoCrmCliente.Create;
begin
  inherited;

  FTip_FC := 'C';
end;

class function TAtuOcoCrmCliente.fNew: IOcorrenciaCRM;
begin
  Result := TAtuOcoCrmCliente.Create;
end;

function TAtuOcoCrmCliente.fRetornaCodProspecto(
  const strCodCli: String): String;
begin
  Result := fCampoTabela('PRO_CODPRO', 'PROSPE', ['PRO_CODCLI'], [strCodCli]);
end;

procedure TAtuOcoCrmCliente.pExecutarAposProcessamentoOco;
var
  strCodPro: String;
begin
  inherited;

  strCodPro := fRetornaCodProspecto(IIF(fEmptyStr(FObjAtuOcoCRM.strCodCli), FCodCli, FObjAtuOcoCRM.strCodCli));
  If Not fEmptyStr(strCodPro)Then
    TAtuOcoCrmProspecto.fNew
                       .CodCli(strCodPro)
                       .AcaFat(FAcaFat)
                       .pExecutarAposProcessamentoOco;
  
end;


{ TAtuOcoCrmFornecedor }

constructor TAtuOcoCrmFornecedor.Create;
begin
  inherited;

  FTip_FC := 'F';
end;

class function TAtuOcoCrmFornecedor.fNew: IOcorrenciaCRM;
begin
  Result := TAtuOcoCrmFornecedor.Create();
end;

procedure TAtuOcoCrmFornecedor.pExecutarAposProcessamentoOco;
begin
  inherited;
end;

end.
