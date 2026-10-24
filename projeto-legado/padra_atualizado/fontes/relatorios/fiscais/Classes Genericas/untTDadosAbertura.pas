unit untTDadosAbertura;

interface

uses untTypesSistema,
     ComCtrls;

type
  TDadosAbertura = class
  private
    FArrProduto: TConsultasArray;
    FProgresso: TProgressBar;
    FCodigoEmpresa: String;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
  public
    function fRetCodIteSelecionadoConcatenado: string;

    property dtaDataInicial: TDateTime read FDataInicial;
    property dtaDataFinal: TDateTime read FDataFinal;
    property arrProduto: TConsultasArray read FArrProduto write FArrProduto;
    property strCodigoEmpresa: String read FCodigoEmpresa;
    property progresso: TProgressBar read FProgresso write FProgresso;

    constructor create(dataInicial, dataFinal: TDateTime; strCodEmp: string);
  end;

implementation

{ TDadosAbertura }

constructor TDadosAbertura.create(dataInicial, dataFinal: TDateTime; strCodEmp: string);
begin
  inherited create;

  FDataInicial := dataInicial;
  FDataFinal := dataFinal;
  FCodigoEmpresa := strCodEmp;
end;

function TDadosAbertura.fRetCodIteSelecionadoConcatenado: string;
  var
    intIndex: integer;
begin
  for intIndex := Low(FArrProduto) to High(FArrProduto) do
  begin
    Result := Result + FArrProduto[intIndex].strCodigo + '_';
  end;
end;

end.
