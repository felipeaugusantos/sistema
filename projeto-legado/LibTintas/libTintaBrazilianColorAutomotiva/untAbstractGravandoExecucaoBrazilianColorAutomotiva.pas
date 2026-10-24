{***********************************************************************************}
{* Classe abstrata que implementa o b·sico / comum para a geraÁ„o da tinta BrazilianColorAutomotiva *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoBrazilianColorAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoBrazilianColorAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    conf: IConfTinta;

    function GetPath : String;

  public
    Conexao    : TADOConnection;
    tabela     : TADODataSet;
    qryDestino : IDataSet;


    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;

    function fConnection : String;
    procedure pCreateConnection;
    procedure pDestroyConnection;

    function fRemoveAcento(Str: String): String;

  end;


implementation

uses
  untStrUtils;

{ TGravandoExecucaoBrazilianColorAutomotivaCores }



constructor TAbstractGravandoExecucaoBrazilianColorAutomotiva.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BZC');

end;

destructor TAbstractGravandoExecucaoBrazilianColorAutomotiva.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoBrazilianColorAutomotiva.fConnection: String;
begin
  Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + GetPath + ';Persist Security Info=False';
end;

function TAbstractGravandoExecucaoBrazilianColorAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoBrazilianColorAutomotiva.GetPath : String;
begin
  Result := conf.fGet('BZCPAT')
end;

procedure TAbstractGravandoExecucaoBrazilianColorAutomotiva.pCreateConnection;
begin
  Conexao                  := TADOConnection.Create(nil);
  Conexao.LoginPrompt      := False;
  Conexao.ConnectionString := fConnection;
  Conexao.Open;

  tabela:= TADODataSet.Create(nil);
  tabela.Connection := Conexao;

  qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

end;

procedure TAbstractGravandoExecucaoBrazilianColorAutomotiva.pDestroyConnection;
begin
  If Assigned(Conexao)    Then FreeAndNil(Conexao);
  If Assigned(tabela)     Then FreeAndNil(tabela);
end;

function TAbstractGravandoExecucaoBrazilianColorAutomotiva.fRemoveAcento(Str: String): String;
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
