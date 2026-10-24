{********************************************************************************************}
{* Classe abstrata que implementa o b·sico / comum para a geraÁ„o da tinta FarbenAutomotiva *}
{********************************************************************************************}
unit untAbstractGravandoExecucaoFarbenAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory, Uni,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoFarbenAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    conf: IConfTinta;

    function GetPath : String;

  public
    qryDestino : IDataSet;

    function fConnectionFdb : TUniConnection;

    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;

    function fRemoveAcento(Str: String): String;
    function fCriaClienteDataSet: TUniClientDataSet;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoFarbenAutomotivaCores }


constructor TAbstractGravandoExecucaoFarbenAutomotiva.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('FAR');

end;

destructor TAbstractGravandoExecucaoFarbenAutomotiva.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoFarbenAutomotiva.GetPath : String;
begin
  Result := conf.fGet('FARPAT')
end;

function TAbstractGravandoExecucaoFarbenAutomotiva.fCriaClienteDataSet: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODPRO';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODBAS';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FATOR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDBAS';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDCON';
    DataType := ftFloat;
  End;
  Result.CreateDataSet;
end;



function TAbstractGravandoExecucaoFarbenAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoFarbenAutomotiva.fConnectionFdb: TUniConnection;
Var
  conf   : IConfTinta;
  Con    : TUniConnection;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('FAR');

  Con := TUniConnection.Create(nil);

  try
    Con.Database     := conf.fGet('FARPAT');
    Con.Username     := conf.fGet('FARUSU');
    Con.Password     := conf.fGet('FARSEN');

    if (conf.fGet('FARSER') <> 'LOCALHOST' ) then
    begin
      Con.Server       := conf.fGet('FARSER');
      Con.Port         := conf.fGetInteger('FARPOR');
    end;

    Con.ProviderName := 'Interbase';
    Con.Connect;

    Result := Con;

  except on e : Exception do
    begin
      Result := Nil;
    end;
  end;

end;

function TAbstractGravandoExecucaoFarbenAutomotiva.fRemoveAcento(Str: String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

end.
