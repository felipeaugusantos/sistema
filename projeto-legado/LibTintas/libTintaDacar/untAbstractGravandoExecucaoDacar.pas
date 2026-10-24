{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Dacar   *}
{********************************************************************************AC*}
unit untAbstractGravandoExecucaoDacar;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, strUtils, System.Win.ComObj, Variants;

type
  TAbstractGravandoExecucaoDacar = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    Conf: IConfTinta;

    function fGetNomeArquivo: String;
    function fTiraCaracEspeciais(strTexto: String): String;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils,
  untADOFactory;


{ TAbstractGravandoExecucaoDacar }

constructor TAbstractGravandoExecucaoDacar.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DAC');
end;

destructor TAbstractGravandoExecucaoDacar.Destroy;
begin
  inherited;
end;



function TAbstractGravandoExecucaoDacar.fGetNomeArquivo: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DAC').fGet('TXTDAC');
end;

function TAbstractGravandoExecucaoDacar.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoDacar.fTiraCaracEspeciais(
  strTexto: String): String;
Var
  strLista: String;
  intContador: Integer;
  intPosicao: Integer;
  strCaracNorm: String;
  strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

  Result := '';

  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];
  End;
end;

end.
