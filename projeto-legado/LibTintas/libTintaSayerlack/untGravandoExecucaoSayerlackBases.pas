{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Sayerlack *}
{*******************************************************************************AC*}
unit untGravandoExecucaoSayerlackBases;

interface

uses
  untAbstractGravandoExecucaoSayerlack, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoSayerlackBases = class(TAbstractGravandoExecucaoSayerlack)
  private
    PlanilhaExcel: TStringList;
    qryAdoBases: TADODataSet;
    function fRetProduto(strCode, strDescri: String):String;
    function fRetornaDesUni(strDesEmb:String):String;
  public
    function fGetNomeGravacao: string; override;
    procedure pCarregarVariaveis(strPathFile: String);
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoSayerlackBases }

procedure TGravandoExecucaoSayerlackBases.Executar(const gravando: IGravando);
Var
  qryCadBas: IDataSet;

begin
  Gravando.Texto := 'Validando path do arquivo...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Path validado com sucesso...';

  Gravando.Texto := 'Carregando dados do Cadastro de Bases...';
  pCarregarVariaveis(GetPath);
  qryAdoBases.Open;
  qryAdoBases.First;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SAY_CADBAS');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Bases...';
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := '    SELECT * FROM SAY_CADBAS    ';
  qryCadBas.Open;


  Gravando.Texto := Format('Processando Bases [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0, 0, 0);

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      While Not qryAdoBases.Eof Do
      Begin
        If Not qryCadBas.Locate('BAS_BASE__;BAS_CODBAS;BAS_PRODUT;BAS_DESEMB', VarArrayOf([qryAdoBases.FieldByName('BASE').AsString,
          qryAdoBases.FieldByName('CODEBASE').AsString, fRetProduto(qryAdoBases.FieldByName('CODEBASE').AsString, qryAdoBases.FieldByName('BASE').AsString),
          qryAdoBases.FieldByName('EMBALA').AsString]), []) Then
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SAY_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_BASE__').AsString := qryAdoBases.FieldByName('BASE').AsString;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := qryAdoBases.FieldByName('CODEBASE').AsString;
          qryCadBas.FieldByName('BAS_PRODUT').AsString := fRetProduto(qryAdoBases.FieldByName('CODEBASE').AsString,
                                                                      qryAdoBases.FieldByName('BASE').AsString);
          qryCadBas.FieldByName('BAS_DESEMB').AsString := fRetornaDesUni(qryAdoBases.FieldByName('EMBALA').AsString);
          qryCadBas.Post;



        End;
        qryAdoBases.Next;
        Gravando.RegistrarProgresso(0, qryAdoBases.RecNo, qryAdoBases.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Bases processado com sucesso!';
  End;

end;

function TGravandoExecucaoSayerlackBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoSayerlackBases.fRetornaDesUni(
  strDesEmb: String): String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI    ';
    qryGen.ParamByName('CODUNI').AsString := strDesEmb;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := strDesEmb
    Else
      Result := qryGen.FieldByName('UNI_DESUNI').AsString;
  Except
    Raise;
  End;
end;

function TGravandoExecucaoSayerlackBases.fRetProduto(strCode,
  strDescri: String): String;
begin
  Result := '';
  If Pos('WVTI.7601', strCode) > 0 Then
    Result := 'IBS'
  Else If Pos('WVTT.7601', strCode) > 0 Then
    Result := 'TBS'
  Else If Pos(' BS ', strDescri) > 0 Then
  Begin
    If Pos('TRANSP', strDescri) > 0 Then
      Result := 'TBS'
    Else If Pos('BRANC', strDescri) > 0 Then
      Result := 'BBS'
    Else If Pos('INTERM', strDescri) > 0 Then
      Result := 'IBS';
  End
  Else If Pos(' BA ', strDescri) > 0 Then
  Begin
    If Pos('TRANSP', strDescri) > 0 Then
      Result := 'TBA'
    Else If Pos('BRANC', strDescri) > 0 Then
      Result := 'BBA'
    Else If Pos('INTERM', strDescri) > 0 Then
      Result := 'IBA';
  End;
end;

procedure TGravandoExecucaoSayerlackBases.pCarregarVariaveis(
  strPathFile: String);
begin
  qryAdoBases := TADODataSet.Create(Nil);
  qryAdoBases.Connection := fGetDataSayerlack(strPathFile);

  PlanilhaExcel := TStringList.Create;
  GetSayer.GetTableNames(PlanilhaExcel);

  qryAdoBases.CommandText := '    SELECT      ' +
                             '      B.F1 AS BASE,      ' +
                             '      B.F5 AS CODEBASE,  ' +
                             '      B.F6 AS EMBALA    ' +
                             '    FROM        ' +
                             '      [BASEPACK$] AS B   ' +
                             '    WHERE       ' +
                             '      B.F5 <> ''BaseCode''  ';

end;

end.
