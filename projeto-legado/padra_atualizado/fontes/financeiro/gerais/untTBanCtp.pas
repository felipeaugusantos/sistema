unit untTBanCtp;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  Classes, untLogBan, untTCadFor, untTCadForRepository, untTCadCta, untTCadCtaRepository;

type
  [Entity]
  [Table('BANCTP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TBanCtp = Class(TLogBan)
  private
    [Column('CTP_NUMDUP', [], 12)]
    FCTP_NUMDUP: Nullable<string>;

    [Column('CTP_PARCEL', [], 1)]
    FCTP_PARCEL: Nullable<string>;

    [Column('CTP_SERIE_', [], 3)]
    FCTP_SERIE_: Nullable<string>;

    [Column('CTP_CODEMP', [], 3)]
    FCTP_CODEMP: Nullable<string>;

    [Column('CTP_SEQBAI', [])]
    FCTP_SEQBAI: Nullable<integer>;

    [Column('CTP_CODFOR', [], 8)]
    FCTP_CODFOR: Nullable<string>;

    [Column('CTP_HIST01', [TColumnProp.Lazy])]
    FCTP_HIST01: Nullable<string>;

    [Column('CTP_HIST02', [], 50)]
    FCTP_HIST02: Nullable<string>;

    [Column('CTP_VALPAG', [], 12, 2)]
    FCTP_VALPAG: Nullable<double>;

    [Column('CTP_CODCTA', [], 7)]
    FCTP_CODCTA: Nullable<string>;

    [Column('CTP_EMPCTA', [], 3)]
    FCTP_EMPCTA: Nullable<string>;

    [Column('CTP_DINHEI', [], 12, 2)]
    FCTP_DINHEI: Nullable<double>;

    [Column('CTP_CHQEMI', [], 12, 2)]
    FCTP_CHQEMI: Nullable<double>;

    [Column('CTP_CHQREP', [], 12, 2)]
    FCTP_CHQREP: Nullable<double>;

    [Column('CTP_ORDPAG', [], 12, 2)]
    FCTP_ORDPAG: Nullable<double>;

    [Column('CTP_VALJUR', [], 12, 2)]
    FCTP_VALJUR: Nullable<double>;

    [Column('CTP_VALMUL', [], 12, 2)]
    FCTP_VALMUL: Nullable<double>;

    [Column('CTP_VALDES', [], 12, 2)]
    FCTP_VALDES: Nullable<double>;

    [Column('CTP_VALPRI', [], 12, 2)]
    FCTP_VALPRI: Nullable<double>;

    function getCadFor: TCadFor;
    function getCadCta: TCadCta;
    function getDocume: String;
    function getConta_: String;
    function getFornec: String;
  public
    property strNumDup: Nullable<string>    read FCTP_NUMDUP write FCTP_NUMDUP;
    property strParcel: Nullable<string>    read FCTP_PARCEL write FCTP_PARCEL;
    property strSerie_: Nullable<string>    read FCTP_SERIE_ write FCTP_SERIE_;
    property strCodEmp: Nullable<string>    read FCTP_CODEMP write FCTP_CODEMP;
    property intSeqBai: Nullable<integer>   read FCTP_SEQBAI write FCTP_SEQBAI;
    property strCodFor: Nullable<string>    read FCTP_CODFOR write FCTP_CODFOR;
    property strHist01: Nullable<string>    read FCTP_HIST01 write FCTP_HIST01;
    property strHist02: Nullable<string>    read FCTP_HIST02 write FCTP_HIST02;
    property fltValPag: Nullable<double>    read FCTP_VALPAG write FCTP_VALPAG;
    property strCodCta: Nullable<string>    read FCTP_CODCTA write FCTP_CODCTA;
    property strEmpCta: Nullable<string>    read FCTP_EMPCTA write FCTP_EMPCTA;
    property fltDinhei: Nullable<double>    read FCTP_DINHEI write FCTP_DINHEI;
    property fltChqEmi: Nullable<double>    read FCTP_CHQEMI write FCTP_CHQEMI;
    property fltChqRep: Nullable<double>    read FCTP_CHQREP write FCTP_CHQREP;
    property fltOrdPag: Nullable<double>    read FCTP_ORDPAG write FCTP_ORDPAG;
    property fltValJur: Nullable<double>    read FCTP_VALJUR write FCTP_VALJUR;
    property fltValMul: Nullable<double>    read FCTP_VALMUL write FCTP_VALMUL;
    property fltValDes: Nullable<double>    read FCTP_VALDES write FCTP_VALDES;
    property fltValPri: Nullable<double>    read FCTP_VALPRI write FCTP_VALPRI;
    property objCadFor: TCadFor             read getCadFor;
    property objCadCta: TCadCta             read getCadCta;
    property strDocume: String              read getDocume;
    property strFornec: String              read getFornec;
    property strConta_: String              read getConta_;
    function fGetOrigem: String; override;
  end;

implementation

uses untFuncoesSimples;

{ TBanCtp }

function TBanCtp.fGetOrigem: String;
begin
  Result := 'CTP';
end;

function TBanCtp.getCadCta: TCadCta;
begin
  result := TCadCtaRepository.Create().fRetCadCta(FCTP_CODCTA);
end;

function TBanCtp.getCadFor: TCadFor;
begin
  result := TCadForRepository.Create().fRetCadFor(FCTP_CODFOR);
end;

function TBanCtp.getConta_: String;
begin
  Result := fValN(FCTP_CODCTA) + ' - ' + fValN(objCadCta.strDesCta);
end;

function TBanCtp.getDocume: String;
begin
  Result := fValN(FCTP_NUMDUP) + '-' + IIF(Not fEmptyStr(fValN(FCTP_SERIE_)), '-' + fValN(FCTP_SERIE_), '') + fValN(FCTP_PARCEL) + '-' + fValN(FCTP_CODEMP) + '-Seq:' + IntToStr(fValN(FCTP_SEQBAI));
end;

function TBanCtp.getFornec: String;
begin
  If FCTP_CODFOR.HasValue Then
    Result := fValN(FCTP_CODFOR) + ' - ' + fValN(objCadFor.FOR_NOMFOR)
  Else
    Result := '';
end;

end.
