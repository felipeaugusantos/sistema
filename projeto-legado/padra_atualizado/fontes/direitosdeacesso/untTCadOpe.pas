unit untTCadOpe;

interface

uses SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable, untFuncoesSimples,
     untTCadPrv, Aurelius.Types.Proxy, Aurelius.Types.Blob, System.Classes, untImagemBase64;

Type
  [Entity]
  [Table('OPEASS')]
  [UniqueKey('ASS_CODOPE')]
  [Id('FASS_CODOPE', TIdGenerator.None)]
  TOpeAss = class
  private
    [Column('ASS_CODOPE', [TColumnProp.Required], 3)]
    FASS_CODOPE: String;

    [Column('ASS_IMGB64', [TColumnProp.Lazy])]
    FASS_IMGB64: string;

    [Column('ASS_TEXTO_', [TColumnProp.Lazy])]
    FASS_TEXTO_: String;
  public
    constructor Create;

    procedure CarregarStreamImagem(var imageStream: TMemoryStream);
    procedure LimparImagemAssinatura();
    function  ImagemVazia(): Boolean;

    property ASS_CODOPE: String Read FASS_CODOPE Write FASS_CODOPE;
    property ASS_IMGB64: String Read FASS_IMGB64 Write FASS_IMGB64;
    property ASS_TEXTO_: String Read FASS_TEXTO_ Write FASS_TEXTO_;
  end;

  [Entity]
  [Table('CADOPE')]
  [UniqueKey('AUTOINCREM')]
  [Id('FOPE_CODOPE', TIdGenerator.None)]
  TCadOpe = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: String;

    [Column('OPE_CODOPE', [TColumnProp.Required], 3)]
    FOPE_CODOPE: String;

    [Column('OPE_NOMOPE', [TColumnProp.Required], 30)]
    FOPE_NOMOPE: String;

    [Column('OPE_CODEMP', [TColumnProp.Required], 3)]
    FOPE_CODEMP: String;

    [Column('OPE_CODCID', [], 5)]
    FOPE_CODCID: Nullable<String>;

    [Column('OPE_SENOPE', [], 10)]
    FOPE_SENOPE: Nullable<String>;

    [Column('OPE_ENDERE', [], 40)]
    FOPE_ENDERE: Nullable<String>;

    [Column('OPE_BAIRRO', [], 30)]
    FOPE_BAIRRO: Nullable<String>;

    [Column('OPE_C_E_P_', [], 9)]
    FOPE_C_E_P_: Nullable<String>;

    [Column('OPE_NOMFAN', [], 20)]
    FOPE_NOMFAN: Nullable<String>;

    [Column('OPE_PERCOM', [], 12, 3)]
    FOPE_PERCOM: Nullable<Double>;

    [Column('OPE_PERCO2', [], 12, 3)]
    FOPE_PERCO2: Nullable<Double>;

    [Column('OPE_NUMWPP', [], 15)]
    FOPE_NUMWPP: Nullable<String>;

    [Column('OPE_FONE01', [], 15)]
    FOPE_FONE01: Nullable<String>;

    [Column('OPE_FONE02', [], 20)]
    FOPE_FONE02: Nullable<String>;

    [Column('OPE_NEXTEL', [], 20)]
    FOPE_NEXTEL: Nullable<String>;

    [Column('OPE_OBS001', [], 50)]
    FOPE_OBS001: Nullable<String>;

    [Column('OPE_OBS002', [], 50)]
    FOPE_OBS002: Nullable<String>;

    [Column('OPE_DTANAS', [])]
    FOPE_DTANAS: Nullable<TDateTime>;

    [Column('OPE_DTAADM', [])]
    FOPE_DTAADM: Nullable<TDateTime>;

    [Column('OPE_DTADMI', [])]
    FOPE_DTADMI: Nullable<TDateTime>;

    [Column('OPE_NUM_RG', [], 15)]
    FOPE_NUM_RG: Nullable<String>;

    [Column('OPE_NUMCPF', [], 18)]
    FOPE_NUMCPF: Nullable<String>;

    [Column('OPE_QTDETI', [], 11)]
    FOPE_QTDETI: Nullable<Int64>;

    [Column('OPE_E_MAIL', [], 100)]
    FOPE_E_MAIL: String;

    [Column('OPE_EMALOG', [], 100)]
    FOPE_EMALOG: String;

    [Column('OPE_LIMCRE', [], 12, 2)]
    FOPE_LIMCRE: Nullable<Double>;

    [Column('OPE_CODFOR', [], 8)]
    FOPE_CODFOR: Nullable<String>;

    [Column('OPE_STATUS', [], 1)]
    FOPE_STATUS: Nullable<String>;

    [Column('OPE_EMPACE', [], 100)]
    FOPE_EMPACE: Nullable<String>;

    [Column('OPE_INTEXT', [], 1)]
    FOPE_INTEXT: Nullable<String>;

    [Column('OPE_CODBAR', [], 13)]
    FOPE_CODBAR: Nullable<String>;

    [Column('OPE_CODVEL', [], 3)]
    FOPE_CODVEL: Nullable<String>;

    [Column('OPE_CODDEP', [], 3)]
    FOPE_CODDEP: Nullable<String>;

    [Column('OPE_MSGODP', [], 1)]
    FOPE_MSGODP: Nullable<String>;

    [Column('OPE_MSGPED', [], 1)]
    FOPE_MSGPED: Nullable<String>;

    [Column('OPE_MSGORC', [], 1)]
    FOPE_MSGORC: Nullable<String>;

    [Column('OPE_MSGTRE', [], 1)]
    FOPE_MSGTRE: Nullable<String>;

    [Column('OPE_EMPROM', [], 150)]
    FOPE_EMPROM: Nullable<String>;

    [Column('OPE_SALFIX', [], 12, 3)]
    FOPE_SALFIX: Nullable<Double>;

    [Column('OPE_PERADI', [], 12, 3)]
    FOPE_PERADI: Nullable<Double>;

    [Column('OPE_CODFAV', [], 6)]
    FOPE_CODFAV: Nullable<String>;

    [Column('OPE_MSGLIB', [], 1)]
    FOPE_MSGLIB: Nullable<String>;

    [Column('OPE_RAMAL1', [], 5)]
    FOPE_RAMAL1: Nullable<String>;

    [Column('OPE_RAMAL2', [], 5)]
    FOPE_RAMAL2: Nullable<String>;

    [Column('OPE_EMPLOG', [], 100)]
    FOPE_EMPLOG: Nullable<String>;

    [Column('OPE_GERENT', [], 1)]
    FOPE_GERENT: Nullable<String>;

    [Column('OPE_COMEQP', [], 12, 3)]
    FOPE_COMEQP: Nullable<Double>;

    [Column('OPE_CODGER', [], 3)]
    FOPE_CODGER: Nullable<String>;

    [Column('OPE_MECANI', [], 1)]
    FOPE_MECANI: Nullable<String>;

    [Column('OPE_MVESAL', [], 12, 2)]
    FOPE_MVESAL: Nullable<Double>;

    [Column('OPE_MVECMF', [], 12, 2)]
    FOPE_MVECMF: Nullable<Double>;

    [Column('OPE_MVECFA', [], 12, 2)]
    FOPE_MVECFA: Nullable<Double>;

    [Column('OPE_MVECMA', [], 12, 2)]
    FOPE_MVECMA: Nullable<Double>;

    [Column('OPE_MSUSAL', [], 12, 2)]
    FOPE_MSUSAL: Nullable<Double>;

    [Column('OPE_MSUCMF', [], 12, 2)]
    FOPE_MSUCMF: Nullable<Double>;

    [Column('OPE_MSUCFA', [], 12, 2)]
    FOPE_MSUCFA: Nullable<Double>;

    [Column('OPE_MSUCMA', [], 12, 2)]
    FOPE_MSUCMA: Nullable<Double>;

    [Column('OPE_MGESAL', [], 12, 2)]
    FOPE_MGESAL: Nullable<Double>;

    [Column('OPE_MGECMF', [], 12, 2)]
    FOPE_MGECMF: Nullable<Double>;

    [Column('OPE_MGECFA', [], 12, 2)]
    FOPE_MGECFA: Nullable<Double>;

    [Column('OPE_MGECMA', [], 12, 2)]
    FOPE_MGECMA: Nullable<Double>;

    [Column('OPE_SALBAS', [], 12, 2)]
    FOPE_SALBAS: Nullable<Double>;

    [Column('OPE_COMCMF', [], 12, 2)]
    FOPE_COMCMF: Nullable<Double>;

    [Column('OPE_COMCFA', [], 12, 2)]
    FOPE_COMCFA: Nullable<Double>;

    [Column('OPE_COMCMA', [], 12, 2)]
    FOPE_COMCMA: Nullable<Double>;

    [Column('OPE_SUBGER', [], 1)]
    FOPE_SUBGER: Nullable<String>;

    [Column('OPE_COMEQS', [], 12, 2)]
    FOPE_COMEQS: Nullable<Double>;

    [Column('OPE_CODSUB', [], 3)]
    FOPE_CODSUB: Nullable<String>;

    [Column('OPE_MECCIT', [], 12, 3)]
    FOPE_MECCIT: Nullable<Double>;

    [Column('OPE_MECCSE', [], 12, 3)]
    FOPE_MECCSE: Nullable<Double>;

    [Column('OPE_EMPCTR', [], 150)]
    FOPE_EMPCTR: Nullable<String>;

    [Column('OPE_EMPCTP', [], 150)]
    FOPE_EMPCTP: Nullable<String>;

    [Column('OPE_TPCOMC', [], 1)]
    FOPE_TPCOMC: Nullable<String>;

    [Column('OPE_MSGPOS', [], 1)]
    FOPE_MSGPOS: Nullable<String>;

    [Column('OPE_PRVSEN', [], 25)]
    FOPE_PRVSEN: Nullable<String>;

    [Column('OPE_CODPRV', [])]
    FOPE_CODPRV: Nullable<Integer>;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('OPE_CODPRV', [], 'PRV_CODPRV')]
    FPrvEma : Proxy<TCadPrv>;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('OPE_CODOPE', [])]
    FOpeAss : Proxy<TOpeAss>;

    [Column('OPE_LIMCRA', [], 12, 2)]
    FOPE_LIMCRA: Nullable<Double>;

    [Column('OPE_E_NOME', [], 50)]
    FOPE_E_NOME: String;

    [Column('OPE_EMAAUT', [], 1)]
    FOPE_EMAAUT: Nullable<String>;

    function fGetDtaNas: String;
    function fGetDtaDmi: String;
    function fGetDtaAdm: String;
    function fGetPrvEma: TCadPrv;
    function fGetOpeAss: TOpeAss;

    procedure pSetDtaAdm(const Value: String);
    procedure pSetDtaDmi(const Value: String);
    procedure pSetDtaNas(const Value: String);
    procedure pSetCodEmp(const Value: String);
    procedure pSetPrvEma(const Value: TCadPrv);
    procedure pSetOpeAss(const Value: TOpeAss);
  public
    constructor Create;

    property AUTOINCREM: String              Read FAUTOINCREM Write FAUTOINCREM;
    property OPE_CODOPE: String              Read FOPE_CODOPE Write FOPE_CODOPE;
    property OPE_NOMOPE: String              Read FOPE_NOMOPE Write FOPE_NOMOPE;
    property OPE_CODEMP: String              Read FOPE_CODEMP Write pSetCodEmp;
    property OPE_CODCID: Nullable<String>    Read FOPE_CODCID Write FOPE_CODCID;
    property OPE_SENOPE: Nullable<String>    Read FOPE_SENOPE Write FOPE_SENOPE;
    property OPE_ENDERE: Nullable<String>    Read FOPE_ENDERE Write FOPE_ENDERE;
    property OPE_BAIRRO: Nullable<String>    Read FOPE_BAIRRO Write FOPE_BAIRRO;
    property OPE_C_E_P_: Nullable<String>    Read FOPE_C_E_P_ Write FOPE_C_E_P_;
    property OPE_NOMFAN: Nullable<String>    Read FOPE_NOMFAN Write FOPE_NOMFAN;
    property OPE_PERCOM: Nullable<Double>    Read FOPE_PERCOM Write FOPE_PERCOM;
    property OPE_PERCO2: Nullable<Double>    Read FOPE_PERCO2 Write FOPE_PERCO2;
    property OPE_NUMWPP: Nullable<String>    Read FOPE_NUMWPP Write FOPE_NUMWPP;
    property OPE_FONE01: Nullable<String>    Read FOPE_FONE01 Write FOPE_FONE01;
    property OPE_FONE02: Nullable<String>    Read FOPE_FONE02 Write FOPE_FONE02;
    property OPE_NEXTEL: Nullable<String>    Read FOPE_NEXTEL Write FOPE_NEXTEL;
    property OPE_OBS001: Nullable<String>    Read FOPE_OBS001 Write FOPE_OBS001;
    property OPE_OBS002: Nullable<String>    Read FOPE_OBS002 Write FOPE_OBS002;
    property OPE_DTANAS: Nullable<TDateTime> Read FOPE_DTANAS Write FOPE_DTANAS;
    property OPE_DTAADM: Nullable<TDateTime> Read FOPE_DTAADM Write FOPE_DTAADM;
    property OPE_DTADMI: Nullable<TDateTime> Read FOPE_DTADMI Write FOPE_DTADMI;
    property OPE_NUM_RG: Nullable<String>    Read FOPE_NUM_RG Write FOPE_NUM_RG;
    property OPE_NUMCPF: Nullable<String>    Read FOPE_NUMCPF Write FOPE_NUMCPF;
    property OPE_QTDETI: Nullable<Int64>     Read FOPE_QTDETI Write FOPE_QTDETI;
    property OPE_E_MAIL: String    Read FOPE_E_MAIL Write FOPE_E_MAIL;
    property OPE_EMALOG: String    Read FOPE_EMALOG Write FOPE_EMALOG;
    property OPE_LIMCRE: Nullable<Double>    Read FOPE_LIMCRE Write FOPE_LIMCRE;
    property OPE_CODFOR: Nullable<String>    Read FOPE_CODFOR Write FOPE_CODFOR;
    property OPE_STATUS: Nullable<String>    Read FOPE_STATUS Write FOPE_STATUS;
    property OPE_EMPACE: Nullable<String>    Read FOPE_EMPACE Write FOPE_EMPACE;
    property OPE_INTEXT: Nullable<String>    Read FOPE_INTEXT Write FOPE_INTEXT;
    property OPE_CODBAR: Nullable<String>    Read FOPE_CODBAR Write FOPE_CODBAR;
    property OPE_CODVEL: Nullable<String>    Read FOPE_CODVEL Write FOPE_CODVEL;
    property OPE_CODDEP: Nullable<String>    Read FOPE_CODDEP Write FOPE_CODDEP;
    property OPE_MSGODP: Nullable<String>    Read FOPE_MSGODP Write FOPE_MSGODP;
    property OPE_MSGPED: Nullable<String>    Read FOPE_MSGPED Write FOPE_MSGPED;
    property OPE_MSGORC: Nullable<String>    Read FOPE_MSGORC Write FOPE_MSGORC;
    property OPE_MSGTRE: Nullable<String>    Read FOPE_MSGTRE Write FOPE_MSGTRE;
    property OPE_EMPROM: Nullable<String>    Read FOPE_EMPROM Write FOPE_EMPROM;
    property OPE_SALFIX: Nullable<Double>    Read FOPE_SALFIX Write FOPE_SALFIX;
    property OPE_PERADI: Nullable<Double>    Read FOPE_PERADI Write FOPE_PERADI;
    property OPE_CODFAV: Nullable<String>    Read FOPE_CODFAV Write FOPE_CODFAV;
    property OPE_MSGLIB: Nullable<String>    Read FOPE_MSGLIB Write FOPE_MSGLIB;
    property OPE_RAMAL1: Nullable<String>    Read FOPE_RAMAL1 Write FOPE_RAMAL1;
    property OPE_RAMAL2: Nullable<String>    Read FOPE_RAMAL2 Write FOPE_RAMAL2;
    property OPE_EMPLOG: Nullable<String>    Read FOPE_EMPLOG Write FOPE_EMPLOG;
    property OPE_GERENT: Nullable<String>    Read FOPE_GERENT Write FOPE_GERENT;
    property OPE_COMEQP: Nullable<Double>    Read FOPE_COMEQP Write FOPE_COMEQP;
    property OPE_CODGER: Nullable<String>    Read FOPE_CODGER Write FOPE_CODGER;
    property OPE_MECANI: Nullable<String>    Read FOPE_MECANI Write FOPE_MECANI;
    property OPE_MVESAL: Nullable<Double>    Read FOPE_MVESAL Write FOPE_MVESAL;
    property OPE_MVECMF: Nullable<Double>    Read FOPE_MVECMF Write FOPE_MVECMF;
    property OPE_MVECFA: Nullable<Double>    Read FOPE_MVECFA Write FOPE_MVECFA;
    property OPE_MVECMA: Nullable<Double>    Read FOPE_MVECMA Write FOPE_MVECMA;
    property OPE_MSUSAL: Nullable<Double>    Read FOPE_MSUSAL Write FOPE_MSUSAL;
    property OPE_MSUCMF: Nullable<Double>    Read FOPE_MSUCMF Write FOPE_MSUCMF;
    property OPE_MSUCFA: Nullable<Double>    Read FOPE_MSUCFA Write FOPE_MSUCFA;
    property OPE_MSUCMA: Nullable<Double>    Read FOPE_MSUCMA Write FOPE_MSUCMA;
    property OPE_MGESAL: Nullable<Double>    Read FOPE_MGESAL Write FOPE_MGESAL;
    property OPE_MGECMF: Nullable<Double>    Read FOPE_MGECMF Write FOPE_MGECMF;
    property OPE_MGECFA: Nullable<Double>    Read FOPE_MGECFA Write FOPE_MGECFA;
    property OPE_MGECMA: Nullable<Double>    Read FOPE_MGECMA Write FOPE_MGECMA;
    property OPE_SALBAS: Nullable<Double>    Read FOPE_SALBAS Write FOPE_SALBAS;
    property OPE_COMCMF: Nullable<Double>    Read FOPE_COMCMF Write FOPE_COMCMF;
    property OPE_COMCFA: Nullable<Double>    Read FOPE_COMCFA Write FOPE_COMCFA;
    property OPE_COMCMA: Nullable<Double>    Read FOPE_COMCMA Write FOPE_COMCMA;
    property OPE_SUBGER: Nullable<String>    Read FOPE_SUBGER Write FOPE_SUBGER;
    property OPE_COMEQS: Nullable<Double>    Read FOPE_COMEQS Write FOPE_COMEQS;
    property OPE_CODSUB: Nullable<String>    Read FOPE_CODSUB Write FOPE_CODSUB;
    property OPE_MECCIT: Nullable<Double>    Read FOPE_MECCIT Write FOPE_MECCIT;
    property OPE_MECCSE: Nullable<Double>    Read FOPE_MECCSE Write FOPE_MECCSE;
    property OPE_EMPCTR: Nullable<String>    Read FOPE_EMPCTR Write FOPE_EMPCTR;
    property OPE_EMPCTP: Nullable<String>    Read FOPE_EMPCTP Write FOPE_EMPCTP;
    property OPE_TPCOMC: Nullable<String>    Read FOPE_TPCOMC Write FOPE_TPCOMC;
    property OPE_MSGPOS: Nullable<String>    Read FOPE_MSGPOS Write FOPE_MSGPOS;
    property OPE_PRVSEN: Nullable<String>    Read FOPE_PRVSEN Write FOPE_PRVSEN;
    property OPE_CODPRV: Nullable<Integer>   Read FOPE_CODPRV Write FOPE_CODPRV;
    property OPE_LIMCRA: Nullable<Double>    Read FOPE_LIMCRA Write FOPE_LIMCRA;
    property OPE_EMAAUT: Nullable<String>    Read FOPE_EMAAUT Write FOPE_EMAAUT;
    property objPrvEma : TCadPrv             Read fGetPrvEma  Write pSetPrvEma;
    property objOpeAss : TOpeAss             Read fGetOpeAss  Write pSetOpeAss;

    property strDtaNas : String              Read fGetDtaNas  Write pSetDtaNas;
    property strDtaAdm : String              Read fGetDtaAdm  Write pSetDtaAdm;
    property strDtaDmi : String              Read fGetDtaDmi  Write pSetDtaDmi;

    property OPE_E_NOME: String    Read FOPE_E_NOME Write FOPE_E_NOME;

  end;

implementation

{ TCtpDet }

constructor TCadOpe.Create;
begin
  FOPE_STATUS := 'A';
  FOPE_INTEXT := 'I';
  FOPE_MSGODP := 'N';
  FOPE_MSGPED := 'N';
  FOPE_MSGORC := 'N';
  FOPE_MSGTRE := 'N';
  FOPE_MSGLIB := 'S';
  FOPE_GERENT := 'N';
  FOPE_MECANI := 'N';
  FOPE_SUBGER := 'N';
  FOPE_COMEQS := 0.000;
  FOPE_MECCIT := 0.000;
  FOPE_MECCSE := 0.000;
  FOPE_TPCOMC := 'P';
  FOPE_MSGPOS := 'E';
end;

function TCadOpe.fGetDtaAdm: String;
begin
  if (not FOPE_DTAADM.HasValue) then
    Result := ''
  else
    Result := FormatDateTime('dd/mm/yyyy', FOPE_DTAADM);
end;

function TCadOpe.fGetDtaDmi: String;
begin
  if (not FOPE_DTADMI.HasValue) then
    Result := ''
  else
    Result := FormatDateTime('dd/mm/yyyy', FOPE_DTADMI);
end;

function TCadOpe.fGetDtaNas: String;
begin
  if (not FOPE_DTANAS.HasValue) then
    Result := ''
  else
    Result := FormatDateTime('dd/mm/yyyy', FOPE_DTANAS);
end;

function TCadOpe.fGetOpeAss: TOpeAss;
begin
  Result := FOpeAss.Value;
end;

function TCadOpe.fGetPrvEma: TCadPrv;
begin
  Result := FPrvEma.Value;
end;

procedure TCadOpe.pSetCodEmp(const Value: String);
begin
  if fEmptyStr(Value) then
    raise Exception.Create('Código da empresa deve ser informado.')
  else
    FOPE_CODEMP := Value;
end;

procedure TCadOpe.pSetDtaAdm(const Value: String);
begin
  if fEmptyStr(Value) then
    FOPE_DTAADM := 0
  else
    FOPE_DTAADM := StrToDate(Value);
end;

procedure TCadOpe.pSetDtaDmi(const Value: String);
begin
  if fEmptyStr(Value) then
    FOPE_DTADMI := 0
  else
    FOPE_DTADMI := StrToDate(Value);
end;

procedure TCadOpe.pSetDtaNas(const Value: String);
begin
  if fEmptyStr(Value) then
    FOPE_DTANAS := 0
  else
    FOPE_DTANAS := StrToDate(Value);
end;

procedure TCadOpe.pSetOpeAss(const Value: TOpeAss);
begin
  FOpeAss.Value := Value;
end;

procedure TCadOpe.pSetPrvEma(const Value: TCadPrv);
begin
  FPrvEma.Value := Value;
end;

{ TOpeAss }

constructor TOpeAss.Create;
begin
  FASS_CODOPE := '';
  FASS_IMGB64 := '';
  FASS_TEXTO_ := '';
end;

function TOpeAss.ImagemVazia: Boolean;
begin
  Result := (FASS_IMGB64.IsEmpty);
end;

procedure TOpeAss.LimparImagemAssinatura;
begin
  If (not FASS_IMGB64.IsEmpty) Then
    FASS_IMGB64 := '';
end;

procedure TOpeAss.CarregarStreamImagem(var imageStream: TMemoryStream);
var
  tmpImg: TBytesStream;
begin
  If (not FASS_IMGB64.isEmpty) Then
  Begin
    tmpImg := TBytesStream.Create(nil);
    fStreamFromBase64(FASS_IMGB64, tmpImg);

    Try
      If (tmpImg.Size > 0) Then
      Begin
        tmpImg.SaveToStream(imageStream);
        imageStream.Position := 0;
      End;
    Finally
      tmpImg.Free;
    End;
  End;
end;
end.
