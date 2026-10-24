{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta MazaImobiliaria *}
{***************************************************************************PH*}
unit untGravandoExecucaoMazaImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoMazaImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni;

Type
  TGravandoExecucaoMazaImobiliariaCores = class(TAbstractGravandoExecucaoMazaImobiliaria)
  private
    function fRetUnidade(fltEmbalagem: Double): String;
    function fRetFatorUnidade(fltEmbalagemPadrao: Double; fltEmbalagemNova: Double): Double;
  public
    function fGetPath(intContador: Integer): String; override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;
implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoMazaImobiliariaCores }

procedure TGravandoExecucaoMazaImobiliariaCores.Executar(const gravando: IGravando);
var
  qryCores: TUniQuery;
  qryCadCor: IDataSet;
  strSQL: String;
  intQuantidade: Integer;
  qryEmbalagems: TUniQuery;
  fltEmbalagemNv: Double;
  fltFator: Double;
  qryColorantes: TUniQuery;
  intIdx: Integer;
  strMd5: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    intIdx := 1;

    Gravando.Texto := 'Carregando Dados do Cadastro de Cores...';
    qryCores := TUniQuery.Create(Nil);
    qryCores.Connection := fConexaoPostgreSQL;

    strSQL := '';
    strSQL := strSQL + '  SELECT       ';
    strSQL := strSQL + '    base.codigo AS CODIGOBASE,    ';
    strSQL := strSQL + '    base.descricao AS DESCRICAOBASE,    ';
    strSQL := strSQL + '    produto.descricao AS DESCRICAOPRODUTO,    ';
    strSQL := strSQL + '    subcolecao.descricao AS SUBCOLECAO,   ';
    strSQL := strSQL + '    embalagem.conteudo AS EMBALAGEM,    ';
    strSQL := strSQL + '    produto_base_embalagem.id_embalagem AS ID_EMB,    ';
    strSQL := strSQL + '    padraocor.r AS RED,   ';
    strSQL := strSQL + '    padraocor.g AS GREEN,   ';
    strSQL := strSQL +  '   padraocor.b AS BLUE,    ';
    strSQL := strSQL + '    padraocor.familia AS FAMILIACOR,    ';
    strSQL := strSQL + '    padraocor.descricao AS NOMCOR,    ';
    strSQL := strSQL + '    padraocor.codigo as REFERE,     ';
    strSQL := strSQL + '    formula.baixa_cobertura as BAICOB,  ';
    strSQL := strSQL + '    formula.corante1 AS COR01,    ';
    strSQL := strSQL + '    formula.qtd1 AS QTD01,    ';
    strSQL := strSQL + '    formula.corante2 AS COR02,    ';
    strSQL := strSQL + '    formula.qtd2 AS QTD02,    ';
    strSQL := strSQL + '    formula.corante3 AS COR03,    ';
    strSQL := strSQL + '    formula.qtd3 AS QTD03,    ';
    strSQL := strSQL + '    formula.corante4 AS COR04,    ';
    strSQL := strSQL + '    formula.qtd4 AS QTD04,    ';
    strSQL := strSQL + '    formula.corante5 AS COR05,    ';
    strSQL := strSQL + '    formula.qtd5 AS QTD05,    ';
    strSQL := strSQL + '    formula.corante6 AS COR06,    ';
    strSQL := strSQL + '    formula.qtd6 AS QTD06     ';
    strSQL := strSQL + '  FROM       ';
    strSQL := strSQL + '    formula       ';
    strSQL := strSQL + '  INNER JOIN base ON    ';
    strSQL := strSQL + '    base.id = formula.id_base   ';
    strSQL := strSQL + '  INNER JOIN produto ON     ';
    strSQL := strSQL + '    produto.id = formula.id_produto     ';
    strSQL := strSQL + '  INNER JOIN subcolecao ON    ';
    strSQL := strSQL + '    subcolecao.id = formula.id_subcolecao     ';
    strSQL := strSQL + '  INNER JOIN embalagem ON     ';
    strSQL := strSQL + '    embalagem.id = formula.id_embalagem   ';
    strSQL := strSQL + '  INNER JOIN padraocor ON     ';
    strSQL := strSQL + '    padraocor.id = formula.id_padraocor     ';
    strSQL := strSQL + '  INNER JOIN produto_base_embalagem ON      ';
    strSQL := strSQL + '    produto_base_embalagem.id_base = formula.id_base AND    ';
    strSQL := strSQL + '    produto_base_embalagem.id_produto = formula.id_produto  ';

    qryCores.Close;
    qryCores.SQL.Clear;
    qryCores.SQL.Add(strSQL);
    qryCores.Open;

    qryEmbalagems := TUniQuery.Create(Nil);
    qryEmbalagems.Connection := fConexaoPostgreSQL;

    strSQL := '';
    strSQL := ' SELECT * FROM embalagem ';

    qryEmbalagems.Close;
    qryEmbalagems.SQL.Clear;
    qryEmbalagems.SQL.Add(strSQL);
    qryEmbalagems.Open;

    qryColorantes := TUniQuery.Create(Nil);
    qryColorantes.Connection := fConexaoPostgreSQL;

    strSQL := '';
    strSQL := ' SELECT * FROM corante ';

    qryColorantes.Close;
    qryColorantes.SQL.Clear;
    qryColorantes.SQL.Add(strSQL);
    qryColorantes.Open;

    If qryCores.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de Cores está vazio! Verificar.';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Cores...';
    qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
    qryCadCor.SQL := '    DELETE FROM MZI_CADMZI    ';
    qryCadCor.ExecSQL;
    qryCadCor.SQL.Empty;
    Gravando.Texto := 'Cadastro de Cores deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('MZI_CADMZI');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Cores...';
    qryCadCor.SQL := '      SELECT * FROM MZI_CADMZI    ';
    qryCadCor.Open;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryCores.First;

    Try
      While Not qryCores.Eof Do
      Begin
        If Not qryEmbalagems.Locate('id', qryCores.FieldByName('ID_EMB').AsString, []) Then
        Begin
          qryCores.Next;
          Continue;
        End;

        qryCadCor.Insert;
        qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZI_CADMZI', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadCor.FieldByName('MZI_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadCor.FieldByName('MZI_CODMZI').AsInteger := intIdx;
        qryCadCor.FieldByName('MZI_COLNUM').AsString := qryCores.FieldByName('REFERE').AsString;
        qryCadCor.FieldByName('MZI_COLNAM').AsString := qryCores.FieldByName('NOMCOR').AsString;
        qryCadCor.FieldByName('MZI_PRODUT').AsString := qryCores.FieldByName('DESCRICAOPRODUTO').AsString;
        qryCadCor.FieldByName('MZI_CODBAS').AsString := qryCores.FieldByName('DESCRICAOBASE').AsString;
        qryCadCor.FieldByName('MZI_ATIVAD').AsString := 'S';
        qryCadCor.FieldByName('MZI_SUBCOL').AsString := qryCores.FieldByName('SUBCOLECAO').AsString;
        qryCadCor.FieldByName('MZI_CODUNI').AsString := fRetUnidade(qryEmbalagems.FieldByName('conteudo').AsFloat);
        qryCadCor.FieldByName('MZI_BAICOB').AsString := TAutcomTintaFactory.Get.IIF(qryCores.FieldByName('BAICOB').AsString = 'True', 'S', 'N');



        strMd5 := '';
        strMd5 := strMd5 + (qryCadCor.FieldByName('MZI_CODUNI').AsString + qryCadCor.FieldByName('MZI_PRODUT').AsString +
                            qryCadCor.FieldByName('MZI_COLNUM').AsString + qryCadCor.FieldByName('MZI_CODBAS').AsString);

        fltEmbalagemNv := qryEmbalagems.FieldByName('conteudo').AsFloat;
        fltFator := fRetFatorUnidade(qryCores.FieldByName('EMBALAGEM').AsFloat, fltEmbalagemNv);



        For intQuantidade := 1 To 6 Do
        Begin
          If TStrUtils.fEmptyStr(qryCores.FieldByName('COR' + TStrUtils.fStrZero(intQuantidade, 2)).AsString) Then
            Break;

          If Not qryColorantes.Locate('id', qryCores.FieldByName('COR' + TStrUtils.fStrZero(intQuantidade, 2)).AsString, []) Then
            Break;

          qryCadCor.FieldByName('MZI_CODC' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := qryColorantes.FieldByName('codigo').AsString;
          qryCadCor.FieldByName('MZI_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat := qryCores.FieldByName('QTD' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat * fltFator;

          strMd5 := strMd5 + qryCadCor.FieldByName('MZI_CODC' + TStrUtils.fStrZero(intQuantidade, 2)).AsString;
          strMd5 := strMd5 + FloatToStr(qryCadCor.FieldByName('MZI_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat);
        End;

        qryCadCor.FieldByName('MZI_MD5KEY').AsString := GetMd5(strMd5);

        qryCadCor.Post;

        qryCores.Next;
        Inc(intIdx, 1);
        Gravando.RegistrarProgresso(0, qryCores.RecNo, qryCores.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    FreeAndNil(qryCores);
    FreeAndNil(qryEmbalagems);
    FreeAndNil(qryColorantes);
  End;
end;

function TGravandoExecucaoMazaImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoMazaImobiliariaCores.fGetPath(
  intContador: Integer): String;
begin
  Result := conf.fGet('PATMZI');
end;

function TGravandoExecucaoMazaImobiliariaCores.fRetFatorUnidade(
  fltEmbalagemPadrao, fltEmbalagemNova: Double): Double;
begin
  Result := fltEmbalagemNova / fltEmbalagemPadrao;
end;

function TGravandoExecucaoMazaImobiliariaCores.fRetUnidade(fltEmbalagem: Double): String;
begin
  Result := '';

  If fltEmbalagem < 1500 Then
    Result := 'LT'
  Else If fltEmbalagem < 5000 Then
    Result := 'GL'
  Else If fltEmbalagem > 5000 Then
    Result := 'LA';
end;

end.

