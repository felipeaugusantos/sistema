unit untTintadeMaquina;

interface

uses
  SysUtils, Classes, Forms, Uni;

type
  {*********************************************}
  {* EVENTOS DISPARADOS AO LONGO DOS CADASTROS *}
  {******************************************PH*}
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;

  TTintadeMaquina = class(TComponent)
  private
    FRegistraProgresso: TEventoProgresso;
    FRegistraAcao: TEventoStrAcao;
    FNomeTinta: String;
    procedure SetNomeTinta(const Value: String);

  protected
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio: Integer; intAtual: Integer; intFinal: Integer);
    class function fContaLihas(strArquivo: String): Integer;
  public
    function fGravarNovasFormulas(): Boolean; virtual; abstract;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {*******************************************}
    {* FUNCAO PARA ACHAR O PROXIMO AUTOINCREM  *}
    {****************************************PH*}
    function fAjustaAutoIncrem(strTabela, strCodEmp: String; intInicio: Integer): Boolean;
    class function fAjustaInicialAutoIncremento(strTabela, strCodEmp: String): Integer;

    

  published
    property RegistraAcao: TEventoStrAcao read FRegistraAcao write FRegistraAcao;
    property RegistraProgresso: TEventoProgresso read FRegistraProgresso write FRegistraProgresso;
    property NomeTinta: String read FNomeTinta write SetNomeTinta;
  end;

  TTintadeMaquinaClasse = class of TTintadeMaquina;

implementation

uses untFuncoesSimples, untFuncoes;

{ TTintadeMaquina }

constructor TTintadeMaquina.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TTintadeMaquina.Destroy;
begin

  inherited;
end;

function TTintadeMaquina.fAjustaAutoIncrem(strTabela,
  strCodEmp: String; intInicio: Integer): Boolean;
//  Var
//    qryGen: TUniQuery;
//    intProx: Integer;
begin
//  qryGen := fCriaQuery(Self);
//  qryGen.ParamCheck := False;
//
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('SET @CONT = ' + IntToStr(intInicio - 1) + ';');
//  qryGen.ExecSQL;
//
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('UPDATE IGNORE');
//  qryGen.SQL.Add('  ' + strTabela);
//  qryGen.SQL.Add('SET ');
//  qryGen.SQL.Add('	AUTOINCREM = CONCAT(RIGHT(CONCAT("0000000000000000000000", @CONT := @CONT+1 ), 17 ), "' + strCodEmp + '" );');
//  qryGen.ExecSQL;
//
//  // ATUALIZA PROCOD
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('SELECT');
//  qryGen.SQL.Add('	(CAST(LEFT(AUTOINCREM, 17) AS SIGNED) + 1) AS "PROX"');
//  qryGen.SQL.Add('FROM');
//  qryGen.SQL.Add('	' + strTabela);
//  qryGen.SQL.Add('ORDER BY');
//  qryGen.SQL.Add('	AUTOINCREM DESC');
//  qryGen.SQL.Add('LIMIT 1;');
//  qryGen.Open;
//
//  intProx := qryGen.FieldByName('PROX').AsInteger;
//
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('UPDATE');
//  qryGen.SQL.Add('	PROCOD');
//  qryGen.SQL.Add('SET');
//  qryGen.SQL.Add('	PRO_AUTINC = ' + IntToStr(intProx));
//  qryGen.SQL.Add('WHERE');
//  qryGen.SQL.Add('	PRO_NOMARQ = "' + strTabela + '"');
//  qryGen.ExecSQL;
//
//  FreeAndNil(qryGen);
//
//  Result := True;
  Result := False;
end;

class function TTintadeMaquina.fContaLihas(strArquivo: String): Integer;
  Var
    arqGen: TextFile;
begin
  Result := 0;
  Try
    AssignFile(arqGen, strArquivo);
    Reset(arqGen);

    While Not Eof(arqGen) Do
    Begin
      Readln(arqGen);
      Result := Result + 1;
    End;

    CloseFile(arqGen);
  Except
    Result := 0;
  End;
end;

class function TTintadeMaquina.fAjustaInicialAutoIncremento(strTabela,
  strCodEmp: String): Integer;
   Var
     qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Text := 'SELECT IFNULL(CAST(MAX(LEFT( RIGHT(AUTOINCREM, 17), 14)) AS UNSIGNED INTEGER), 0) + 1 AUTO FROM ' + strTabela + ' WHERE RIGHT(AUTOINCREM, 3) = "' + VS_strCodEmp + '"';
  qryGen.Open;
  Result := qryGen.FieldByName('AUTO').AsInteger;
  fGravaAutoIncrem(strTabela, qryGen.FieldByName('AUTO').AsInteger);
  FreeAndNil(qryGen);
end;

procedure TTintadeMaquina.pRegistraAcao(strAcao: String);
begin
  If Assigned(RegistraAcao) Then RegistraAcao(strAcao);
end;

procedure TTintadeMaquina.pRegistraProgresso(intInicio: Integer; intAtual: Integer; intFinal: Integer);
begin
  If Assigned(RegistraProgresso) Then RegistraProgresso(intInicio, intAtual, intFinal);
end;

procedure TTintadeMaquina.SetNomeTinta(const Value: String);
begin
  FNomeTinta := Value;
end;

end.
