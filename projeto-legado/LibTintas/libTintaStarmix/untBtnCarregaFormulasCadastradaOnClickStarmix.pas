unit untBtnCarregaFormulasCadastradaOnClickStarmix;

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
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    S.STA_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    S.STA_NOMCOR,            '; pAddColuna('Nome Cor');
    strSQL := strSQL + '    S.STA_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    S.STA_CODLIN,            '; pAddColuna('Código da Linha');
    strSQL := strSQL + '    S.STA_DESLIN,            '; pAddColuna('Linha');
    strSQL := strSQL + '    S.STA_CODMON,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    S.STA_MONTAD,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    S.STA_UNIVER,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    S.STA_ANOCOR,            '; pAddColuna('Ano');
    strSQL := strSQL + '    S.STA_PESCOR,            '; pAddColuna('Peso da Cor');
    strSQL := strSQL + '    S.STA_PESFOR,            '; pAddColuna('Peso do Fornecedor');
    strSQL := strSQL + '    S.STA_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   S.STA_CODB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.STA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    S.STA_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    S.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    STA_CADSTA S             ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    S.STA_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    S.STA_NOMCOR,            '; pAddColuna('Nome Cor');
    strSQL := strSQL + '    S.STA_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    S.STA_CODLIN,            '; pAddColuna('Código da Linha');
    strSQL := strSQL + '    S.STA_DESLIN,            '; pAddColuna('Linha');
    strSQL := strSQL + '    S.STA_CODMON,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    S.STA_MONTAD,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    S.STA_UNIVER,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    S.STA_ANOCOR,            '; pAddColuna('Ano');
    strSQL := strSQL + '    S.STA_PESCOR,            '; pAddColuna('Peso da Cor');
    strSQL := strSQL + '    S.STA_PESFOR,            '; pAddColuna('Peso do Fornecedor');
    strSQL := strSQL + '    S.STA_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   S.STA_CODB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.STA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    S.STA_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    S.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                         ';
    strSQL := strSQL + '    STA_CADSTA S               ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(STA_ATIVAD, "S")) = "S"         ';
    strSQL := strSQL + '    AND S.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                     ';
    strSQL := strSQL + '    S.STA_CODSEQ,            ';
    strSQL := strSQL + '    S.STA_NOMCOR,            ';
    strSQL := strSQL + '    S.STA_DTACAD,            ';
    strSQL := strSQL + '    S.STA_CODLIN,            ';
    strSQL := strSQL + '    S.STA_DESLIN,            ';
    strSQL := strSQL + '    S.STA_CODMON,            ';
    strSQL := strSQL + '    S.STA_MONTAD,            ';
    strSQL := strSQL + '    S.STA_UNIVER,            ';
    strSQL := strSQL + '    S.STA_ANOCOR,            ';
    strSQL := strSQL + '    S.STA_PESCOR,            ';
    strSQL := strSQL + '    S.STA_PESFOR,            ';
    strSQL := strSQL + '    S.STA_ACRMOB,            ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   S.STA_CODB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.STA_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    S.STA_MD5KEY,            ';
    strSQL := strSQL + '    S.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                 ';
    strSQL := strSQL + '    STA_CADSTA S       ';
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
    strSQLWhere := strSQLWhere + '  WHERE TRUE       ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(STA_ATIVAD, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(STA_ATIVAD, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND S.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
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
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "STA" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['STA_CODSEQ'], 'AUTOINCREM',
      'STA_CADSTA', 'untBtnCarregaFormulasCadastradaOnClickStarmix', 'Consulta Dinâmica - Starmix', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('STA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtdB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('STA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('STA', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
