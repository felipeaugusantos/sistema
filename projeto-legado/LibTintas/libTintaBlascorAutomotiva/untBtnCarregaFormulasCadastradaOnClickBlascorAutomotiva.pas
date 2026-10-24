unit untBtnCarregaFormulasCadastradaOnClickBlascorAutomotiva;

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
     strSQL := strSQL + '    BLA_CODIGO,            '; pAddColuna('Código');
     strSQL := strSQL + '    BLA_CODUNI,            '; pAddColuna('Código Universal');
     strSQL := strSQL + '    BLA_DESCRI,            '; pAddColuna('Descrição Cor');
     strSQL := strSQL + '    BLA_ANOINI,            '; pAddColuna('Ano Inicial');
     strSQL := strSQL + '    BLA_ANOFIM,            '; pAddColuna('Ano Final');
     strSQL := strSQL + '    LIN_DESCRI,            '; pAddColuna('Linha');
     strSQL := strSQL + '    MON_DESCRI,            '; pAddColuna('Montadora');
     strSQL := strSQL + '    BLA_DTACAD,            '; pAddColuna('Data Cadastro');
     strSQL := strSQL + '    BLA_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');


     For intContador := 1 To 20 Do
     Begin
       strSQL := strSQL + '   BLA_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
       strSQL := strSQL + '   BLA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
     End;

     strSQL := strSQL + '    BLA_MD5KEY,            '; pAddColuna('Chave Md5');
     strSQL := strSQL + '    BLA_CADBLA.AUTOINCREM             ';

     strSQL := strSQL + '  FROM                       ';
     strSQL := strSQL + '    BLA_CADBLA               ';
     strSQL := strSQL + ' 	LEFT JOIN BLA_CADMON  ';
     strSQL := strSQL + ' 	ON (BLA_CODMON = MON_CODMON) ';
     strSQL := strSQL + ' 	LEFT JOIN BLA_CADLIN ';
     strSQL := strSQL + ' 	ON (BLA_CODLIN = LIN_CODLIN) ';
   End
   Else
   Begin
     strSQL := strSQL + '  SELECT                   ';
     strSQL := strSQL + '    BLA_CODIGO,            '; pAddColuna('Código');
     strSQL := strSQL + '    BLA_CODUNI,            '; pAddColuna('Código Universal');
     strSQL := strSQL + '    BLA_DESCRI,            '; pAddColuna('Descrição Cor');
     strSQL := strSQL + '    BLA_ANOINI,            '; pAddColuna('Ano Inicial');
     strSQL := strSQL + '    BLA_ANOFIM,            '; pAddColuna('Ano Final');
     strSQL := strSQL + '    LIN_DESCRI,            '; pAddColuna('Linha');
     strSQL := strSQL + '    MON_DESCRI,            '; pAddColuna('Montadora');
     strSQL := strSQL + '    BLA_DTACAD,            '; pAddColuna('Data Cadastro');
     strSQL := strSQL + '    BLA_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');


     For intContador := 1 To 20 Do
     Begin
       strSQL := strSQL + '   BLA_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
       strSQL := strSQL + '   BLA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
     End;

     strSQL := strSQL + '    BLA_MD5KEY,            '; pAddColuna('Chave Md5');
     strSQL := strSQL + '    BLA_CADBLA.AUTOINCREM             ';
     strSQL := strSQL + '  FROM                         ';
     strSQL := strSQL + '    BLA_CADBLA                 ';
     strSQL := strSQL + ' 	LEFT JOIN BLA_CADMON  ';
     strSQL := strSQL + ' 	ON (BLA_CODMON = MON_CODMON) ';
     strSQL := strSQL + ' 	LEFT JOIN BLA_CADLIN ';
     strSQL := strSQL + ' 	ON (BLA_CODLIN = LIN_CODLIN) ';
     strSQL := strSQL + '  WHERE TRUE                   ';
     strSQL := strSQL + '    AND UPPER(IFNULL(BLA_ATIVAD, "S")) = "S"         ';
     strSQL := strSQL + '    AND A.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
     strSQL := strSQL + '  UNION ALL            ';
     strSQL := strSQL + '  SELECT                   ';
     strSQL := strSQL + '    BLA_CODIGO,            ';
     strSQL := strSQL + '    BLA_CODUNI,            ';
     strSQL := strSQL + '    BLA_DESCRI,            ';
     strSQL := strSQL + '    BLA_ANOINI,            ';
     strSQL := strSQL + '    BLA_ANOFIM,            ';
     strSQL := strSQL + '    LIN_DESCRI,            ';
     strSQL := strSQL + '    MON_DESCRI,            ';
     strSQL := strSQL + '    BLA_DTACAD,            ';
     strSQL := strSQL + '    BLA_ACRMOB,            ';


     For intContador := 1 To 20 Do
     Begin
       strSQL := strSQL + '   BLA_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
       strSQL := strSQL + '   BLA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
     End;

     strSQL := strSQL + '    BLA_MD5KEY,            ';
     strSQL := strSQL + '    BLA_CADBLA.AUTOINCREM             ';
     strSQL := strSQL + '  FROM                 ';
     strSQL := strSQL + '    BLA_CADBLA         ';
     strSQL := strSQL + ' 	LEFT JOIN BLA_CADMON  ';
     strSQL := strSQL + ' 	ON (BLA_CODMON = MON_CODMON) ';
     strSQL := strSQL + ' 	LEFT JOIN BLA_CADLIN ';
     strSQL := strSQL + ' 	ON (BLA_CODLIN = LIN_CODLIN) ';
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
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(BLA_ATIVAD, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(BLA_ATIVAD, "S")) = "S"       ';
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
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "BLA" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['BLA_CODIGO'], 'AUTOINCREM',
      'BLA_CADBLA', 'untBtnCarregaFormulasCadastradaOnClickBlascorAutomotiva', 'Consulta Dinâmica - Blascor Automotiva', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('BLA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('BLA', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
