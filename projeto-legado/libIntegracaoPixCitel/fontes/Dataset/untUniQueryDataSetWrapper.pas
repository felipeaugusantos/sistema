{********************************************************************************************}
{* Classe responsável pela conversão de TUniQuery para IDataSet, assim é possivel trabalhar *}
{* com uma TUniQuery, sem ter conhecimento de sua implementação                             *}
{*****************************************************************************************JU*}
unit untUniQueryDataSetWrapper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Uni, untIDataSet, DB, Classes, SysUtils,
  untDataSetIDataSetWrapper, untFieldDataSetFieldWrapper,
  untParamDataSetWrapper;

type
  TUniQueryDataSetWrapper = class(TDataSetIDataSetWrapper, IDataSet)
  private
   {$IFDEF LINUX}
    procedure pRegistrarFalha(const AstrOperacao: String; const AE: Exception);
   {$ENDIF}
  public
    function GetSQL: String; override;
    procedure SetSQL(const strSql: String); override;

    function ParamByName(const Value: string): IDataSetParam; override;
    function Params(const Value: integer): IDataSetParam; override;
    procedure ExecSQL; override;
    procedure Open; override;
    constructor Create; overload;
  end;

implementation

{ TUniQueryDataSetWrapper }

procedure TUniQueryDataSetWrapper.SetSQL(const strSql: String);
begin
  TUniQuery(qryGen).SQL.Clear;
  TUniQuery(qryGen).Params.Clear;
  TUniQuery(qryGen).SQL.Text := strSql;
end;

{$IFDEF LINUX}
// Este wrapper e o dataset que o servico entrega as libs (.so) por VS_FuncoesExternas. No Linux
// nao ha ShareMem: a excecao que sai daqui para dentro da .so nao e reconhecida pelo RTL dela, e
// o processo cai no tratamento (Runtime error 216/231) sem que a mensagem original apareca em
// lugar nenhum. Registrar aqui, ainda do lado do servico, e o que deixa a causa visivel - caso
// Distribuidora Padrao, 14/10/2026: "Unknown column 'LOG_NOMMAQ'" na LOGAPI, invisivel ate entao.
// Registra e relanca: o comportamento para quem chama nao muda.
procedure TUniQueryDataSetWrapper.pRegistrarFalha(const AstrOperacao: String; const AE: Exception);
  Var
    strSQL: String;
begin
  Try
    strSQL := TUniQuery(qryGen).SQL.Text.Replace(#13, ' ').Replace(#10, ' ').Trim;
    If Length(strSQL) > 500 Then
      strSQL := Copy(strSQL, 1, 500) + '...';

    WriteError(Format('[IDataSet.%s] %s: %s | SQL: %s', [AstrOperacao, AE.ClassName, AE.Message, strSQL]));
  Except
    // O log nao pode trocar a excecao original por outra
  End;
end;
{$ENDIF}

procedure TUniQueryDataSetWrapper.ExecSQL;
begin
  Try
    TUniQuery(qryGen).ExecSQL;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      pRegistrarFalha('ExecSQL', E);
     {$ENDIF}
      Raise;
    End;
  End;
end;

procedure TUniQueryDataSetWrapper.Open;
begin
  Try
    inherited Open;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      pRegistrarFalha('Open', E);
     {$ENDIF}
      Raise;
    End;
  End;
end;

function TUniQueryDataSetWrapper.GetSQL: String;
begin
  Result := TUniQuery(qryGen).SQL.Text;
end;

function TUniQueryDataSetWrapper.ParamByName(const Value: string): IDataSetParam;
begin
  Result := TParamDataSetWrapper.Create(TUniQuery(qryGen).ParamByName(Value));
end;

function TUniQueryDataSetWrapper.Params(const Value: integer): IDataSetParam;
begin
  Result := TParamDataSetWrapper.Create(TUniQuery(qryGen).Params[Value]);
end;

constructor TUniQueryDataSetWrapper.Create();
begin
  inherited Create();
  Self.qryGen := fCriaQuery();
  Self.blnVinculado := False;
end;

end.
