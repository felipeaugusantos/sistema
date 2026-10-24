unit untBtnCarregaFormulasCadastradaOnClickAnjoAutomotiva;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);

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

procedure TBtnCarregaBasesCadastrada.OnClick(Sender: Pointer);
Var
  qryCadastro: IDataSet;
  qryRegSelecionado: IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup: String;
  intContador: Integer;

  arrColuna: Array Of String;

  procedure pAddColuna(Coluna: String);
  Begin
    SetLength(arrColuna, Succ(Length(arrColuna)));
    arrColuna[High(arrColuna)] := Coluna;
  End;

begin
  Try
    qryCadastro := TAutcomTintaFactory.Get.fGetDataSet;
    strSQL := '';
    strSQLWhere := '';
    strSQLGroup := '';

     qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
     qryRegSelecionado.Close;
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "AJT" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     If qryRegSelecionado.IsEmpty Then
     Begin
       strSQL := strSQL + '  SELECT                   ';
       strSQL := strSQL + '    A.AJT_CODIGO,            '; pAddColuna('Código');
       strSQL := strSQL + '    A.AJT_DESCRI,            '; pAddColuna('Descrição');
       strSQL := strSQL + '    A.AJT_PRODUT,            '; pAddColuna('Produto');
       strSQL := strSQL + '    A.AJT_ACABAM,            '; pAddColuna('Acabamento');
       strSQL := strSQL + '    A.AJT_VARIAC,            '; pAddColuna('Variação');
       strSQL := strSQL + '    A.AJT_CORMON,            '; pAddColuna('Cor Montadora');
       strSQL := strSQL + '    A.AJT_ANOINI,            '; pAddColuna('Ano Inicial');
       strSQL := strSQL + '    A.AJT_ANOFIM,            '; pAddColuna('Ano Fim');
       strSQL := strSQL + '    A.AJT_DTACAD,            '; pAddColuna('Data Cadastro');
       strSQL := strSQL + '    A.AJT_OBSERV,            '; pAddColuna('Observação');
       strSQL := strSQL + '    A.AJT_CODMON,            '; pAddColuna('Código Montadora');
       strSQL := strSQL + '    M.MON_DESCRI,            '; pAddColuna('Montadora');
       strSQL := strSQL + '    A.AJT_VOLUME,            '; pAddColuna('Volume Litro');
       strSQL := strSQL + '    A.AJT_GRAMA_,            '; pAddColuna('Total Gramas');
       strSQL := strSQL + '    A.AJT_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');


       For intContador := 1 To 20 Do
       Begin
         strSQL := strSQL + '   A.AJT_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
         strSQL := strSQL + '   A.AJT_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
       End;

       strSQL := strSQL + '    A.AJT_MD5KEY,            '; pAddColuna('Chave Md5');
       strSQL := strSQL + '    A.AUTOINCREM             ';

       strSQL := strSQL + '  FROM                       ';
       strSQL := strSQL + '    AJT_CADAJT A             ';
       strSQL := strSQL + '  LEFT JOIN AJT_CADMON M ON        ';
       strSQL := strSQL + '    M.MON_CODMON = A.AJT_CODMON          ';
       strSQLWhere := strSQLWhere + '  WHERE TRUE       ';
       strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(AJT_ATIVAD, "S")) = "S"   ';

     End
     Else
     Begin
       strSQL := strSQL + '  SELECT                       ';
       strSQL := strSQL + '    A.AJT_CODIGO,              ';  pAddColuna('Código');
       strSQL := strSQL + '    A.AJT_DESCRI,              ';  pAddColuna('Descrição');
       strSQL := strSQL + '    A.AJT_PRODUT,              ';  pAddColuna('Produto');
       strSQL := strSQL + '    A.AJT_ACABAM,              ';  pAddColuna('Acabamento');
       strSQL := strSQL + '    A.AJT_VARIAC,              ';  pAddColuna('Variação');
       strSQL := strSQL + '    A.AJT_CORMON,              ';  pAddColuna('Cor Montadora');
       strSQL := strSQL + '    A.AJT_ANOINI,              ';  pAddColuna('Ano Inicial');
       strSQL := strSQL + '    A.AJT_ANOFIM,              ';  pAddColuna('Ano Fim');
       strSQL := strSQL + '    A.AJT_DTACAD,              ';  pAddColuna('Data Cadastro');
       strSQL := strSQL + '    A.AJT_OBSERV,              ';  pAddColuna('Observação');
       strSQL := strSQL + '    A.AJT_CODMON,              ';  pAddColuna('Código Montadora');
       strSQL := strSQL + '    M.MON_DESCRI,              ';  pAddColuna('Montadora');
       strSQL := strSQL + '    A.AJT_VOLUME,              ';  pAddColuna('Volume Litro');
       strSQL := strSQL + '    A.AJT_GRAMA_,              ';  pAddColuna('Total Gramas');
       strSQL := strSQL + '    A.AJT_ACRMOB,              ';  pAddColuna('Acréscimo de mão de obra');

       For intContador := 1 To 20 Do
       Begin
         strSQL := strSQL + '    A.AJT_FORM' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '    A.AJT_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',    ';
       End;

       strSQL := strSQL + '    A.AJT_MD5KEY,              ';  pAddColuna('Chave Md5');
       strSQL := strSQL + '    A.AUTOINCREM               ';
       strSQL := strSQL + '  FROM                         ';
       strSQL := strSQL + '    AJT_CADAJT A               ';
       strSQL := strSQL + '  LEFT JOIN AJT_CADMON M ON          ';
       strSQL := strSQL + '    M.MON_CODMON = A.AJT_CODMON          ';
       strSQL := strSQL + '  WHERE TRUE                   ';
       strSQL := strSQL + '    AND UPPER(IFNULL(AJT_ATIVAD, "S")) = "S"         ';
       strSQL := strSQL + '    AND A.AUTOINCREM = "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
       strSQL := strSQL + '  UNION ALL            ';
       strSQL := strSQL + '  SELECT               ';
       strSQL := strSQL + '    A.AJT_CODIGO,      ';
       strSQL := strSQL + '    A.AJT_DESCRI,      ';
       strSQL := strSQL + '    A.AJT_PRODUT,      ';
       strSQL := strSQL + '    A.AJT_ACABAM,      ';
       strSQL := strSQL + '    A.AJT_VARIAC,      ';
       strSQL := strSQL + '    A.AJT_CORMON,      ';
       strSQL := strSQL + '    A.AJT_ANOINI,      ';
       strSQL := strSQL + '    A.AJT_ANOFIM,      ';
       strSQL := strSQL + '    A.AJT_DTACAD,      ';
       strSQL := strSQL + '    A.AJT_OBSERV,      ';
       strSQL := strSQL + '    A.AJT_CODMON,      ';
       strSQL := strSQL + '    M.MON_DESCRI,      ';
       strSQL := strSQL + '    A.AJT_VOLUME,      ';
       strSQL := strSQL + '    A.AJT_GRAMA_,      ';
       strSQL := strSQL + '    A.AJT_ACRMOB,      ';

       For intContador := 1 To 20 Do
       Begin
         strSQL := strSQL + '    A.AJT_FORM' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '    A.AJT_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',    ';
       End;

       strSQL := strSQL + '    A.AJT_MD5KEY,      ';
       strSQL := strSQL + '    A.AUTOINCREM       ';
       strSQL := strSQL + '  FROM                 ';
       strSQL := strSQL + '    AJT_CADAJT A       ';
       strSQL := strSQL + '  LEFT JOIN AJT_CADMON M ON      ';
       strSQL := strSQL + '    M.MON_CODMON = A.AJT_CODMON          ';
       strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
       strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(AJT_ATIVAD, "S")) = "S"       ';
       strSQLWhere := strSQLWhere + '    AND A.AUTOINCREM <> "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
     End;

     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['AJT_CODIGO'], 'AUTOINCREM',
      'AJT_CADAJT', 'untBtnCarregaFormulasCadastradaOnClickAnjoAutomotiva', 'Consulta Dinâmica - Anjo Automotiva', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('AJT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('AJT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('AJT', TAutcomTintaFactory.Get.GetUsuarioLogado);
     End;
  Except
     Raise;
  End;
end;

end.
