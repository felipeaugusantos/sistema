unit DominioSistemas.DTO.DomPro;

interface

type
  TDOMPRO = class
  private
    FCodEmp: string;
    FTipCon: string;
    FAcesso: string;
    FTipFC: string;
    FStatus: string;
    FCodOpe: string;
    FDtProc: TDate;
    FHrProc: TTime;
    FProtoc: string;
    FDtaEnt: TDate;
    FStatNf: string;
  public
    property CodEmp: string read FCodEmp write FCodEmp;
    property TipCon: string read FTipCon write FTipCon;
    property Acesso: string read FAcesso write FAcesso;
    property TipFC: string read FTipFC write FTipFC;
    property Status: string read FStatus write FStatus;
    property CodOpe: string read FCodOpe write FCodOpe;
    property DtProc: TDate read FDtProc write FDtProc;
    property HrProc: TTime read FHrProc write FHrProc;
    property Protoc: string read FProtoc write FProtoc;
    property DtaEnt: TDate read FDtaEnt write FDtaEnt;
    property StatNf: String read FStatNf write FStatNf;
  end;

implementation

end.
