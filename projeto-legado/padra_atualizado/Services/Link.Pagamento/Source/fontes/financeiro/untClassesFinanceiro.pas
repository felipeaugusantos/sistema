unit untClassesFinanceiro;

interface

type
  TLogBan = Class
  private
    FCTB_SEQLAN: string;
    FAUTOINCREM: string;
  public
    property strAutInc: string read FAUTOINCREM write FAUTOINCREM;
    property strSeqLan: string read FCTB_SEQLAN write FCTB_SEQLAN;
    function fGetOrigem: String; virtual; abstract;
  End;

  TBanCtr = Class(TLogBan)
  private
    FCTR_NUMDUP: string;
    FCTR_PARCEL: string;
    FCTR_ESPDOC: string;
    FCTR_CODEMP: string;
    FCTR_SEQBAI: integer;
    FCTR_CODCLI: string;
    FCTR_HIST01: string;
    FCTR_HIST02: string;
    FCTR_VALREC: double;
    FCTR_VALJUR: double;
    FCTR_VALDES: double;
    FCTR_VALPRI: double;
    //function getCadCli: TCadCli;
    function getClient: String;
    function getDocume: String;
  public
    property strNumDup: string    read FCTR_NUMDUP write FCTR_NUMDUP;
    property strParcel: string    read FCTR_PARCEL write FCTR_PARCEL;
    property strEspDoc: string    read FCTR_ESPDOC write FCTR_ESPDOC;
    property strCodEmp: string    read FCTR_CODEMP write FCTR_CODEMP;
    property intSeqBai: integer   read FCTR_SEQBAI write FCTR_SEQBAI;
    property strCodCli: string    read FCTR_CODCLI write FCTR_CODCLI;
    property strHist01: string    read FCTR_HIST01 write FCTR_HIST01;
    property strHist02: string    read FCTR_HIST02 write FCTR_HIST02;
    property fltValRec: double    read FCTR_VALREC write FCTR_VALREC;
    property fltValJur: double    read FCTR_VALJUR write FCTR_VALJUR;
    property fltValDes: double    read FCTR_VALDES write FCTR_VALDES;
    property fltValPri: double    read FCTR_VALPRI write FCTR_VALPRI;
    //property objCadCli: TCadCli             read getCadCli;
    property strClient: String              read getClient;
    property strDocume: String              read getDocume;
    function fGetOrigem: String; override;
  end;

  TLogBanDS = Class
  private
    FAUTOINCREM,
    FCTB_SEQLAN: String;
  protected
    function RetornaSQLInsert: String; virtual;

    function getOperad: string; virtual;
    function getOrigem: string; virtual;
    function getTabela: string; virtual;
  public
    property strAutInc: string    read FAUTOINCREM write FAUTOINCREM;
    property strSeqLan: String    read FCTB_SEQLAN write FCTB_SEQLAN;
    property strOperad: string    read getOperad;
    property fGetOrigem: string   read getOrigem;
    property strTabela: string    read getTabela;
  End;


implementation

uses SysUtils ;

{ TBanCtr }

function TBanCtr.fGetOrigem: String;
begin
  Result := 'CTR';
end;

function TBanCtr.getClient: String;
begin

end;

function TBanCtr.getDocume: String;
begin
  Result := FCTR_NUMDUP + '-' + FCTR_PARCEL + '-' + FCTR_ESPDOC + '-' + FCTR_CODEMP + '-Seq:' + IntToStr(FCTR_SEQBAI);
end;

{ TLogBanDS }

function TLogBanDS.getOperad: string;
begin
  //criar no filho
end;

function TLogBanDS.getOrigem: string;
begin
  //criar no filho
end;

function TLogBanDS.getTabela: string;
begin
  //criar no filho
end;

function TLogBanDS.RetornaSQLInsert: String;
begin
  //criar no filho
end;

end.
