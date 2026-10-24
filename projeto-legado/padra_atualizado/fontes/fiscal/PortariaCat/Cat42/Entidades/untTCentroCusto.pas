unit untTCentroCusto;

interface

Type
  TCentroCusto = class
    private
      FCodigo: String;
      FDescricao: String;
      FContaContabil: String;
      FTipoDespesa: Integer;
      FExportaAutsi: Boolean;
    public
      property strCodigo: String read FCodigo write FCodigo;
      property strDescricao: String read FDescricao write FDescricao;
      property strContaContabil: String read FContaContabil write FContaContabil;
      property intTipoDespesa: Integer read FTipoDespesa write FTipoDespesa;
      property blnExportaAutsi: Boolean read FExportaAutsi write FExportaAutsi;
  end;

implementation

end.
