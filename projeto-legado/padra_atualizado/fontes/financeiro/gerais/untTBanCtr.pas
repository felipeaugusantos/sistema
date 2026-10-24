unit untTBanCtr;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  Classes, untLogBan, untTCadCli, untTCadCliRepository;

type
  [Entity]
  [Table('BANCTR')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TBanCtr = Class(TLogBan)
  private
    [Column('CTR_NUMDUP', [], 12)]
    FCTR_NUMDUP: Nullable<string>;

    [Column('CTR_PARCEL', [], 3)]
    FCTR_PARCEL: Nullable<string>;

    [Column('CTR_ESPDOC', [], 2)]
    FCTR_ESPDOC: Nullable<string>;

    [Column('CTR_CODEMP', [], 3)]
    FCTR_CODEMP: Nullable<string>;

    [Column('CTR_SEQBAI', [])]
    FCTR_SEQBAI: Nullable<integer>;

    [Column('CTR_CODCLI', [], 8)]
    FCTR_CODCLI: Nullable<string>;

    [Column('CTR_HIST01', [], 40)]
    FCTR_HIST01: Nullable<string>;

    [Column('CTR_HIST02', [], 40)]
    FCTR_HIST02: Nullable<string>;

    [Column('CTR_VALREC', [], 12, 2)]
    FCTR_VALREC: Nullable<double>;

    [Column('CTR_VALJUR', [], 12, 2)]
    FCTR_VALJUR: Nullable<double>;

    [Column('CTR_VALDES', [], 12, 2)]
    FCTR_VALDES: Nullable<double>;

    [Column('CTR_VALPRI', [], 12, 2)]
    FCTR_VALPRI: Nullable<double>;

    [Column('CTR_ESTORN', [], 1)]
    FCTR_ESTORN: Nullable<string>;

    function getCadCli: TCadCli;
    function getClient: String;
    function getDocume: String;
  public
    property strNumDup: Nullable<string>    read FCTR_NUMDUP write FCTR_NUMDUP;
    property strParcel: Nullable<string>    read FCTR_PARCEL write FCTR_PARCEL;
    property strEspDoc: Nullable<string>    read FCTR_ESPDOC write FCTR_ESPDOC;
    property strCodEmp: Nullable<string>    read FCTR_CODEMP write FCTR_CODEMP;
    property intSeqBai: Nullable<integer>   read FCTR_SEQBAI write FCTR_SEQBAI;
    property strCodCli: Nullable<string>    read FCTR_CODCLI write FCTR_CODCLI;
    property strHist01: Nullable<string>    read FCTR_HIST01 write FCTR_HIST01;
    property strHist02: Nullable<string>    read FCTR_HIST02 write FCTR_HIST02;
    property fltValRec: Nullable<double>    read FCTR_VALREC write FCTR_VALREC;
    property fltValJur: Nullable<double>    read FCTR_VALJUR write FCTR_VALJUR;
    property fltValDes: Nullable<double>    read FCTR_VALDES write FCTR_VALDES;
    property fltValPri: Nullable<double>    read FCTR_VALPRI write FCTR_VALPRI;
    property strEstorn: Nullable<string>    read FCTR_ESTORN write FCTR_ESTORN;
    property objCadCli: TCadCli             read getCadCli;
    property strClient: String              read getClient;
    property strDocume: String              read getDocume;
    function fGetOrigem: String; override;
  end;

implementation

uses untFuncoesSimples;

{ TBanCtr }

function TBanCtr.fGetOrigem: String;
begin
  Result := 'CTR';
  If strEspDoc = 'CC' Then
  Begin
     If fVerificaRegraCCOrigem(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli) Then
        Result := 'CRC';
  End
  Else
  If strEspDoc = 'PD' Then
  Begin
     If fVerificaseEhPedido(strNumDup, strEspDoc, strCodEmp, strCodCli) Then
        Result := 'ADT';
  End
  Else
     Result := 'CTR';
end;

function TBanCtr.getCadCli: TCadCli;
begin
  Result := TCadCliRepository.Create().fRetCadCli(FCTR_CODCLI);
end;

function TBanCtr.getClient: String;
begin
  If FCTR_CODCLI.HAsValue Then
    Result := fValN(FCTR_CODCLI) + ' - ' + fValN(objCadCli.strNomCli)
  Else
    Result := '';
end;

function TBanCtr.getDocume: String;
begin
  Result := fValN(FCTR_NUMDUP) + '-' + fValN(FCTR_PARCEL) + '-' + fValN(FCTR_ESPDOC) + '-' + fValN(FCTR_CODEMP) + '-Seq:' + IntToStr(fValN(FCTR_SEQBAI));
end;

end.
