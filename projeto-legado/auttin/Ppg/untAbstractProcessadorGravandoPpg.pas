unit untAbstractProcessadorGravandoPpg;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes,
  DB, SysUtils, untIConfTinta,
  Variants, ADODB, Windows;

type
  TAbstractProcessadorGravandoPpg = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
  protected
    conf: IConfTinta;
    strMarca: string;
    strConfArq: string;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; override;
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    constructor Create(const strIdePro, strConfArq, strMarca: string); virtual;
  end;

implementation

uses untFuncTinta, untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,
     untADOTxtFactory, untIDefinicaoTxt, untDefinicaoTxtCampoTipo,
     untGenericDefinicaoTxt, untGenericDefinicaoTxtCampo;

{ TAbstractProcessadorGravandoExecucaoBrasimixImobiliaria }

constructor TAbstractProcessadorGravandoPpg.Create(const strIdePro, strConfArq, strMarca: string);
begin
  inherited Create();
  conf := fGetConfTinta(strIdePro);
  Self.strMarca := strMarca;
  Self.strConfArq := strConfArq;
end;

function TAbstractProcessadorGravandoPpg.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, False, '|', dtcsAnsi, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('UFID', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Brand Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Brand Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('OEM Color Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Mixing Scheme Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Mixing Scheme Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Source Type Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Source Type Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Usage Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Usage Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Manufacturer Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Manufacturer Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Model', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Country For Color Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Contry For Color Desc', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Finish Effect Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Finish Effect Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Paint System Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Paint System', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Paint System Short Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Variant Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('VariantCode', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Variant Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Specific Weigh (Gravity)', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product Volume', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Initial Year', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Finish Year', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product1 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product1Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct1', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct1', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product2 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product2Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct2', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct2', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product3 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product3Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct3', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct3', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product4 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product4Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct4', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct4', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product5 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product5Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct5', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct5', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product6 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product6Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct6', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct6', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product7 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product7Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct7', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct7', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product8 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product8Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct8', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct8', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product9 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product9Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct9', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct9', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product10 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product10Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct10', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct10', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product11 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product11Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct11', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct11', dtctDouble)
  ]));
  strNomeArquivo := definicao.NomeArquivo;
  TADOTxtFactory.Registrar(definicao);
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TAbstractProcessadorGravandoPpg.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet(strConfArq); // conf.fGet('ARQPPG');
end;

end.
