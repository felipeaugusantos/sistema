{********************************************************************************************}
{* Classe abstrata que implementa o b·sico / comum para a geraÁ„o da tinta Salcomix *}
{********************************************************************************************}
unit untAbstractGravandoExecucaoSalcomix;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory, Uni,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

Type
  TBasSal = Record
    strCodBas: String;
    fltQtdBas: Double;
  End;


type
  TAbstractGravandoExecucaoSalcomix = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    conf: IConfTinta;

    Function SalcomixPath(): String;

  public
    qryDestino : IDataSet;

    function fConnectionFdb : TUniConnection;

    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;

    function fRemoveAcento(Str: String): String;
    function fCriaClienteDataSet: TUniClientDataSet;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoSalcomixCores }


constructor TAbstractGravandoExecucaoSalcomix.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SAL');

end;

destructor TAbstractGravandoExecucaoSalcomix.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoSalcomix.fCriaClienteDataSet: TUniClientDataSet;
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



function TAbstractGravandoExecucaoSalcomix.fConnectionFdb: TUniConnection;
Var
  conf   : IConfTinta;
  Con    : TUniConnection;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('SAL');

  Con := TUniConnection.Create(nil);

  try
    Con.Database     := conf.fGet('SALPAT');
    Con.Username     := conf.fGet('SALUSU');
    Con.Password     := conf.fGet('SALSEN');

    if (conf.fGet('SALSER') <> 'LOCALHOST' ) then
    begin
      Con.Server       := conf.fGet('SALSER');
      Con.Port         := conf.fGetInteger('SALPOR');
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

function TAbstractGravandoExecucaoSalcomix.fRemoveAcento(Str: String): String;
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

function TAbstractGravandoExecucaoSalcomix.SalcomixPath: String;
begin
  Result := Conf.fGet('SALPAT');
end;

end.
