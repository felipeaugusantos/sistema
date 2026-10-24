unit untTCadPag;

interface

Uses Classes, DateUtils, StrUtils, SysUtils, untFuncoesSimples,
  Uni, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable, untTCadFor,
  Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADPAG')]
  [UniqueKey('CTP_CODFOR, CTP_NUMDUP')]
  [Id('FAutInc', TIdGenerator.None)]
  TCadPag = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required])]
    FAutInc : string;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('CTP_CODFOR', [], 'FOR_CODFOR')]
    FCodFor : Proxy<TCadFor>;

    [Column('CTP_NUMDUP')]
    FNumDup : string;
    [Column('CTP_PARCEL')]
    FParcel : string;
    [Column('CTP_CODEMP')]
    FCodEmp : string;
    [Column('CTP_SEQBAI')]
    FSeqBai : Nullable<Integer>;
    [Column('CTP_SERIE_')]
    FSerie_  : string;
    [Column('CTP_CODCTA')]
    FCodCta : string;
    [Column('CTP_DTACAD')]
    FDtaCad : TDateTime;
    [Column('CTP_DTAVEN')]
    FDtaVen : Nullable<TDateTime>;
    [Column('CTP_VALDUP')]
    FValDup : Double;
    [Column('CTP_VALORI')]
    FValOri : Double;
    [Column('CTP_PREVIS')]
    FPrevis : string;
    [Column('CTP_VEIOBO')]
    FVeioBo : string;
    [Column('CTP_VEIONF')]
    FVeioNf : string;
    [Column('CTP_HIST01', [TColumnProp.Lazy])]
    FHist01 : Nullable<string>;
    [Column('CTP_HIST02')]
    FHist02 : string;
    [Column('CTP_HISBAI', [], 50)]
    FHisBai : Nullable<string>;
    [Column('CTP_PORBAI')]
    FPorBai : Nullable<string>;
    [Column('CTP_CTABAI')]
    FCtaBai : Nullable<string>;
    [Column('CTP_DOCBAI')]
    FDocBai : Nullable<string>;
    [Column('CTP_OPEBAI')]
    FOpeBai : Nullable<string>;
    [Column('CTP_DTAPAG')]
    FDtaPag : Nullable<TDateTime>;
    [Column('CTP_VALPAG')]
    FValPag : Double;
    [Column('CTP_VALJUR')]
    FValJur : Double;
    [Column('CTP_VALMUL')]
    FValMul : Double;
    [Column('CTP_VALDES')]
    FValDes : Double;
    [Column('CTP_EMPGER')]
    FEmpGer : string;
    [Column('CTP_DTABAI')]
    FDtaBai : Nullable<TDateTime>;
    [Column('CTP_CODEVE')]
    FCodEve : Nullable<string>;
    [Column('CTP_DESSUJ')]
    FDesSuj : Double;
    [Column('CTP_JURSUJ')]
    FJurSuj : Double;
    [Column('CTP_MULSUJ')]
    FMulSuj : Double;
    [Column('CTP_USACHQ')]
    FUsaChq : string;
    [Column('CTP_CODVEN')]
    FCodVen : Nullable<string>;
    [Column('CTP_TIPDOC')]
    FTipDoc : Nullable<Integer>;
    [Column('CTP_NUMDOC')]
    FNumDoc : string;
    [Column('CTP_CODVEL')]
    FCodVel : string;
    [Column('CTP_CODPOR')]
    FCodPor : Nullable<string>;
    [Column('CTP_CODBAR')]
    FCodBar : string;
    [Column('CTP_DTAENV')]
    FDtaEnv : Nullable<TDateTime>;
    [Column('CTP_BCOENV')]
    FBcoEnv : Nullable<string>;
    [Column('CTP_TIPDES')]
    FTipDes : string;
    [Column('CTP_DEPOSI')]
    FDeposi : string;
    [Column('CTP_EMPBAI')]
    FEmpBai : Nullable<string>;
    [Column('CTP_SEQCON')]
    FSeqCon : Nullable<Integer>;
    [Column('CTP_RESCAI')]
    FRescai : Integer;
    [Column('CTP_RCXCON')]
    FRcxCon : Integer;
    [Column('CTP_VENDOR')]
    FVendor : Double;
    [Column('CTP_PAGANT')]
    FPagAnt : string;
    [Column('CTP_NOTTIP')]
    FNotTip : string;
    [Column('CTP_NOTENT')]
    FNotEnt : string;
    [Column('CTP_CTPCOM')]
    FCtpCom : string;
    [Column('CTP_LINDIG')]
    FLinDig : string;
    [Column('CTP_DOCTER')]
    FDocTer : string;
    [Column('CTP_ESPTER')]
    FEspTer : string;
    [Column('CTP_EMPTER')]
    FEmpTer : string;
    [Column('CTP_CLITER')]
    FCliTer : string;
    [Column('CTP_USOCON')]
    FUsoCon : string;
    [Column('CTP_COMPET')]
    FCompet : string;
    [Column('CTP_USOCLI')]
    FUsoCli : string;
    [Column('CTP_USODOC')]
    FUsoDoc : string;
    [Column('CTP_USOESP')]
    FUsoEsp : string;
    [Column('CTP_USOEMP')]
    FUsoEmp : string;
    [Column('CTP_DINHEI')]
    FDinhei : Double;
    [Column('CTP_CHQAVI')]
    FChqAvi : Double;
    [Column('CTP_ORDPAG')]
    FOrdPag : Double;
    [Column('CTP_REPCHQ')]
    FRepChq : Double;
    [Column('CTP_SEQRCH')]
    FSeqRCH : Integer;
    [Column('CTP_JURANT')]
    FJurAnt : Double;
    [Column('CTP_MULANT')]
    FMulAnt : Double;
    [Column('CTP_DESANT')]
    FDesAnt : Double;
    [Column('CTP_VALANT')]
    FValAnt : Double;
    [Column('CTP_DTALIB')]
    FDtaLib : Nullable<TDate>;
    [Column('CTP_HORLIB')]
    FHorLib : Nullable<TTime>;
    [Column('CTP_OPELIB')]
    FOpeLib : Nullable<String>;
    [Column('CTP_QTDDIA')]
    FQtdDia : Integer;
    [Column('CTP_MOTEST')]
    FMotEst : Nullable<String>;
    [Column('CTP_NOMFRM')]
    FNomFrm : string;
    [Column('CTP_CODOPE')]
    FCodOpe : string;
    [Column('CTP_NUMDDA')]
    FNumDDA : string;
    [Column('CTP_Q_GUIA')]
    FQ_Guia : Nullable<String>;
    [Column('CTP_CODREC')]
    FCodRec : string;
    [Column('CTP_BCOFOR')]
    FBcoFor : Nullable<string>;
    [Column('CTP_OUTENT')]
    FOutEnt : Double;
    [Column('CTP_CODPRJ')]
    FCODPRJ : Nullable<string>;
    [Column('CTP_OPEAPR')]
    FOpeApr : Nullable<string>;
    [Column('CTP_OPEREP')]
    FOpeRep : Nullable<string>;
    [Column('CTP_MOTREP')]
    FMotRep : Nullable<string>;
    [Column('CTP_DTAAPR')]
    FDtaApr : Nullable<TDateTime>;
    [Column('CTP_DTAREP')]
    FDtaRep : Nullable<TDateTime>;
    [Column('CTP_FORPIX')]
    FForPix : Nullable<string>;
    [Column('CTP_GRVORI')]
    FGrvOri : Double;
    [Column('CTP_NUMLOT')]
    FNumLot : Nullable<string>;
    [Column('CTP_DTALOT')]
    FDtaLot : Nullable<TDateTime>;
    [Column('CTP_PAGLOT')]
    FPagLot : Nullable<TDateTime>;
    [Column('CTP_CARLOT')]
    FCarLot : Nullable<string>;
    [Column('CTP_TIPLOT')]
    FTipLot : Nullable<string>;

    {*******************************}
    {* FIELDS QUE NÃO PERTENCEM AO *}
    {* CADPAG                      *}
    {****************************AF*}
    FEhUmPG: Boolean;

    function fGetDtaEnv: string;
    function fGetDtaVen: string;
    function fGetDtaPag: string;
    function fGetDtaCad: string;
    function getCodFor : TCadFor;
    function getNomFor: String;
    function getNomFan: String;
    function fGetCodigoFornecedor : string;

    procedure pSetCodEmp(const Value: string);
    procedure pSetDtaCad(const Value: string);
    procedure pSetDtaEnv(const Value: string);
    procedure pSetDtaPag(const Value: string);
    procedure pSetDtaVen(const Value: string);
    procedure pSetValDup(const Value: Double);
    procedure setCodFor(const Value: TCadFor);

    function fGetSeqCon: Nullable<Integer>;
    function fGetSeqBai: Nullable<Integer>;
    function fGetEmpBai: Nullable<String>;
    function fGetDocBai: Nullable<String>;

  public
    constructor Create;

    property strAutInc : string              Read FAutInc    Write FAutInc;
    property objCodFor : TCadFor             Read getCodFor  Write setCodFor;
    property strNumDup : string              Read FNumDup    Write FNumDup;
    property strParcel : string              Read FParcel    Write FParcel;
    property strCodEmp : string              Read FCodEmp    Write pSetCodEmp;
    property intSeqBai : Nullable<Integer>   Read fGetSeqBai Write FSeqBai;
    property strSerie  : string              Read FSerie_    Write FSerie_;
    property strCodCta : string              Read FCodCta    Write FCodCta;
    property strDtaCad : string              Read fGetDtaCad Write pSetDtaCad;
    property dtaDtaCad : TDateTime           Read FDtaCad    Write FDtaCad;
    property dtaDtaVen : Nullable<TDateTime> Read FDtaVen    Write FDtaVen;
    property strDtaVen : string              Read fGetDtaVen Write pSetDtaVen;
    property fltValDup : Double              Read FValDup    Write pSetValDup;
    property fltValOri : Double              Read FValOri    Write FValOri;
    property strPrevis : string              Read FPrevis    Write FPrevis;
    property strVeioBo : string              Read FVeioBo    Write FVeioBo;
    property strVeioNf : string              Read FVeioNf    Write FVeioNf;
    property strHist01 : Nullable<string>    Read FHist01    Write FHist01;
    property strHist02 : string              Read FHist02    Write FHist02;
    property strHisBai : Nullable<string>    Read FHisBai    Write FHisBai;
    property strPorBai : Nullable<string>    Read FPorBai    Write FPorBai;
    property strCtaBai : Nullable<string>    Read FCtaBai    Write FCtaBai;
    property strDocBai : Nullable<string>    Read fGetDocBai Write FDocBai;
    property strOpeBai : Nullable<string>    Read FOpeBai    Write FOpeBai;
    property strDtaPag : string              Read fGetDtaPag Write pSetDtaPag;
    property dtaDtaPag : Nullable<TDateTime> Read FDtaPag    Write FDtaPag;
    property dtaDtaEnv : Nullable<TDateTime> Read FDtaEnv    Write FDtaEnv;
    property fltValPag : Double              Read FValPag    Write FValPag;
    property fltValJur : Double              Read FValJur    Write FValJur;
    property fltValMul : Double              Read FValMul    Write FValMul;
    property fltValDes : Double              Read FValDes    Write FValDes;
    property strEmpGer : string              Read FEmpGer    Write FEmpGer;
    property dtaDtaBai : Nullable<TDateTime> Read FDtaBai    Write FDtaBai;
    property strCodEve : Nullable<string>    Read FCodEve    Write FCodEve;
    property fltDesSuj : Double              Read FDesSuj    Write FDesSuj;
    property fltJurSuj : Double              Read FJurSuj    Write FJurSuj;
    property fltMulSuj : Double              Read FMulSuj    Write FMulSuj;
    property strUsaChq : string              Read FUsaChq    Write FUsaChq;
    property strCodVen : Nullable<string>    Read FCodVen    Write FCodVen;
    property intTipDoc : Nullable<Integer>   Read FTipDoc    Write FTipDoc;
    property strNumDoc : string              Read FNumDoc    Write FNumDoc;
    property strCodVel : string              Read FCodVel    Write FCodVel;
    property strCodPor : Nullable<string>    Read FCodPor    Write FCodPor;
    property strCodBar : string              Read FCodBar    Write FCodBar;
    property strDtaEnv : string              Read FGetDtaEnv Write pSetDtaEnv;
    property strBcoEnv : Nullable<string>    Read FBcoEnv    Write FBcoEnv;
    property strTipDes : string              Read FTipDes    Write FTipDes;
    property strDeposi : string              Read FDeposi    Write FDeposi;
    property strEmpBai : Nullable<string>    Read fGetEmpBai Write FEmpBai;
    property intSeqCon : Nullable<Integer>   Read fGetSeqCon Write FSeqCon;
    property intRescai : Integer             Read FRescai    Write FRescai;
    property intRcxCon : Integer             Read FRcxCon    Write FRcxCon;
    property FltVendor : Double              Read FVendor    Write FVendor;
    property strPagAnt : string              Read FPagAnt    Write FPagAnt;
    property strNotTip : string              Read FNotTip    Write FNotTip;
    property strNotEnt : string              Read FNotEnt    Write FNotEnt;
    property strCtpCom : string              Read FCtpCom    Write FCtpCom;
    property strLinDig : string              Read FLinDig    Write FLinDig;
    property strDocTer : string              Read FDocTer    Write FDocTer;
    property strEspTer : string              Read FEspTer    Write FEspTer;
    property strEmpTer : string              Read FEmpTer    Write FEmpTer;
    property strCliTer : string              Read FCliTer    Write FCliTer;
    property strUsoCon : string              Read FUsoCon    Write FUsoCon;
    property strCompet : string              Read FCompet    Write FCompet;
    property strUsoCli : string              Read FUsoCli    Write FUsoCli;
    property strUsoDoc : string              Read FUsoDoc    Write FUsoDoc;
    property strUsoEsp : string              Read FUsoEsp    Write FUsoEsp;
    property strUsoEmp : string              Read FUsoEmp    Write FUsoEmp;
    property fltDinhei : Double              Read FDinhei    Write FDinhei;
    property fltChqAvi : Double              Read FChqAvi    Write FChqAvi;
    property fltOrdPag : Double              Read FOrdPag    Write FOrdPag;
    property fltRepChq : Double              Read FRepChq    Write FRepChq;
    property intSeqRCH : Integer             Read FSeqRCH    Write FSeqRCH;
    property fltJurAnt : Double              Read FJurAnt    Write FJurAnt;
    property fltMulAnt : Double              Read FMulAnt    Write FMulAnt;
    property fltDesAnt : Double              Read FDesAnt    Write FDesAnt;
    property fltValAnt : Double              Read FValAnt    Write FValAnt;
    property dtaDtaLib : Nullable<TDate>     Read FDtaLib    Write FDtaLib;
    property timHorLib : Nullable<TTime>     Read FHorLib    Write FHorLib;
    property strOpeLib : Nullable<String>    Read FOpeLib    Write FOpeLib;
    property intQtdDia : Integer             Read FQtdDia    Write FQtdDia;
    property strCodFor : String              Read fGetCodigoFornecedor;
    property strMotEst : Nullable<String>    Read FMotEst    Write FMotEst;
    property blnEhUmPG : Boolean             Read FEhUmPG    Write FEhUmPG;
    property strNomFrm : String              Read FNomFrm    Write FNomFrm;
    property strCodOpe : String              Read FCodOpe    Write FCodOpe;
    property strNumDDA : String              Read FNumDDA    Write FNumDDA;
    property intQ_Guia : Nullable<String>    Read FQ_Guia    Write FQ_Guia;
    property strCodRec : String              Read FCodRec    Write FCodRec;
    property strCodPrj : Nullable<String>    Read FCodPrj    Write FCodPrj;
    property strBcoFor : Nullable<string>    Read FBcoFor    Write FBcoFor;
    property FltOutEnt : Double              Read FOutEnt    Write FOutEnt;
    property strOpeApr : Nullable<String>    Read FOpeApr    Write FOpeApr;
    property strOperep : Nullable<String>    Read FOpeRep    Write FOpeRep;
    property strMotRep : Nullable<String>    Read FMotrep    Write FMotRep;
    property dtaDtaApr : Nullable<TDateTime> Read FDtaApr    Write FDtaApr;
    property dtaDtaRep : Nullable<TDateTime> Read FDtaRep    Write FDtaRep;
    property strNomFor : String              Read getNomFor;
    property strNomFan : String              Read getNomFan;
    property strForPix : Nullable<String>    Read FForPix    Write FForPix;
    property fltGrvOri : Double              Read FGrvOri    Write FGrvOri;
    property strNumLot : Nullable<String>    Read FNumLot    Write FNumLot;
    property dtaDtaLot : Nullable<TDateTime> Read FDtaLot    Write FDtaLot;
    property dtaPagLot : Nullable<TDateTime> Read FPagLot    Write FPagLot;
    property strCarLot : Nullable<String>    Read FCarLot    Write FCarLot;
    property strTipLot : Nullable<String>    Read FTipLot    Write FTipLot;
  end;

  [Entity]
  [Table('LOGCTP')]
  [UniqueKey('CTP_CODFOR, CTP_NUMDUP')]
  [Id('FAutInc', TIdGenerator.None)]
  TLogCtp = Class(TCadPag)
  private
    [Column('CTP_DESCRI')]
    FDescri: string;
    [Column('CTP_DTALOG')]
    FDtaLog: TDate;
    [Column('CTP_HORLOG')]
    FHorLog: TTime;
    [Column('CTP_OPELOG')]
    FOpeLog: String;
    [Column('CTP_NOMTAB')]
    FNomTab: String;
    [Column('CTP_NOMEXE')]
    FNomeExecutavel : String;
    [Column('CTP_DTAEXE')]
    FDataExecutavel : TDate;
    [Column('CTP_HOREXE')]
    FHoraExecutavel: TTime;
    [Column('CTP_VEREXE')]
    FVersaoExecutavel : String;
  public
    property strDescri       : string Read FDescri           Write FDescri;
    property dtaDtaLog       : TDate  Read FDtaLog           Write FDtaLog;
    property dtaHorLog       : TTime  Read FHorLog           Write FHorLog;
    property strOpeLog       : String Read FOpeLog           Write FOpeLog;
    property strNomTab       : String Read FNomTab           Write FNomTab;
    property NomeExecutavel  : String Read FNomeExecutavel   Write FNomeExecutavel;
    property DataExecutavel  : TDate  Read FDataExecutavel   Write FDataExecutavel;
    property HoraExecutavel  : TTime  Read FHoraExecutavel   Write FHoraExecutavel;
    property VersaoExecutavel: String Read FVersaoExecutavel Write FVersaoExecutavel;
  End;

  [Entity]
  [Table('DEL_CADPAG')]
  [UniqueKey('CTP_CODFOR, CTP_NUMDUP')]
  [Id('FAutInc', TIdGenerator.None)]
  TDelCadPag = Class(TCadPag)
  private
    [Column('OPEDEL')]
    FOpeDel: String;
    [Column('DTADEL')]
    FDtaDel: TDate;
    [Column('HORDEL')]
    FHorDel: TTime;
  public
    property strOpeDel: String Read FOpeDel Write FOpeDel;
    property dtaDtaDel: TDate  Read FDtaDel Write FDtaDel;
    property hraHorDel: TTime  Read FHorDel Write FHorDel;
  End;

implementation

{ TCadPag }

constructor TCadPag.Create;
begin
  FEhUmPG := False;
end;

function TCadPag.fGetCodigoFornecedor: string;
begin
  if Assigned(objCodFor) then
    Result := objCodFor.FOR_CODFOR;
end;

function TCadPag.fGetDocBai: Nullable<String>;
begin
  If Not FDocBai.HasValue Then Result := ''
  Else Result := FDocBai;
end;

function TCadPag.fGetDtaCad: string;
begin
  Result := FormatDateTime('dd/mm/yyyy', FDtaCad);
end;

function TCadPag.FGetDtaEnv: string;
begin
  If Not FDtaEnv.HasValue Then Result := ''
  Else Result := FormatDateTime('dd/mm/yyyy', FDtaEnv);
end;

function TCadPag.fGetDtaPag: string;
begin
  If Not FDtaPag.HasValue Then Result := ''
  Else Result := FormatDateTime('dd/mm/yyyy', FDtaPag);
end;

function TCadPag.fGetDtaVen: string;
begin
  If Not FDtaVen.HasValue Then Result := ''
  Else Result := FormatDateTime('dd/mm/yyyy', FDtaVen);
end;

function TCadPag.fGetEmpBai: Nullable<String>;
begin
  If Not FEmpBai.HasValue Then Result := ''
  Else Result := FEmpBai;
end;

function TCadPag.fGetSeqBai: Nullable<Integer>;
begin
  If Not FSeqBai.HasValue Then Result := 0
  Else Result := FSeqBai;
end;

function TCadPag.fGetSeqCon: Nullable<Integer>;
begin
  If Not FSeqCon.HasValue Then Result := 0
  Else Result := FSeqCon;
end;

procedure TCadPag.pSetCodEmp(const Value: string);
begin
  If fEmptyStr(Value) Then
    raise Exception.Create('Código da empresa não pode estar vazio.')
  Else
    FCodEmp := Value;
end;

procedure TCadPag.pSetDtaCad(const Value: string);
begin
  If fEmptyStr(Value) Then
    raise Exception.Create('Data de cadastro não pode estar vazia.')
  Else
    FDtaCad := StrToDate(Value);
end;

procedure TCadPag.pSetDtaEnv(const Value: string);
begin
  If fEmptyStr(Value) Then
    FDtaEnv := 0
  Else
    FDtaEnv := StrToDate(Value);
end;

procedure TCadPag.pSetDtaPag(const Value: string);
begin
  If fEmptyStr(Value) Then
    FDtaPag := 0
  Else
    FDtaPag := StrToDate(Value);
end;

procedure TCadPag.pSetDtaVen(const Value: string);
begin
  If Length(Value) = 0 Then
    raise Exception.Create('Data de vencimento não pode estar vazia.')
  Else
    FDtaVen := StrToDate(Value);
end;

procedure TCadPag.pSetValDup(const Value: Double);
begin
  If fEmptyStr(FloatToStr(Value)) Then
    raise Exception.Create('Valor do documento não pode estar vazio.')
  Else
    FValDup := Value;
end;

function TCadPag.getCodFor: TCadFor;
begin
  result := FCodFor.Value;
end;

function TCadPag.getNomFan: String;
begin
  Result := FCodFor.Value.FOR_NOMFAN;
end;

function TCadPag.getNomFor: String;
begin
  Result := FCodFor.Value.FOR_NOMFOR;
end;

procedure TCadPag.setCodFor(const Value: TCadFor);
begin
  FCodFor.Value := Value;
end;

end.

