unit untFuncoes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untModulo,
{$ENDIF}
  Uni, untFuncoesSimples, System.SysUtils, Data.DB;

  function fSeqContaBanco(intQtdCod: Integer = 1): String;
  function fRetRcxCon(strCodEmp: String = ''): String;

implementation

uses
  untTypesSistema;

function fSeqContaBanco(intQtdCod: Integer = 1): String;
  Var
    strSequen: String;
    blnComita: Boolean;

    function fSequenCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;
    begin

      Try
        qryGenTmp := fCriaQuery;

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE CTB_SEQLAN FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN LIMIT 1');
          ParamByName('SEQLAN').AsString := strSequen;
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

      Finally
        FreeAndNil(qryGenTmp);
      End;

    end;

begin
  blnComita := False;

  If Not fInTransaction Then
  Begin
    fStartTransaction;
    blnComita := True;
  End;

  Repeat
    strSequen := VS_strCodEmp + untFuncoesSimples.fAtualizaProCod('MOVBAN', intQtdCod);
  Until (Not fSequenCadastrado);

  Result :=  strSequen;

  If blnComita Then
    fCommit;

end;

function fRetRcxCon(strCodEmp: String = ''): String;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;
    blnGravaLog: Boolean;
begin
  blnGravaLog := VS_blnGravaLogTransacao;
  Try
    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    qryCfgSis := fCriaQuery(nil);

    blnComita := False;

    If Not fInTransaction Then
    Begin
     {$IFDEF LINUX}
      AddOrSetGlobalVar('VS_blnGravaLogTransacao', False);
     {$ELSE}
      VS_blnGravaLogTransacao := False;
     {$ENDIF}
      fStartTransaction;
      blnComita := True;
    End;

    Try

      qryCfgSis.Close;
      qryCfgSis.SQL.Clear;
      qryCfgSis.SQL.Add('SELECT                     ');
      qryCfgSis.SQL.Add('  SIS_VALCFG               ');
      qryCfgSis.SQL.Add('FROM                       ');
      qryCfgSis.SQL.Add('  CFGSIS                   ');
      qryCfgSis.SQL.Add('WHERE                      ');
      qryCfgSis.SQL.Add('  SIS_CODEMP = :CODEMP AND ');
      qryCfgSis.SQL.Add('  SIS_CODCFG = :CODCFG     ');
      qryCfgSis.SQL.Add('FOR UPDATE                 ');

      qryCfgSis.ParamByName('CODEMP').Value := strCodEmp;
      qryCfgSis.ParamByName('CODCFG').Value := 'CFG_RCXCON';
      qryCfgSis.Open;

      If Not fEmptyStr(qryCfgSis.FieldByName('SIS_VALCFG').AsString) Then
        Result := {$IFDEF CONSULTA_PAGAMENTOS_PIX}untFuncoesSimples.{$ENDIF}fStrZero(qryCfgSis.FieldByName('SIS_VALCFG').AsString, 10)
      Else
        Result := {$IFDEF CONSULTA_PAGAMENTOS_PIX}untFuncoesSimples.{$ENDIF}fStrZero('1', 10);

      fAtuCfgSis('RCXCON', IntToStr(StrToIntDef(Result, 0)+1), strCodEmp);

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('Não consegui pegar o próximo sequencial de RCXCON em CFGSIS. Tente novamente!');
      End;
    End;

    If blnComita Then
      fCommit;

  Finally
   {$IFDEF LINUX}
    AddOrSetGlobalVar('VS_blnGravaLogTransacao', blnGravaLog);
   {$ELSE}
    VS_blnGravaLogTransacao := blnGravaLog;
   {$ENDIF}
    FreeAndNil(qryCfgSis);
  End;

end;

end.
