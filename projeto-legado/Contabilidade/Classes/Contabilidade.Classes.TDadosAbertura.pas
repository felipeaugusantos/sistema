unit Contabilidade.Classes.TDadosAbertura;

interface

uses Vcl.StdCtrls, Contabilidade.Model.Empresa, cxProgressBar,
     Contabilidade.Interfaces, UniClientDataSet, System.Classes;

type
  TDadosAbertura = class
  private
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FEmpresa: TEmpresa;
    FPath: string;
    FProgresso: TcxProgressBar;
    FTipoExportacao: string;
    FProvisao: boolean;
    FExportaUsoConsumo: boolean;
    FUsaCheckListComplemento: boolean;
    FConSeqParExiste: boolean;
    FParametrizouPagamentoAntecipadoAvulso: boolean;
    FParametrizouPagamentoAntecipadoFatura: boolean;
    FCON_PAGANT: boolean;
    FModoRobo: boolean;
    FIncrementoCadPag: string;
    FModoLancto: integer;
    FGravouRegistro: boolean;
    FCTA_PLARES: boolean;
    FPreValidar: boolean;
    FstrEmpRobo: String ;
    FdtaLanRobo: TDateTime ;
    FarrIncDoc: TArrIncDoc ;
    FcdsPlancoInfo: TUniClientDataSet ;
    FReprocessaErros: Boolean;
    FlstDocExcluir: TStrings;
  public
    constructor create;
    destructor Destroy; override;

    property dtaDataInicial: TDateTime read FDataInicial write FDataInicial;
    property dtaDataFinal: TDateTime read FDataFinal write FDataFinal;
    property empresa: TEmpresa read FEmpresa write FEmpresa;
    property strPath: string read FPath write FPath;
    property progresso: TcxProgressBar read FProgresso write FProgresso;
    property strTipoExportacao: string read FTipoExportacao write FTipoExportacao;
    property blnProvisao: boolean read FProvisao write FProvisao;
    property blnExportaUsoConsumo: boolean read FExportaUsoConsumo write FExportaUsoConsumo;
    property blnUsaCheckListComplemento: boolean read FUsaCheckListComplemento write FUsaCheckListComplemento;
    property blnConSeqParExiste: boolean read FConSeqParExiste write FConSeqParExiste;
    property blnParametrizouPagamentoAntecipadoAvulso: boolean read FParametrizouPagamentoAntecipadoAvulso write FParametrizouPagamentoAntecipadoAvulso;
    property blnParametrizouPagamentoAntecipadoFatura: boolean read FParametrizouPagamentoAntecipadoFatura write FParametrizouPagamentoAntecipadoFatura;
    property blnCON_PAGANT: boolean read FCON_PAGANT write FCON_PAGANT;
    property blnModoRobo: boolean read FModoRobo write FModoRobo;
    property strIncrementoCadPag: string read FIncrementoCadPag write FIncrementoCadPag;
    property intModoLancto: integer read FModoLancto write FModoLancto;
    property blnGravouRegistro: boolean read FGravouRegistro write FGravouRegistro;
    property blnCTA_PLARES: boolean read FCTA_PLARES write FCTA_PLARES;
    property blnPreValidar: boolean read FPreValidar write FPreValidar;
    property strEmpRobo: String read FstrEmpRobo write FstrEmpRobo ;
    property dtaLanRobo: TDateTime read FdtaLanRobo write FdtaLanRobo ;
    property arrIncDoc: TarrIncDoc read FarrIncDoc write FarrIncDoc ;
    property cdsPlancoInfo: TUniClientDataSet read FcdsPlancoInfo write FcdsPlancoInfo ;
    property blnReprocessaErros: Boolean read FReprocessaErros write FReprocessaErros;
    // Lista de 'CHVDOC|CADPAG' a nao gravar (Req. 470760); sem posse.
    property lstDocExcluir: TStrings read FlstDocExcluir write FlstDocExcluir;
  end;

implementation

{ TDadosAbertura }

constructor TDadosAbertura.create;
begin
  FEmpresa := TEmpresa.Create;
  FProvisao := False;
  FExportaUsoConsumo := False;
  FUsaCheckListComplemento := False;
  FConSeqParExiste := False;
  FModoRobo := False;
  FIncrementoCadPag := '';
  FGravouRegistro := False;
  FModoLancto := 0;
  FCTA_PLARES := False;
  SetLength(FarrIncDoc, 0) ;
end;

destructor TDadosAbertura.Destroy;
begin
  FEmpresa.Free;
  inherited;
end;

end.
