unit untBtnCarregaFormulasCadastradaOnClickDuxoneGlobal;

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
    qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "DUX" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
    qryRegSelecionado.Open;

    If qryRegSelecionado.IsEmpty Then
    Begin
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    D.DUX_CODDUX,         '; pAddColuna('Código');
      strSQL := strSQL + '    D.DUX_CODOEM,         '; pAddColuna('Código Oem');
      strSQL := strSQL + '    D.DUX_LINHA_,         '; pAddColuna('Linha');
      strSQL := strSQL + '    D.DUX_QUALID,         '; pAddColuna('Qualidade');
      strSQL := strSQL + '    D.DUX_ALTERN,         '; pAddColuna('Alternativa');
      strSQL := strSQL + '    D.DUX_REGIAO,         '; pAddColuna('Região');
      strSQL := strSQL + '    D.DUX_DESCRI,         '; pAddColuna('Descrição');
      strSQL := strSQL + '    D.DUX_MONTAD,         '; pAddColuna('Montadora');
      strSQL := strSQL + '    D.DUX_ANOCOR,         '; pAddColuna('Ano');
      strSQL := strSQL + '    D.DUX_LITRAG,         '; pAddColuna('Volume');
      strSQL := strSQL + '    D.DUX_DTACAD,         '; pAddColuna('Data Cadastro');
      strSQL := strSQL + '    D.DUX_CODSEQ,         ';
      strSQL := strSQL + '    D.DUX_CODNFM,         ';
      strSQL := strSQL + '    D.DUX_MD5KEY,         '; pAddColuna('Chave Md5');
      strSQL := strSQL + '    D.DUX_ACRMOB,         ';
      strSQL := strSQL + '    D.DUX_OBSERV,         ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '  DUX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DUX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DUX_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DUX_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM          ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    DUX_CADDUX D          ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DUX_ATIVO_, "S")) = "S"              ';
    End
    Else
    Begin
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    D.DUX_CODDUX,         '; pAddColuna('Código');
      strSQL := strSQL + '    D.DUX_CODOEM,         '; pAddColuna('Código Oem');
      strSQL := strSQL + '    D.DUX_LINHA_,         '; pAddColuna('Linha');
      strSQL := strSQL + '    D.DUX_QUALID,         '; pAddColuna('Qualidade');
      strSQL := strSQL + '    D.DUX_ALTERN,         '; pAddColuna('Alternativa');
      strSQL := strSQL + '    D.DUX_REGIAO,         '; pAddColuna('Região');
      strSQL := strSQL + '    D.DUX_DESCRI,         '; pAddColuna('Descrição');
      strSQL := strSQL + '    D.DUX_MONTAD,         '; pAddColuna('Montadora');
      strSQL := strSQL + '    D.DUX_ANOCOR,         '; pAddColuna('Ano');
      strSQL := strSQL + '    D.DUX_LITRAG,         '; pAddColuna('Volume');
      strSQL := strSQL + '    D.DUX_DTACAD,         '; pAddColuna('Data Cadastro');
      strSQL := strSQL + '    D.DUX_CODSEQ,         ';
      strSQL := strSQL + '    D.DUX_CODNFM,         ';
      strSQL := strSQL + '    D.DUX_MD5KEY,         '; pAddColuna('Chave Md5');
      strSQL := strSQL + '    D.DUX_ACRMOB,         ';
      strSQL := strSQL + '    D.DUX_OBSERV,         ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '  D.DUX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  D.DUX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  D.DUX_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  D.DUX_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM          ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    DUX_CADDUX D          ';
      strSQL := strSQL + '  WHERE TRUE              ';
      strSQL := strSQL + '    AND UPPER(IFNULL(DUX_ATIVO_, "S")) = "S"              ';
      strSQL := strSQL + '    AND D.AUTOINCREM = "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
      strSQL := strSQL + '  UNION ALL            ';
      strSQL := strSQL + '  SELECT               ';
      strSQL := strSQL + '    D.DUX_CODDUX,         ';
      strSQL := strSQL + '    D.DUX_CODOEM,         ';
      strSQL := strSQL + '    D.DUX_LINHA_,         ';
      strSQL := strSQL + '    D.DUX_QUALID,         ';
      strSQL := strSQL + '    D.DUX_ALTERN,         ';
      strSQL := strSQL + '    D.DUX_REGIAO,         ';
      strSQL := strSQL + '    D.DUX_DESCRI,         ';
      strSQL := strSQL + '    D.DUX_MONTAD,         ';
      strSQL := strSQL + '    D.DUX_ANOCOR,         ';
      strSQL := strSQL + '    D.DUX_LITRAG,         ';
      strSQL := strSQL + '    D.DUX_DTACAD,         ';
      strSQL := strSQL + '    D.DUX_CODSEQ,         ';
      strSQL := strSQL + '    D.DUX_CODNFM,         ';
      strSQL := strSQL + '    D.DUX_MD5KEY,         ';
      strSQL := strSQL + '    D.DUX_ACRMOB,         ';
      strSQL := strSQL + '    D.DUX_OBSERV,         ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '  DUX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DUX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DUX_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DUX_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM          ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    DUX_CADDUX D          ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DUX_ATIVO_, "S")) = "S"              ';
      strSQLWhere := strSQLWhere + '    AND D.AUTOINCREM <> "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
    End;

    qryRegSelecionado.Close;

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['DUX_CODDUX'], 'AUTOINCREM',
      'DUX_CADDUX', 'untBtnCarregaFormulasCadastradaOnClickDuxoneGlobal', 'Consulta Dinâmica - Duxone Global', qryCadastro, [], []) Then
    Begin
      For intContador := 1 To 20 Do
      Begin
        GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;

        If Pos('DILUÍDO', qryCadastro.FieldByName('DUX_DESCRI').AsString) > 0 Then
          GetFieldByControle('dbeQtdC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat
        Else
          GetFieldByControle('dbeQtdC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('DUX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      End;
      Tela.SelectNext;
      DeletarRegistro('DUX', TAutcomTintaFactory.Get.GetUsuarioLogado);
    End;
  Finally

  End;
end;

end.
