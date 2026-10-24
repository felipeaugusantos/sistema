unit untBtnCarregaFormulasCadastradaOnClickAlvAutomotiva;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;


Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrColuna: Array Of String;
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
    procedure pAddColuna(Coluna: String);
    function fSelectSQL(arrColuna: Array Of String; qrySelecionado: IDataSet): String;
    function fSelectSQLWhere(arrColuna: Array Of String; qrySelecionado: IDataSet): String;
  Published
    Constructor Create(Const Cadastro: TAbstractCadastro); reintroduce;
  Published
    Procedure OnClick(Sender: Pointer);
  End;



implementation

uses untLibTintaFactory, untStrUtils;

{ TBtnCarregaBasesCadastrada }

constructor TBtnCarregaBasesCadastrada.Create(
  const Cadastro: TAbstractCadastro);
begin
  inherited Create('OnClick', Cadastro);
end;

procedure TBtnCarregaBasesCadastrada.DeletarRegistro(strIdePro,
  strCodOpe: String);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   DELETE FROM AUXBAS WHERE BAS_IDEPRO = :IDEPRO AND BAS_CODOPE = :CODOPE    ';
  qryGen.ParamByName('IDEPRO').AsString := strIdePro;
  qryGen.ParamByName('CODOPE').AsString := strCodOpe;
  qryGen.ExecSQL;
end;

function TBtnCarregaBasesCadastrada.fSelectSQL(arrColuna: array of String;
  qrySelecionado: IDataSet): String;
Var
  strSQL: String;
  intContador: Integer;
begin
   If qrySelecionado.IsEmpty Then
   Begin
     strSQL := strSQL + '  SELECT                   ';
     strSQL := strSQL + '    A.ALA_CODIGO,            '; pAddColuna('Código');
     strSQL := strSQL + '    A.ALA_DESCRI,            '; pAddColuna('Descrição');
     strSQL := strSQL + '    A.ALA_SYSTEM,            '; pAddColuna('Sistema');
     strSQL := strSQL + '    A.ALA_TECNOL,            '; pAddColuna('Tecnologia');
     strSQL := strSQL + '    A.ALA_TONALI,            '; pAddColuna('Tonalidade');
     strSQL := strSQL + '    A.ALA_ANOCOR,            '; pAddColuna('Ano da Cor');
     strSQL := strSQL + '    A.ALA_DTACAD,            '; pAddColuna('Data Cadastro');
     strSQL := strSQL + '    A.ALA_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');


     For intContador := 1 To 20 Do
     Begin
       strSQL := strSQL + '   A.ALA_CODB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
       strSQL := strSQL + '   A.ALA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
     End;

     strSQL := strSQL + '    A.ALA_MD5KEY,            '; pAddColuna('Chave Md5');
     strSQL := strSQL + '    A.AUTOINCREM             ';

     strSQL := strSQL + '  FROM                       ';
     strSQL := strSQL + '    ALA_CADALA A             ';
   End
   Else
   Begin
     strSQL := strSQL + '  SELECT                       ';
     strSQL := strSQL + '    A.ALA_CODIGO,            '; pAddColuna('Código');
     strSQL := strSQL + '    A.ALA_DESCRI,            '; pAddColuna('Descrição');
     strSQL := strSQL + '    A.ALA_SYSTEM,            '; pAddColuna('Sistema');
     strSQL := strSQL + '    A.ALA_TECNOL,            '; pAddColuna('Tecnologia');
     strSQL := strSQL + '    A.ALA_TONALI,            '; pAddColuna('Tonalidade');
     strSQL := strSQL + '    A.ALA_ANOCOR,            '; pAddColuna('Ano da Cor');
     strSQL := strSQL + '    A.ALA_DTACAD,            '; pAddColuna('Data Cadastro');
     strSQL := strSQL + '    A.ALA_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');

     For intContador := 1 To 20 Do
     Begin
       strSQL := strSQL + '    A.ALA_CODB' + TStrUtils.fStrZero(intContador, 2) + ',    ';
       strSQL := strSQL + '    A.ALA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',    ';
     End;

     strSQL := strSQL + '    A.ALA_MD5KEY,              ';  pAddColuna('Chave Md5');
     strSQL := strSQL + '    A.AUTOINCREM               ';
     strSQL := strSQL + '  FROM                         ';
     strSQL := strSQL + '    ALA_CADALA A               ';
     strSQL := strSQL + '  WHERE TRUE                   ';
     strSQL := strSQL + '    AND UPPER(IFNULL(ALA_ATIVAD, "S")) = "S"         ';
     strSQL := strSQL + '    AND A.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
     strSQL := strSQL + '  UNION ALL            ';
     strSQL := strSQL + '  SELECT               ';
     strSQL := strSQL + '    A.ALA_CODIGO,      ';
     strSQL := strSQL + '    A.ALA_DESCRI,      ';
     strSQL := strSQL + '    A.ALA_SYSTEM,      ';
     strSQL := strSQL + '    A.ALA_TECNOL,      ';
     strSQL := strSQL + '    A.ALA_TONALI,      ';
     strSQL := strSQL + '    A.ALA_ANOCOR,      ';
     strSQL := strSQL + '    A.ALA_DTACAD,      ';
     strSQL := strSQL + '    A.ALA_ACRMOB,      ';

     For intContador := 1 To 20 Do
     Begin
       strSQL := strSQL + '    A.ALA_CODB' + TStrUtils.fStrZero(intContador, 2) + ',    ';
       strSQL := strSQL + '    A.ALA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',    ';
     End;

     strSQL := strSQL + '    A.ALA_MD5KEY,      ';
     strSQL := strSQL + '    A.AUTOINCREM       ';
     strSQL := strSQL + '  FROM                 ';
     strSQL := strSQL + '    ALA_CADALA A       ';
   End;

   Result := strSQL;
end;

function TBtnCarregaBasesCadastrada.fSelectSQLWhere(arrColuna: array of String;
  qrySelecionado: IDataSet): String;
Var
  strSQLWhere: String;
begin
  If qrySelecionado.IsEmpty Then
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE       ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(ALA_ATIVAD, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(ALA_ATIVAD, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND A.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
  End;

  Result := strSQLWhere;
end;

procedure TBtnCarregaBasesCadastrada.OnClick(Sender: Pointer);
Var
  qryCadastro: IDataSet;
  qryRegSelecionado: IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup: String;
  intContador: Integer;
begin
  Try
    qryCadastro := TAutcomTintaFactory.Get.fGetDataSet;
    strSQL := '';
    strSQLWhere := '';
    strSQLGroup := '';

     qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
     qryRegSelecionado.Close;
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "ALA" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['ALA_CODIGO'], 'AUTOINCREM',
      'ALA_CADALA', 'untBtnCarregaFormulasCadastradaOnClickAlvAutomotiva', 'Consulta Dinâmica - Alv Automotiva', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('ALA', TAutcomTintaFactory.Get.GetUsuarioLogado);
     End;
  Except
     Raise;
  End;
end;

procedure TBtnCarregaBasesCadastrada.pAddColuna(Coluna: String);
begin
  SetLength(arrColuna, Succ(Length(arrColuna)));
  arrColuna[High(arrColuna)] := Coluna;
end;

end.
