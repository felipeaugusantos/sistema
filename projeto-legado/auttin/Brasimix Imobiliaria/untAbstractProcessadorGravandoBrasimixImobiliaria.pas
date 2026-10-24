unit untAbstractProcessadorGravandoBrasimixImobiliaria;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIConfTinta,
  Variants,  ADODB, Windows;

type
  TAbstractProcessadorGravandoBrasimixImobiliaria = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
  protected
    conf: IConfTinta;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; override;
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    constructor Create();
  end;

implementation

uses untFuncTinta, untDefinicaoTxtCampoTipo, untGenericDefinicaoTxtCampo,
     untIDefinicaoTxtCampo, untGenericDefinicaoTxt, untADOTxtFactory, untIDefinicaoTxt,
     untDefinicaoTxtCharacterSet;

{ TAbstractProcessadorGravandoExecucaoBrasimixImobiliaria }

constructor TAbstractProcessadorGravandoBrasimixImobiliaria.Create;
begin
  inherited Create();
  conf := fGetConfTinta('BZI');
end;

function TAbstractProcessadorGravandoBrasimixImobiliaria.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, False, dtcsAnsi, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('IDREGISTRO', dtctText, 13),
      TGenericDefinicaoTxtCampo.Create('SEP', dtctText, 1),
      TGenericDefinicaoTxtCampo.Create('CATALOGO', dtctText, 36),
      TGenericDefinicaoTxtCampo.Create('LINHA', dtctText, 5),
      TGenericDefinicaoTxtCampo.Create('SEP', dtctText, 1),
      TGenericDefinicaoTxtCampo.Create('DESBAS', dtctText, 44),
      TGenericDefinicaoTxtCampo.Create('REFERE', dtctText, 15),
      TGenericDefinicaoTxtCampo.Create('BASE', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('FORM01', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD01', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM02', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD02', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM03', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD03', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM04', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD04', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM05', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD05', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM06', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD06', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM07', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD07', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM08', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD08', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM09', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD09', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM10', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD10', dtctFloat, 10)
  ]));
  strNomeArquivo := definicao.NomeArquivo;
  TADOTxtFactory.Registrar(definicao);
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TAbstractProcessadorGravandoBrasimixImobiliaria.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('TXTBRI');
end;

end.
