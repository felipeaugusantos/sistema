unit untTCadFor;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADFOR')]
  [UniqueKey('FOR_CODFOR')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadFor = class
  private
    [Column('FOR_CODFOR', [TColumnProp.Required], 8)]
    FFOR_CODFOR: string;

    [Column('FOR_CODATI', [TColumnProp.Required], 3)]
    FFOR_CODATI: string;

    [Column('FOR_CODCID', [], 5)]
    FFOR_CODCID: Nullable<string>;

    [Column('FOR_NOMFOR', [], 60)]
    FFOR_NOMFOR: Nullable<string>;

    [Column('FOR_DTACAD', [])]
    FFOR_DTACAD: Nullable<TDateTime>;

    [Column('FOR_ULTALT', [])]
    FFOR_ULTALT: Nullable<TDateTime>;

    [Column('FOR_DTAALT', [])]
    FFOR_DTAALT: Nullable<TDateTime>;

    [Column('FOR_NOMFAN', [], 60)]
    FFOR_NOMFAN: Nullable<string>;

    [Column('FOR_ENDERE', [], 60)]
    FFOR_ENDERE: Nullable<string>;

    [Column('FOR_BAIRRO', [], 60)]
    FFOR_BAIRRO: Nullable<string>;

    [Column('FOR_C_E_P_', [], 9)]
    FFOR_C_E_P_: Nullable<string>;

    [Column('FOR_CGCCPF', [], 1)]
    FFOR_CGCCPF: Nullable<string>;

    [Column('FOR_C_G_C_', [], 18)]
    FFOR_C_G_C_: Nullable<string>;

    [Column('FOR_I_E_S_', [], 18)]
    FFOR_I_E_S_: Nullable<string>;

    [Column('FOR_CONTAT', [], 50)]
    FFOR_CONTAT: Nullable<string>;

    [Column('FOR_CAIPOS', [], 5)]
    FFOR_CAIPOS: Nullable<string>;

    [Column('FOR_FONE01', [], 15)]
    FFOR_FONE01: Nullable<string>;

    [Column('FOR_FONE02', [], 15)]
    FFOR_FONE02: Nullable<string>;

    [Column('FOR_F_A_X_', [], 15)]
    FFOR_F_A_X_: Nullable<string>;

    [Column('FOR_EMAIL_', [], 150)]
    FFOR_EMAIL_: Nullable<string>;

    [Column('FOR_EMAIL2', [], 50)]
    FFOR_EMAIL2: Nullable<string>;

    [Column('FOR_EMAIL3', [], 50)]
    FFOR_EMAIL3: Nullable<string>;

    [Column('FOR_HOMEPA', [], 50)]
    FFOR_HOMEPA: Nullable<string>;

    [Column('FOR_CNDPAG', [], 74)]
    FFOR_CNDPAG: Nullable<string>;

    [Column('FOR_CODEMP', [TColumnProp.Required], 3)]
    FFOR_CODEMP: string;

    [Column('AUTOINCREM', [], 20)]
    FAUTOINCREM: Nullable<string>;

    [Column('FOR_QTDETI', [])]
    FFOR_QTDETI: Nullable<integer>;

    [Column('FOR_PERCOM', [], 12, 2)]
    FFOR_PERCOM: Nullable<double>;

    [Column('FOR_NUMRG_', [], 15)]
    FFOR_NUMRG_: Nullable<string>;

    [Column('FOR_MATREV', [], 1)]
    FFOR_MATREV: Nullable<string>;

    [Column('FOR_OBSERV', [TColumnProp.Lazy])]
    FFOR_OBSERV: TBlob;

    [Column('FOR_CODTRA', [], 5)]
    FFOR_CODTRA: Nullable<string>;

    [Column('FOR_CONCON', [], 20)]
    FFOR_CONCON: Nullable<string>;

    [Column('FOR_CODCTA', [], 7)]
    FFOR_CODCTA: Nullable<string>;

    [Column('FOR_CTATRA', [], 7)]
    FFOR_CTATRA: Nullable<string>;

    [Column('FOR_CODVEL', [], 20)]
    FFOR_CODVEL: Nullable<string>;

    [Column('FOR_0800__', [], 12)]
    FFOR_0800__: Nullable<string>;

    [Column('FOR_STATUS', [], 1)]
    FFOR_STATUS: Nullable<string>;

    [Column('FOR_ENDNUM', [], 10)]
    FFOR_ENDNUM: Nullable<string>;

    [Column('FOR_ENDCOM', [], 50)]
    FFOR_ENDCOM: Nullable<string>;

    [Column('FOR_SIMPAU', [], 1)]
    FFOR_SIMPAU: Nullable<string>;

    [Column('FOR_NUMCEL', [], 15)]
    FFOR_NUMCEL: Nullable<string>;

    [Column('FOR_PERFCX', [], 12, 2)]
    FFOR_PERFCX: Nullable<double>;

    [Column('FOR_VLRED2', [], 1)]
    FFOR_VLRED2: Nullable<string>;

    [Column('FOR_EMAPED', [], 150)]
    FFOR_EMAPED: Nullable<string>;

    [Column('FOR_CODOPE', [], 3)]
    FFOR_CODOPE: Nullable<string>;

    [Column('FOR_EMAIL', [], 50)]
    FFOR_EMAIL: Nullable<string>;

    [Column('FOR_DESVIS', [], 12, 2)]
    FFOR_DESVIS: Nullable<double>;

    [Column('FOR_CARPAG', [])]
    FFOR_CARPAG: Nullable<integer>;

    [Column('FOR_ACOOBJ', [], 1)]
    FFOR_ACOOBJ: Nullable<string>;

    [Column('FOR_REVIST', [], 1)]
    FFOR_REVIST: Nullable<string>;

    [Column('FOR_MINORC', [], 12, 2)]
    FFOR_MINORC: Nullable<double>;

    [Column('FOR_DIAENT', [])]
    FFOR_DIAENT: Nullable<integer>;

    [Column('FOR_ZONFRA', [], 1)]
    FFOR_ZONFRA: Nullable<string>;

    [Column('FOR_DESMEM', [], 1)]
    FFOR_DESMEM: Nullable<string>;
  public
    property FOR_CODFOR: string              read FFOR_CODFOR write FFOR_CODFOR;
    property FOR_CODATI: string              read FFOR_CODATI write FFOR_CODATI;
    property FOR_CODCID: Nullable<string>    read FFOR_CODCID write FFOR_CODCID;
    property FOR_NOMFOR: Nullable<string>    read FFOR_NOMFOR write FFOR_NOMFOR;
    property FOR_DTACAD: Nullable<TDateTime> read FFOR_DTACAD write FFOR_DTACAD;
    property FOR_ULTALT: Nullable<TDateTime> read FFOR_ULTALT write FFOR_ULTALT;
    property FOR_DTAALT: Nullable<TDateTime> read FFOR_DTAALT write FFOR_DTAALT;
    property FOR_NOMFAN: Nullable<string>    read FFOR_NOMFAN write FFOR_NOMFAN;
    property FOR_ENDERE: Nullable<string>    read FFOR_ENDERE write FFOR_ENDERE;
    property FOR_BAIRRO: Nullable<string>    read FFOR_BAIRRO write FFOR_BAIRRO;
    property FOR_C_E_P_: Nullable<string>    read FFOR_C_E_P_ write FFOR_C_E_P_;
    property FOR_CGCCPF: Nullable<string>    read FFOR_CGCCPF write FFOR_CGCCPF;
    property FOR_C_G_C_: Nullable<string>    read FFOR_C_G_C_ write FFOR_C_G_C_;
    property FOR_I_E_S_: Nullable<string>    read FFOR_I_E_S_ write FFOR_I_E_S_;
    property FOR_CONTAT: Nullable<string>    read FFOR_CONTAT write FFOR_CONTAT;
    property FOR_CAIPOS: Nullable<string>    read FFOR_CAIPOS write FFOR_CAIPOS;
    property FOR_FONE01: Nullable<string>    read FFOR_FONE01 write FFOR_FONE01;
    property FOR_FONE02: Nullable<string>    read FFOR_FONE02 write FFOR_FONE02;
    property FOR_F_A_X_: Nullable<string>    read FFOR_F_A_X_ write FFOR_F_A_X_;
    property FOR_EMAIL_: Nullable<string>    read FFOR_EMAIL_ write FFOR_EMAIL_;
    property FOR_EMAIL2: Nullable<string>    read FFOR_EMAIL2 write FFOR_EMAIL2;
    property FOR_EMAIL3: Nullable<string>    read FFOR_EMAIL3 write FFOR_EMAIL3;
    property FOR_HOMEPA: Nullable<string>    read FFOR_HOMEPA write FFOR_HOMEPA;
    property FOR_CNDPAG: Nullable<string>    read FFOR_CNDPAG write FFOR_CNDPAG;
    property FOR_CODEMP: string              read FFOR_CODEMP write FFOR_CODEMP;
    property AUTOINCREM: Nullable<string>    read FAUTOINCREM write FAUTOINCREM;
    property FOR_QTDETI: Nullable<integer>   read FFOR_QTDETI write FFOR_QTDETI;
    property FOR_PERCOM: Nullable<double>    read FFOR_PERCOM write FFOR_PERCOM;
    property FOR_NUMRG_: Nullable<string>    read FFOR_NUMRG_ write FFOR_NUMRG_;
    property FOR_MATREV: Nullable<string>    read FFOR_MATREV write FFOR_MATREV;
    property FOR_OBSERV: TBlob               read FFOR_OBSERV write FFOR_OBSERV;
    property FOR_CODTRA: Nullable<string>    read FFOR_CODTRA write FFOR_CODTRA;
    property FOR_CONCON: Nullable<string>    read FFOR_CONCON write FFOR_CONCON;
    property FOR_CODCTA: Nullable<string>    read FFOR_CODCTA write FFOR_CODCTA;
    property FOR_CTATRA: Nullable<string>    read FFOR_CTATRA write FFOR_CTATRA;
    property FOR_CODVEL: Nullable<string>    read FFOR_CODVEL write FFOR_CODVEL;
    property FOR_0800__: Nullable<string>    read FFOR_0800__ write FFOR_0800__;
    property FOR_STATUS: Nullable<string>    read FFOR_STATUS write FFOR_STATUS;
    property FOR_ENDNUM: Nullable<string>    read FFOR_ENDNUM write FFOR_ENDNUM;
    property FOR_ENDCOM: Nullable<string>    read FFOR_ENDCOM write FFOR_ENDCOM;
    property FOR_SIMPAU: Nullable<string>    read FFOR_SIMPAU write FFOR_SIMPAU;
    property FOR_NUMCEL: Nullable<string>    read FFOR_NUMCEL write FFOR_NUMCEL;
    property FOR_PERFCX: Nullable<double>    read FFOR_PERFCX write FFOR_PERFCX;
    property FOR_VLRED2: Nullable<string>    read FFOR_VLRED2 write FFOR_VLRED2;
    property FOR_EMAPED: Nullable<string>    read FFOR_EMAPED write FFOR_EMAPED;
    property FOR_CODOPE: Nullable<string>    read FFOR_CODOPE write FFOR_CODOPE;
    property FOR_EMAIL : Nullable<string>     read FFOR_EMAIL  write FFOR_EMAIL;
    property FOR_DESVIS: Nullable<double>    read FFOR_DESVIS write FFOR_DESVIS;
    property FOR_CARPAG: Nullable<integer>   read FFOR_CARPAG write FFOR_CARPAG;
    property FOR_ACOOBJ: Nullable<string>    read FFOR_ACOOBJ write FFOR_ACOOBJ;
    property FOR_REVIST: Nullable<string>    read FFOR_REVIST write FFOR_REVIST;
    property FOR_MINORC: Nullable<double>    read FFOR_MINORC write FFOR_MINORC;
    property FOR_DIAENT: Nullable<integer>   read FFOR_DIAENT write FFOR_DIAENT;
    property FOR_ZONFRA: Nullable<string>    read FFOR_ZONFRA write FFOR_ZONFRA;
    property FOR_DESMEM: Nullable<string>    read FFOR_DESMEM write FFOR_DESMEM;
  end;

implementation

end.
