{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoBrasimixAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoBrasimixAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected

    conf: IConfTinta;

    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath: Boolean;
    function GetPath: String;
    function fCfgTin(strNome: String): String;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    Function fRetTotLinhas(strArquivoTxt : String) : Integer;
    function fProcessaTipo(strTipo: String): String;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoBrasimixAutomotivaCores }

constructor TAbstractGravandoExecucaoBrasimixAutomotiva.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('BZA');
end;

destructor TAbstractGravandoExecucaoBrasimixAutomotiva.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoBrasimixAutomotiva.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoBrasimixAutomotiva.fRetTotLinhas(strArquivoTxt: String): Integer;
Var
  slArquivo : TStringList;
begin

  Try
    slArquivo := TStringList.Create;
    slArquivo.LoadFromFile(strArquivoTxt);

    Result := slArquivo.Count;
  Finally
    If Assigned(slArquivo) Then
      FreeAndNil(slArquivo);
  End;

end;

function TAbstractGravandoExecucaoBrasimixAutomotiva.fProcessaTipo(strTipo: String): String;
begin
  If (strTipo = 'PE') Then
    Result := 'POLIESTER'
  Else If (strTipo = 'PU') Then
    Result := 'POLIURETANO FLEET 3X1'
  Else If (strTipo = 'PH') Then
    Result := 'POLIURETANO H.S. 2X1'
  Else If (strTipo = 'SR') Then
    Result := 'SINT. EXTRA-RAPIDO'
  Else If (strTipo = 'ST') Then
    Result := 'SINT. AUTOMOTIVO'
  Else If (strTipo = 'SB') Then
    Result := 'SINT. RAPIDO BRASILIAR'
  Else If (strTipo = 'SI') Then
    Result := 'SINT. RODOAGROINDUSTRIAL'
  Else If (strTipo = 'LC') Then
    Result := 'LACA NITRO-CELULOSE'
  Else If (strTipo = 'LA') Then
    Result := 'LACA NITRO AUTOMOTIVA'
  Else If (strTipo = 'EP') Then
    Result := 'EPOXI'
  Else If (strTipo = 'PM') Then
    Result := 'POLIURETANO PREMIUM 4X1'
  Else If (strTipo = 'PP') Then
    Result := 'POLIESTER PREMIUM'
  Else If (strTipo = 'EM') Then
    Result := 'EPOXI POLIAMINA'
  Else If (strTipo = 'PR') Then
    Result := 'POLIURETANO PREM. HS 4X1'
  Else If (strTipo = 'PD') Then
    Result := 'POLIURETANO PARA MADEIRA'
  Else If (strTipo = 'ED') Then
    Result := 'EPOX POLIAMIDA PLUS'
end;



function TAbstractGravandoExecucaoBrasimixAutomotiva.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoBrasimixAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoBrasimixAutomotiva.fValidaPath: Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoBrasimixAutomotiva.GetPath : String;
begin
  Result := conf.fGet('BZAPAT');
end;

end.
