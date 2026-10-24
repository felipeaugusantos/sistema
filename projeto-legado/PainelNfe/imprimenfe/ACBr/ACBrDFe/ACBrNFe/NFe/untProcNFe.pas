unit untProcNFe;

interface

uses
  SysUtils, Classes, untConversao;

type

//  TPadraoNomeProcNFe = (tpnPublico, tpnPrivado);

  TProcNFe = class(TPersistent)
  private
//    FGerador: TGerador;
    FPathNFe: String;
    FPathRetConsReciNFe: String;
    FPathRetConsSitNFe: String;
    FtpAmb: TTipoAmbiente;
    FverAplic: String;
    FchNFe: String;
    FdhRecbto: TDateTime;
    FnProt: String;
    FdigVal: String;
    FcStat: Integer;
    FxMotivo: String;
    FVersao: String;
    // Usando na Montagem do nfeProc
    FXML_NFe: String;
    FXML_prot: String;
    FxMsg: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
//    function ObterNomeArquivo(const PadraoNome: TPadraoNomeProcNFe = tpnPrivado): String;
  published
//    property Gerador: TGerador          read FGerador;
    property PathNFe: String            read FPathNFe            write FPathNFe;
    property PathRetConsReciNFe: String read FPathRetConsReciNFe write FPathRetConsReciNFe;
    property PathRetConsSitNFe: String  read FPathRetConsSitNFe  write FPathRetConsSitNFe;
    property tpAmb: TTipoAmbiente    read FtpAmb              write FtpAmb;
    property verAplic: String           read FverAplic           write FverAplic;
    property chNFe: String              read FchNFe              write FchNFe;
    property dhRecbto: TDateTime        read FdhRecbto           write FdhRecbto;
    property nProt: String              read FnProt              write FnProt;
    property digVal: String             read FdigVal             write FdigVal;
    property cStat: Integer             read FcStat              write FcStat;
    property xMotivo: String            read FxMotivo            write FxMotivo;
    property Versao: String             read FVersao             write FVersao;
    // Usando na Montagem do nfeProc
    property XML_NFe: String            read FXML_NFe            write FXML_NFe;
    property XML_prot: String           read FXML_prot           write FXML_prot;
    property xMsg: String               read FxMsg               write FxMsg;
  end;

implementation

uses
  untAuxiliar, untLeitor, ACBrUtil;

{ TProcNFe }

constructor TProcNFe.Create;
begin
//  FGerador := TGerador.Create;
  FnProt   := '';
end;

destructor TProcNFe.Destroy;
begin
//  FGerador.Free;
  inherited;
end;
(*
function TProcNFe.ObterNomeArquivo(const PadraoNome: TPadraoNomeProcNFe = tpnPrivado): String;
var
  s: String;
begin
  Result := FchNFe + '-procNFe.xml';
  if PadraoNome = tpnPublico then
  begin
    s := '00' + Versao;
    Result := FnProt + '_v' + copy(s, length(s) - 4, 5) + '-procNFe.xml';
  end;
end;
*)

procedure TProcNFe.Assign(Source: TPersistent);
begin
  if Source is TProcNFe then
  begin
//    Gerador.Assign(TprocNFe(Source).Gerador);
    PathNFe := TprocNFe(Source).PathNFe;
    PathRetConsReciNFe := TprocNFe(Source).PathRetConsReciNFe;
    PathRetConsSitNFe := TprocNFe(Source).PathRetConsSitNFe;
    tpAmb := TprocNFe(Source).tpAmb;
    verAplic := TprocNFe(Source).verAplic;
    chNFe := TprocNFe(Source).chNFe;
    dhRecbto := TprocNFe(Source).dhRecbto;
    nProt := TprocNFe(Source).nProt;
    digVal := TprocNFe(Source).digVal;
    cStat := TprocNFe(Source).cStat;
    xMotivo := TprocNFe(Source).xMotivo;
    Versao := TprocNFe(Source).Versao;
    XML_NFe := TprocNFe(Source).XML_NFe;
    XML_prot := TprocNFe(Source).XML_prot;
    xMsg := TprocNFe(Source).xMsg;
  end
  else
    inherited;
end;

end.

