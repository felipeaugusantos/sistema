unit untBtnCarregaFormulasCadastradaOnClickDuxone2Global;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrColuna: Array Of String;
    procedure pAddColuna(Coluna: String);
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
begin
  Try
    qryCadastro := TAutcomTintaFactory.Get.fGetDataSet;
    strSQL := '';
    strSQLWhere := '';
    strSQLGroup := '';

    qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
    qryRegSelecionado.Close;
    qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "DU2" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
    qryRegSelecionado.Open;

    If qryRegSelecionado.IsEmpty Then
    Begin
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    D.DU2_CODDU2,         '; pAddColuna('Código');
      strSQL := strSQL + '    D.DU2_CODOEM,         '; pAddColuna('Código Oem');
      strSQL := strSQL + '    D.DU2_LINHA_,         '; pAddColuna('Linha');
      strSQL := strSQL + '    D.DU2_QUALID,         '; pAddColuna('Qualidade');
      strSQL := strSQL + '    D.DU2_ALTERN,         '; pAddColuna('Alternativa');
      strSQL := strSQL + '    D.DU2_REGIAO,         '; pAddColuna('Região');
      strSQL := strSQL + '    D.DU2_DESCRI,         '; pAddColuna('Descrição');
      strSQL := strSQL + '    D.DU2_MONTAD,         '; pAddColuna('Montadora');
      strSQL := strSQL + '    D.DU2_ANOCOR,         '; pAddColuna('Ano');
      strSQL := strSQL + '    D.DU2_LITRAG,         '; pAddColuna('Volume');
      strSQL := strSQL + '    D.DU2_DTACAD,         '; pAddColuna('Data Cadastro');
      strSQL := strSQL + '    D.DU2_CODSEQ,         ';
      strSQL := strSQL + '    D.DU2_CODNFM,         ';
      strSQL := strSQL + '    D.DU2_MD5KEY,         '; pAddColuna('Chave Md5');
      strSQL := strSQL + '    D.DU2_ACRMOB,         ';
      strSQL := strSQL + '    D.DU2_OBSERV,         ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '  DU2_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DU2_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DU2_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM          ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    DU2_CADDU2 D          ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DU2_ATIVO_, "S")) = "S"              ';
    End
    Else
    Begin
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    D.DU2_CODDU2,         '; pAddColuna('Código');
      strSQL := strSQL + '    D.DU2_CODOEM,         '; pAddColuna('Código Oem');
      strSQL := strSQL + '    D.DU2_LINHA_,         '; pAddColuna('Linha');
      strSQL := strSQL + '    D.DU2_QUALID,         '; pAddColuna('Qualidade');
      strSQL := strSQL + '    D.DU2_ALTERN,         '; pAddColuna('Alternativa');
      strSQL := strSQL + '    D.DU2_REGIAO,         '; pAddColuna('Região');
      strSQL := strSQL + '    D.DU2_DESCRI,         '; pAddColuna('Descrição');
      strSQL := strSQL + '    D.DU2_MONTAD,         '; pAddColuna('Montadora');
      strSQL := strSQL + '    D.DU2_ANOCOR,         '; pAddColuna('Ano');
      strSQL := strSQL + '    D.DU2_LITRAG,         '; pAddColuna('Volume');
      strSQL := strSQL + '    D.DU2_DTACAD,         '; pAddColuna('Data Cadastro');
      strSQL := strSQL + '    D.DU2_CODSEQ,         ';
      strSQL := strSQL + '    D.DU2_CODNFM,         ';
      strSQL := strSQL + '    D.DU2_MD5KEY,         '; pAddColuna('Chave Md5');
      strSQL := strSQL + '    D.DU2_ACRMOB,         ';
      strSQL := strSQL + '    D.DU2_OBSERV,         ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '  D.DU2_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  D.DU2_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  D.DU2_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM          ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    DU2_CADDU2 D          ';
      strSQL := strSQL + '  WHERE TRUE              ';
      strSQL := strSQL + '    AND UPPER(IFNULL(DU2_ATIVO_, "S")) = "S"              ';
      strSQL := strSQL + '    AND D.AUTOINCREM = "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
      strSQL := strSQL + '  UNION ALL            ';
      strSQL := strSQL + '  SELECT               ';
      strSQL := strSQL + '    D.DU2_CODDU2,         ';
      strSQL := strSQL + '    D.DU2_CODOEM,         ';
      strSQL := strSQL + '    D.DU2_LINHA_,         ';
      strSQL := strSQL + '    D.DU2_QUALID,         ';
      strSQL := strSQL + '    D.DU2_ALTERN,         ';
      strSQL := strSQL + '    D.DU2_REGIAO,         ';
      strSQL := strSQL + '    D.DU2_DESCRI,         ';
      strSQL := strSQL + '    D.DU2_MONTAD,         ';
      strSQL := strSQL + '    D.DU2_ANOCOR,         ';
      strSQL := strSQL + '    D.DU2_LITRAG,         ';
      strSQL := strSQL + '    D.DU2_DTACAD,         ';
      strSQL := strSQL + '    D.DU2_CODSEQ,         ';
      strSQL := strSQL + '    D.DU2_CODNFM,         ';
      strSQL := strSQL + '    D.DU2_MD5KEY,         ';
      strSQL := strSQL + '    D.DU2_ACRMOB,         ';
      strSQL := strSQL + '    D.DU2_OBSERV,         ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '  DU2_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DU2_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DU2_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM          ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    DU2_CADDU2 D          ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DU2_ATIVO_, "S")) = "S"              ';
      strSQLWhere := strSQLWhere + '    AND D.AUTOINCREM <> "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
    End;

    qryRegSelecionado.Close;

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['DU2_CODDU2'], 'AUTOINCREM',
      'DU2_CADDU2', 'untBtnCarregaFormulasCadastradaOnClickDuxone2Global', 'Consulta Dinâmica - Duxone Global 2', qryCadastro, [], []) Then
    Begin
      For intContador := 1 To 20 Do
      Begin
        GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('DU2_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
        GetFieldByControle('dbeQtdC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('DU2_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      End;
      Tela.SelectNext;
      DeletarRegistro('DU2', TAutcomTintaFactory.Get.GetUsuarioLogado);
    End;
  Finally

  End;
end;

procedure TBtnCarregaBasesCadastrada.pAddColuna(Coluna: String);
begin
  SetLength(arrColuna, Succ(Length(arrColuna)));
  arrColuna[High(arrColuna)] := Coluna;
end;

end.
