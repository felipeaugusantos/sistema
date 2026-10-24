unit untTMovBan;

interface

Type
  TMovBan = class(TObject)
    private
      FSeqLan: String;
      FHistorico: String;
      FContaContabilPortadorOrigem: String;
      FContaContabilPortadorDestino: String;
      FContaContabilCentroCusto: String;
      FValor: Double;
      FDtaLan: TDateTime;
      FDataConciliacao: TDateTime;
    public
      property strSeqLan: String read FSeqLan write FSeqLan;
      property strHistorico: String read FHistorico write FHistorico;
      property strContaContabilPortadorOrigem: String read FContaContabilPortadorOrigem write FContaContabilPortadorOrigem;
      property strContaContabilPortadorDestino: String read FContaContabilPortadorDestino write FContaContabilPortadorDestino;
      property strContaContabilCentroCusto: String read FContaContabilCentroCusto write FContaContabilCentroCusto;
      property fltValor: Double read FValor write FValor;
      property dtaDtaLan: TDateTime read FDtaLan write FDtaLan;
      property dtaDataConciliacao: TDateTime read FDataConciliacao write FDataConciliacao;
  end;

implementation

end.
