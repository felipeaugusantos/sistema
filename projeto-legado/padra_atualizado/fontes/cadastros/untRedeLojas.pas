{*******************************************}
{* CLASSE PARA REDE DE LOJAS               *}
{* DATA: 23/10/2007                        *}
{* AUTOR: RICARDO DE LIMA                  *}
{****************************************RL*}

unit untRedeLojas;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms;

Type TRedeLojas = Class(TComponent)
  Private
    FAutInc: String;
    FCodRed: String;
    FDesRed: String;
    FCodEmp: String;

  Public

    qryCadRed: TUniQuery;
    dtsCadRed: TDataSource;

    procedure pLimpaDados;
    procedure pAtuDados;

    function fCarregaCadRed(strCodRed: String = ''): Boolean;

    property strCodRed: String Read FCodRed Write FCodRed;
    property strDesRed: String Read FDesRed Write FDesRed;
    property strCodEmp: String Read FCodEmp Write FCodEmp;
    property strAutInc: String Read FAutInc Write FautInc;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

implementation

uses untfuncoesSimples;

{ TRedeLojas }

constructor TRedeLojas.Create(Owner: TComponent);
begin
  Inherited;

  Try

    qryCadRed := fCriaQuery;
    dtsCadRed := fCriaDataSource(qryCadRed);

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

destructor TRedeLojas.Destroy;
begin

  FreeAndNil(dtsCadRed);
  FreeAndNil(qryCadRed);

  inherited;
end;

{*******************************************}
{* ATUALIZA DADOS DAS VARIÁVEIS            *}
{****************************************RL*}
procedure TRedeLojas.pAtuDados;
begin

  Try

    If (Not qryCadRed.Active) Or (qryCadRed.IsEmpty) Then
    Begin
      pLimpaDados;
      Exit;
    End;

    With qryCadRed Do
    Begin
      FAutInc := FieldByName('AUTOINCREM').AsString;
      FCodRed := FieldByName('RED_CODRED').AsString;
      FDesRed := FieldByName('RED_DESRED').AsString;
      FCodEmp := FieldByName('RED_CODEMP').AsString;
    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{*******************************************}
{* LIMPA DADOS DAS VARIÁVEIS               *}
{****************************************RL*}
procedure TRedeLojas.pLimpaDados;
Begin

  FAutInc := '';
  FCodRed := '';
  FDesRed := '';
  FCodEmp := '';

End;

function TRedeLojas.fCarregaCadRed(strCodRed: String = ''): Boolean;
begin

  Result := False;

  With qryCadRed Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add('SELECT   ');
    SQL.Add('  *      ');
    SQL.Add('FROM     ');
    SQL.Add('  CADRED ');

    If Not fEmptyStr(strCodRed) Then
    Begin
      SQL.Add('WHERE    ');
      SQL.Add('  RED_CODRED = :CODRED ');
      ParamByName('CODRED').AsString := strCodRed;
    End;

    Open;

    If Not IsEmpty Then
    Begin
      Result := True;
      pAtuDados;
    End
    Else
      pLimpaDados;

    Close;

  End;

end;

end.

