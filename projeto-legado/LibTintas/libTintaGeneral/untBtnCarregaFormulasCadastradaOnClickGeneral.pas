unit untBtnCarregaFormulasCadastradaOnClickGeneral;

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
  strSQL := '';

  If qrySelecionado.IsEmpty Then
  Begin
    strSQL := strSQL + '  SELECT                     ';
    strSQL := strSQL + '    G.GEN_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    G.GEN_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    G.GEN_VARIAC,            '; pAddColuna('Variação');
    strSQL := strSQL + '    G.GEN_OBSERV,            '; pAddColuna('Observação');
    strSQL := strSQL + '    MON_DESCRI,              '; pAddColuna('Montadora');
    strSQL := strSQL + '    G.GEN_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    G.GEN_ANOFIM,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    G.GEN_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    G.GEN_CODNFM,            '; pAddColuna('Código Nfm');
    strSQL := strSQL + '    G.GEN_CODMON,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    G.GEN_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    G.GEN_DILUID,            '; pAddColuna('Diluído');
    strSQL := strSQL + '    G.GEN_MD5KEY,            '; pAddColuna('MD5KEY');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   G.GEN_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   G.GEN_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    G.GEN_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    G.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    GEN_CADGEN G             ';
    strSQL := strSQL + '    LEFT JOIN GEN_CADMON ON MON_CODMON = G.GEN_CODMON ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                     ';
    strSQL := strSQL + '    G.GEN_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    G.GEN_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    G.GEN_VARIAC,            '; pAddColuna('Variação');
    strSQL := strSQL + '    G.GEN_OBSERV,            '; pAddColuna('Observação');
    strSQL := strSQL + '    MON_DESCRI,              '; pAddColuna('Montadora');
    strSQL := strSQL + '    G.GEN_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    G.GEN_ANOFIM,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    G.GEN_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    G.GEN_CODNFM,            '; pAddColuna('Código Nfm');
    strSQL := strSQL + '    G.GEN_CODMON,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    G.GEN_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    G.GEN_DILUID,            '; pAddColuna('Diluído');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   G.GEN_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   G.GEN_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    G.GEN_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    G.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                         ';
    strSQL := strSQL + '    GEN_CADGEN G               ';
    strSQL := strSQL + '    LEFT JOIN GEN_CADMON ON MON_CODMON = G.GEN_CODMON ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(G.GEN_ATIVAD, "S")) = "S"       ';
    strSQL := strSQL + '    AND G.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                     ';
    strSQL := strSQL + '    G.GEN_CODIGO,            ';
    strSQL := strSQL + '    G.GEN_DESCRI,            ';
    strSQL := strSQL + '    G.GEN_VARIAC,            ';
    strSQL := strSQL + '    G.GEN_OBSERV,            ';
    strSQL := strSQL + '    MON_DESCRI,              ';
    strSQL := strSQL + '    G.GEN_ANOINI,            ';
    strSQL := strSQL + '    G.GEN_ANOFIM,            ';
    strSQL := strSQL + '    G.GEN_DTACAD,            ';
    strSQL := strSQL + '    G.GEN_CODNFM,            ';
    strSQL := strSQL + '    G.GEN_CODMON,            ';
    strSQL := strSQL + '    G.GEN_ACRMOB,            ';
    strSQL := strSQL + '    G.GEN_DILUID,            ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   G.GEN_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   G.GEN_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    G.GEN_MD5KEY,            ';
    strSQL := strSQL + '    G.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                 ';
    strSQL := strSQL + '    GEN_CADGEN G       ';
    strSQL := strSQL + '    LEFT JOIN GEN_CADMON ON MON_CODMON = G.GEN_CODMON ';
  End;

  Result := strSQL;
end;

function TBtnCarregaBasesCadastrada.fSelectSQLWhere(arrColuna: array of String;
  qrySelecionado: IDataSet): String;
Var
  strSQLWhere: String;
begin
  strSQLWhere := '';

  If qrySelecionado.IsEmpty Then
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE ';
    strSQLWhere := strSQLWhere + '  AND UPPER(IFNULL(GEN_ATIVAD, "S")) = "S" ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '  AND UPPER(IFNULL(GEN_ATIVAD, "S")) = "S" ';
    strSQLWhere := strSQLWhere + '    AND G.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
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
    strSQLGroup := '';

     qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
     qryRegSelecionado.Close;
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "GEN" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['STA_CODSEQ'], 'AUTOINCREM',
      'GEN_CADGEN', 'untBtnCarregaFormulasCadastradaOnClickGeneral', 'Consulta Dinâmica - General', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('GEN_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('GEN_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('GEN', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
