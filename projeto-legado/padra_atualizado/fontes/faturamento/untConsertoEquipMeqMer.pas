unit untConsertoEquipMeqMer;

interface

type
  TItemNotaEntradaRemessa = record
    intIndex : Integer;
    strAutInc: String;
    strDescri: String;
    strNcmIte: String;
  end;

  TItensNotaEntradaRemessa = Array of TItemNotaEntradaRemessa;

  {$M+}
  TMeqMer = class
  private
    FAutInc: String;
    FAutEqu: String;
    FEmpEqu: String;
    FNumOse: String;
    FAutGer: String;
    FNumDoc: String;
    FEspDoc: String;
    FEmpGer: String;
    FSerie_: String;
    FCodCli: String;
    FTipOpe: String;
    FDtaGer: TDateTime;
    FChaveAcesso: String;
    FAutDet: String;
    FNCMEqu: String;
    FItensEnt: TItensNotaEntradaRemessa;
    FIdxIteSel: Integer;
  public
  published
    property strAutInc: String    Read FAutInc Write FAutInc;
    property strAutEqu: String    Read FAutEqu Write FAutEqu;
    property strEmpEqu: String    Read FEmpEqu Write FEmpEqu;
    property strNumOse: String    Read FNumOse Write FNumOse;
    property strAutGer: String    Read FAutGer Write FAutGer;
    property strNumDoc: String    Read FNumDoc Write FNumDoc;
    property strEspDoc: String    Read FEspDoc Write FEspDoc;
    property strEmpGer: String    Read FEmpGer Write FEmpGer;
    property strSerie_: String    Read FSerie_ Write FSerie_;
    property strCodCli: String    Read FCodCli Write FCodCli;
    property strTipOpe: String    Read FTipOpe Write FTipOpe;
    property dtaDtaGer: TDateTime Read FDtaGer Write FDtaGer;
    property strChaveAcesso: String Read FChaveAcesso Write FChaveAcesso;
    property strAutDet: String    Read FAutDet Write FAutDet;
    property strNCMEqu: String    Read FNCMEqu Write FNCMEqu;
    property arrItensEnt: TItensNotaEntradaRemessa Read FItensEnt Write FItensEnt;
    property intIdxIteSel: Integer  Read FIdxIteSel Write FIdxIteSel;
  End;
  {$M-}

implementation

end.
