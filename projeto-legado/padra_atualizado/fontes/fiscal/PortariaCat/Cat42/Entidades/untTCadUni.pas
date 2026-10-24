unit untTCadUni;

interface

type
  TUnidade = class
    private
      FCodigo: string;
      FSigla: string;
    public
      property strCodigo: string read FCodigo write FCodigo;
      property strSigla: string read FSigla write FSigla;
  end;

implementation

end.