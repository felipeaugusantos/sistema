unit untTFecFin;

interface

Uses Classes, DateUtils, StrUtils, SysUtils, Aurelius.Mapping.Attributes;

Type

  [Entity]
  [Table('FECFIN')]
  [Id('FAutoIncremento', TIdGenerator.None)]
  TFecFin = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required])]
    FAutoIncremento : string;
    [Column('FEC_CODEMP')]
    FCodigoEmpresa : string;
    [Column('FEC_CODOPE')]
    FCodigoOperador : string;
    [Column('FEC_DTAFEC')]
    FData : TDate;
    [Column('FEC_DTAREF')]
    FDataReferenciada : TDate;
    [Column('FEC_HORFEC')]
    FHora : TTime;
  public
    property AutoIncremento   : string Read FAutoIncremento    Write FAutoIncremento;
    property CodigoEmpresa    : string Read FCodigoEmpresa     Write FCodigoEmpresa;
    property CodigoOperador   : string Read FCodigoOperador    Write FCodigoOperador;
    property Data             : TDate  Read FData              Write FData;
    property DataReferenciada : TDate  Read FDataReferenciada  Write FDataReferenciada;
    property Hora             : TTime  Read FHora              Write FHora;
  end;

  [Entity]
  [Table('LOGFIN')]
  [Id('FAutoIncremento', TIdGenerator.None)]
  TLogFin = Class(TFecFin)
  private
    [Column('FEC_DTALOG')]
    FDataLog: TDate;
    [Column('FEC_DESCRI')]
    FDescricao : string;
    [Column('FEC_HORLOG')]
    FHoraLog: TTime;
    [Column('FEC_NOMFRM')]
    FNomeFormulario : string;
    [Column('FEC_NOMTAB')]
    FNomeTabela: String;
    [Column('FEC_OPELOG')]
    FOperadorLog: String;
  public
    property DataLog        : TDate  Read FDataLog        Write FDataLog;
    property Descricao      : string Read FDescricao      Write FDescricao;
    property HoraLog        : TTime  Read FHoraLog        Write FHoraLog;
    property NomeFormulario : string Read FNomeFormulario Write FNomeFormulario;
    property NomeTabela     : String Read FNomeTabela     Write FNomeTabela;
    property OperadorLog    : String Read FOperadorLog    Write FOperadorLog;
  End;

  [Entity]
  [Table('DEL_FECFIN')]
  [Id('FAutoIncremento', TIdGenerator.None)]
  TDelFecFin = Class(TFecFin)
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

end.
