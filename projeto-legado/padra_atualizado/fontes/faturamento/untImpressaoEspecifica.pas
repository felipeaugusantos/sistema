unit untImpressaoEspecifica;

interface
{$M+}

uses
  UniClientDataSet, DB, SysUtils, untModuloImpEspecifica, Classes, untImpressaoDelLamaIntf;

type
  TImpressaoEspecifica = Class(TObject)
  private
    {**************************************}
    {* DATASETS PADÕES DAS IMPRESSÕES     *}
    {* SE CASO HOUVER A NECESSIDADE DE    *}
    {* CRIAR OUTROS, FAVOR CRIAR NA       *}
    {* CLASSE FILHA. SE CASO FOR GENERICA *}
    {* CRIAR NESSA CLASSE                 *}
    {***********************************FC*}
    FcdsCabecalho,
    FcdsRodape,
    FcdsItens: TUniClientDataSet;
  protected
    FModuloImpEspecifica: TfrmModuloImpEspecifica;

    function GetcdsCabecalho: TUniClientDataSet;
    function GetcdsItens: TUniClientDataSet;
    function GetcdsRodape: TUniClientDataSet;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pCriaClients; virtual; abstract;

    procedure pPreencheCabecalho; overload; virtual; abstract;
    procedure pPreencheItens; overload; virtual; abstract;
    procedure pPreencheRodape; overload; virtual; abstract;
    procedure pImprimeDocumento; overload; virtual; abstract;

    procedure pPreencheCabecalho(objImpDadosDelLama: IImpressaoDelLamaIntf); overload; virtual; abstract;
    procedure pPreencheItens(qryItens: TDataset; blnImpDescSimp: Boolean); overload; virtual; abstract;
    procedure pPreencheRodape(objImpDadosDelLama: IImpressaoDelLamaIntf); overload; virtual; abstract;
    procedure pImprimeDocumento(objImpDadosDelLama: IImpressaoDelLamaIntf); overload; virtual; abstract;

published
    property cdsCabecalho       : TUniClientDataSet          read GetcdsCabecalho;
    property cdsRodape          : TUniClientDataSet          read GetcdsRodape;
    property cdsItens           : TUniClientDataSet          read GetcdsItens;
  End;

implementation

uses untFuncoesSimples;

{ TImpressaoEspecifica }

constructor TImpressaoEspecifica.Create;
begin
  FcdsCabecalho := TUniClientDataSet.Create(Nil);
  FcdsRodape    := TUniClientDataSet.Create(Nil);
  FcdsItens     := TUniClientDataSet.Create(Nil);

  pCriarModulo(TfrmModuloImpEspecifica, TDataModule(FModuloImpEspecifica));

  With FModuloImpEspecifica Do
  Begin
    frxCabecalho.DataSet := FcdsCabecalho;
    frxItens.DataSet     := FcdsItens;
    frxRodape.DataSet    := FcdsRodape;
  End;
end;

destructor TImpressaoEspecifica.Destroy;
begin
  FreeAndNil(FcdsCabecalho);
  FreeAndNil(FcdsRodape);
  FreeAndNil(FcdsItens);

  pFreeAndNil(FModuloImpEspecifica);

  inherited;
end;

function TImpressaoEspecifica.GetcdsCabecalho: TUniClientDataSet;
begin
  Result := FcdsCabecalho;
end;

function TImpressaoEspecifica.GetcdsItens: TUniClientDataSet;
begin
  Result := FcdsItens;
end;

function TImpressaoEspecifica.GetcdsRodape: TUniClientDataSet;
begin
  Result := FcdsRodape;
end;

end.
