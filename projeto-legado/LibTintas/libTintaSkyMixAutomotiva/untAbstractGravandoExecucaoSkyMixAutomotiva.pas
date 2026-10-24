{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoSkyMixAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoSkyMixAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    conf: IConfTinta;
    function fValidaPath: Boolean;
    function GetPath: String;
    function fRetVariante(strAnuancia: String): String;
    function fCfgTin(strNome: String): String;


  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoSkyMixAutomotivaCores }

constructor TAbstractGravandoExecucaoSkyMixAutomotiva.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('SKY');
end;

destructor TAbstractGravandoExecucaoSkyMixAutomotiva.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoSkyMixAutomotiva.fCfgTin(
  strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoSkyMixAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoSkyMixAutomotiva.fRetVariante(
  strAnuancia: String): String;
Var
  intContador: Integer;

  Function fRetCodigoVarianteCores(strCodigo:String):String;
  Begin
    Result := '';

    If strCodigo = 'A' Then
      Result := 'Principal'
    Else If strCodigo = 'T' Then
      Result := 'Tri-Coat'
    Else If strCodigo = 'B' Then
      Result := 'Mais Clara'
    Else If strCodigo = 'C' Then
      Result := 'Mais Escura'
    Else If strCodigo = 'D' Then
      Result := 'Mais Azul'
    Else If strCodigo = 'E' Then
      Result := 'Mais Amarelo'
    Else If strCodigo = 'F' Then
      Result := 'Mais Verde'
    Else If strCodigo = 'G' Then
      Result := 'Mais Vermelho'
    Else If strCodigo = 'H' Then
      Result := 'Mais Fino'
    Else If strCodigo = 'I' Then
      Result := 'Mais Graúdo'
    Else If strCodigo = 'J' Then
      Result := 'Frente'
    Else If strCodigo = 'K' Then
      Result := 'Alumínio'
    Else If strCodigo = 'W' Then
      Result := 'Limpo'
    Else If strCodigo = 'X' Then
      Result := 'Sujo'
    Else If strCodigo = 'Y' Then
      Result := 'Leitoso'
    Else If strCodigo = 'Z' Then
      Result := 'No Ângulo';

  End;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(strAnuancia) Then
  For intContador := 1 To Length(strAnuancia) Do
  Begin
    If TStrUtils.fEmptyStr(Result) Then
      Result := fRetCodigoVarianteCores(Copy(strAnuancia, intContador, 1))
    Else
      Result := Result + ' e ' + fRetCodigoVarianteCores(Copy(strAnuancia, intContador, 1));
  End;
end;

function TAbstractGravandoExecucaoSkyMixAutomotiva.fValidaPath: Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoSkyMixAutomotiva.GetPath : String;
begin
  Result := conf.fGet('SKYPAT');
end;

end.

