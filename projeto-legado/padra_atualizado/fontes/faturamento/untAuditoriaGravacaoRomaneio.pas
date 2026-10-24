unit untAuditoriaGravacaoRomaneio;

interface

uses Generics.Collections;

type
  IAuditoriaGravacaoRomaneio = interface
    ['{111C39BC-9DAF-4643-93AC-5DE010FBB862}']
    function Adicionar(const AAutoincrem, ATabela: String): IAuditoriaGravacaoRomaneio;
    function Limpar: IAuditoriaGravacaoRomaneio;
    function ValidouTodas(out ACodErros: String): Boolean;
  end;

  TAuditoriaGravacaoRomaneio = class(TInterfacedObject, IAuditoriaGravacaoRomaneio)
  private
    FFazerAuditoria: Boolean;
    FListAutInc: TList<String>;
    FListTabela: TList<String>;
    function Validou(const ATabela, AAutoincrem: String; const AModoRobo: Boolean): String;
  public
    function Adicionar(const AAutoincrem, ATabela: String): IAuditoriaGravacaoRomaneio;
    function Limpar: IAuditoriaGravacaoRomaneio;
    function ValidouTodas(out ACodErros: String): Boolean;
    constructor Create;
    destructor Destroy; override;
    class function New: IAuditoriaGravacaoRomaneio;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untConstantes, SysUtils, Uni, Data.DB;

{ TAuditoriaGravacaoRomaneio }

function TAuditoriaGravacaoRomaneio.Adicionar(const AAutoincrem, ATabela: String): IAuditoriaGravacaoRomaneio;
begin
  Result := Self;
  FListAutInc.Add(AAutoincrem);
  FListTabela.Add(ATabela);
end;

function TAuditoriaGravacaoRomaneio.Limpar: IAuditoriaGravacaoRomaneio;
begin
  Result := Self;
  FListAutInc.Clear;
  FListTabela.Clear;
end;

class function TAuditoriaGravacaoRomaneio.New: IAuditoriaGravacaoRomaneio;
begin
  Result := Self.Create;
end;

constructor TAuditoriaGravacaoRomaneio.Create;
begin
  FListAutInc := TList<String>.Create;
  FListTabela := TList<String>.Create;
  FFazerAuditoria := fCFgSis('UTAUFA', varBoolean);
end;

destructor TAuditoriaGravacaoRomaneio.Destroy;
begin
  FreeAndNil(FListAutInc);
  FreeAndNil(FListTabela);
  inherited;
end;

function TAuditoriaGravacaoRomaneio.Validou(const ATabela, AAutoincrem: String; const AModoRobo: Boolean): String;
Var
  LqryAudit: TUniQuery;
begin
  Result := '';

  LqryAudit := fCriaQuery;

  Try
    Try
      LqryAudit.SQL.Text := 'SELECT F_AUDITORIA_GRAVACAO_FATURAMENTO(:TABELA, :AUTOINCREM, :MODO_ROBO);';
      LqryAudit.ParamByName('TABELA').AsString     := ATabela;
      LqryAudit.ParamByName('AUTOINCREM').AsString := AAutoincrem;
      LqryAudit.ParamByName('MODO_ROBO').AsInteger := IIF(AModoRobo, 1, 0);
      LqryAudit.Open;

      if (not LqryAudit.IsEmpty) and (LqryAudit.Fields[0].AsString <> '0') then
        Result := LqryAudit.Fields[0].AsString;
    Except
      On E: Exception Do
        Result := '';
    End;
  Finally
    FreeAndNil(LqryAudit);
  End;
end;

function TAuditoriaGravacaoRomaneio.ValidouTodas(out ACodErros: String): Boolean;
Var
  LCont: Integer;
  LAutComEmModoImportacao: Boolean;
begin
  Result := True;
  ACodErros := '';

  If Not FFazerAuditoria Then
    Exit;

{$IFDEF LINUX}
  LAutComEmModoImportacao := False;
{$ELSE}
  LAutComEmModoImportacao := fAutComEmModoImportacao;
{$ENDIF}

  For LCont := 0 To Pred(FListAutInc.Count) Do
  Begin
    ACodErros := Validou(FListTabela[LCont], FListAutInc[LCont], LAutComEmModoImportacao);

    Result := fEmptyStr(ACodErros);

    If (Not Result) Then
      Break;
  End;
end;

end.
