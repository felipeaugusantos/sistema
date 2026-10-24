unit untTBanChq;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  Classes, untLogBan, untTCadCli, untTCadFor;

type
  [Entity]
  [Table('BANCHQ')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TBanChq = Class(TLogBan)
  private
    [Column('CHQ_CODBCO', [], 3)]
    FCHQ_CODBCO: Nullable<string>;

    [Column('CHQ_NUMAGE', [], 5)]
    FCHQ_NUMAGE: Nullable<string>;

    [Column('CHQ_CONCOR', [], 12)]
    FCHQ_CONCOR: Nullable<string>;

    [Column('CHQ_NUMCHQ', [], 10)]
    FCHQ_NUMCHQ: Nullable<string>;

    [Column('CHQ_CODCLI', [], 8)]
    FCHQ_CODCLI: Nullable<string>;

    [Column('CHQ_NOMEMI', [], 40)]
    FCHQ_NOMEMI: Nullable<string>;

    [Column('CHQ_VALCHQ', [], 12, 2)]
    FCHQ_VALCHQ: Nullable<double>;

    [Column('CHQ_HIST01', [], 50)]
    FCHQ_HIST01: Nullable<string>;

    [Column('CHQ_HIST02', [], 50)]
    FCHQ_HIST02: Nullable<string>;

    [Column('CHQ_CODEMP', [], 3)]
    FCHQ_CODEMP: Nullable<string>;

    [Column('CHQ_CODFOR', [], 8)]
    FCHQ_CODFOR: Nullable<string>;

    {****************************************************************}
    {* Foi comentado o atributo FCTB_SEQLAN pois o mesmo conflitava *}
    {* com o atributo da classe pai com mesmo nome.                 *}
    {***********************************07/03/2018****WS**REQ.93054**}
//    [Column('CTB_SEQLAN', [], 13)]
//    FCTB_SEQLAN: Nullable<string>;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('CHQ_CODCLI', [], 'CLI_CODCLI')]
    FCadCli : Proxy<TCadCli>;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('CHQ_CODFOR', [], 'FOR_CODFOR')]
    FCadFor : Proxy<TCadFor>;

    function getCadCli: TCadCli;
    function getClient: String;
    procedure setCadCli(const Value: TCadCli);
    function getFornec: String;
    function getCadFor: TCadFor;
    procedure setCadFor(const Value: TCadFor);
  public
    property strCodBco: Nullable<string>    read FCHQ_CODBCO write FCHQ_CODBCO;
    property strNumAge: Nullable<string>    read FCHQ_NUMAGE write FCHQ_NUMAGE;
    property strConCor: Nullable<string>    read FCHQ_CONCOR write FCHQ_CONCOR;
    property strNumChq: Nullable<string>    read FCHQ_NUMCHQ write FCHQ_NUMCHQ;
    property strCodCli: Nullable<string>    read FCHQ_CODCLI write FCHQ_CODCLI;
    property strNomEmi: Nullable<string>    read FCHQ_NOMEMI write FCHQ_NOMEMI;
    property fltValChq: Nullable<double>    read FCHQ_VALCHQ write FCHQ_VALCHQ;
    property strHist01: Nullable<string>    read FCHQ_HIST01 write FCHQ_HIST01;
    property strHist02: Nullable<string>    read FCHQ_HIST02 write FCHQ_HIST02;
    property strCodEmp: Nullable<string>    read FCHQ_CODEMP write FCHQ_CODEMP;
    property strCodFor: Nullable<string>    read FCHQ_CODFOR write FCHQ_CODFOR;
//    property strSeqLan: Nullable<string>    read FCTB_SEQLAN write FCTB_SEQLAN;
    property objCadCli: TCadCli             read getCadCli   write setCadCli;
    property objCadFor: TCadFor             read getCadFor   write setCadFor;
    property strClient: String              read getClient;
    property strFornec: String              read getFornec;
    function fGetOrigem: String; override;
  end;

implementation

uses untFuncoesSimples;

{ TBanChq }

function TBanChq.fGetOrigem: String;
begin
  Result := 'CHQ';
end;

function TBanChq.getCadCli: TCadCli;
begin
  Result := FCadCli.Value;
end;

function TBanChq.getCadFor: TCadFor;
begin
  Result := FCadFor.Value;
end;

function TBanChq.getClient: String;
begin
  If FCHQ_CODCLI.HasValue Then
    Result := fValN(FCHQ_CODCLI) + ' - ' + fValN(objCadCli.strNomCli)
  Else
    Result := ''
end;

function TBanChq.getFornec: String;
begin
  If FCHQ_CODFOR.HasValue Then
    Result := fValN(FCHQ_CODFOR) + ' - ' + fValN(objCadFor.FOR_NOMFOR)
  Else
    Result := '';
end;

procedure TBanChq.setCadCli(const Value: TCadCli);
begin
  FCadCli.Value := Value;
end;

procedure TBanChq.setCadFor(const Value: TCadFor);
begin
  FCadFor.Value := Value;
end;

end.
