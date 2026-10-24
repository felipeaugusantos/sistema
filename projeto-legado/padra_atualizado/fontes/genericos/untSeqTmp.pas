unit untSeqTmp;

interface

  uses Uni, SysUtils;

  function fRetSeqTmp: String;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core;
{$ELSE}
  untfuncoesSimples, untModulo;
{$ENDIF}

{*****************************************}
{* RETORNA O SEQUENCIAL  DO CFG_SEQTMP   *}
{**************************************JB*}
function fRetSeqTmp: String;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;
    blnGravaLog: Boolean;
begin
  blnGravaLog := VS_blnGravaLogTransacao;
  Try
    VS_blnGravaLogTransacao := False;
    qryCfgSis := fCriaQuery(nil);

    blnComita := False;

    If Not fInTransaction Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    Try

      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := VS_strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_SEQTMP';
        Open;

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := fStrZero(FieldByName('SIS_VALCFG').AsString, 7)
        Else
          Result := fStrZero('1', 7);

        fAtuCfgSis('SEQTMP', IntToStr(StrToInt(Result)+1));

        Result := Result + VS_strCodEmp;
      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;
        Raise;
      End;
    End;

  Finally
    VS_blnGravaLogTransacao := blnGravaLog;
    FreeAndNil(qryCfgSis);
  End;

end;

end.

