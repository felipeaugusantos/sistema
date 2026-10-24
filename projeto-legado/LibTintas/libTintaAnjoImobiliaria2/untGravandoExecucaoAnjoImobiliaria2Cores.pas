unit untGravandoExecucaoAnjoImobiliaria2Cores;

interface

uses
  untAbstractGravandoExecucaoAnjoImobiliaria2, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  PostgreSQLUniProvider, StrUtils,System.Variants, Data.DB;

type
  TGravandoExecucaoAnjoImobiliaria2Cores = class(TAbstractGravandoExecucaoAnjoImobiliaria2)
  Private
    intCodSeq: Integer;
    function fRetUnidade(fltEmbalagem: Double): String;
    Procedure DeletarRegistros;
    function fRetFatorUnidade(fltEmbalagemPadrao: Double; fltEmbalagemNova: Double): Double;
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery; qryEmbalagens: TUniQuery; qryColorantes:  TUniQuery); Reintroduce;
    function GetSqlDestino(): String; Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils;

{ TGravandoExecucaoAnjoImobiliaria2Cores }


procedure TGravandoExecucaoAnjoImobiliaria2Cores.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM AN2_CADAN2  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoAnjoImobiliaria2Cores.Executar(const gravando: IGravando);
Var
  qryCores: TUniQuery;
  qryEmbalagems: TUniQuery;
  qryColorantes: TUniQuery;
  qryDestino: IDataSet;
  strSQL: String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando Dados do Cadastro de Cores...';
      qryCores := TUniQuery.Create(Nil);
      qryCores.Connection := fConexaoPostgreSQL;

      intCodSeq := 1;

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

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando registros da tabela AN2_CADAN2...';
      DeletarRegistros;
      Gravando.Texto := 'Registros excluidos com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('AN2_CADAN2');
      Gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Abrindo Cadastro de Cores...';
      qryDestino := GetDataSetDestino();

      While Not qryCores.Eof Do
      Begin
        If Not qryEmbalagems.Locate('id', qryCores.FieldByName('ID_EMB').AsString, []) Then
        Begin
          qryCores.Next;
          Continue;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        If Not IsRegistroExistente(qryDestino, qryCores) Then
          GravarRegistro(qryDestino, qryCores, qryEmbalagems, qryColorantes);

        qryCores.Next;
        Gravando.RegistrarProgresso(0, qryCores.RecNo, qryCores.RecordCount);
        Inc(intCodSeq);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryCores) Then
      FreeAndNil(qryCores);

    If Assigned(qryEmbalagems) Then
      FreeAndNil(qryEmbalagems);

    If Assigned(qryColorantes) Then
      FreeAndNil(qryColorantes);
  End;
end;


function TGravandoExecucaoAnjoImobiliaria2Cores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoAnjoImobiliaria2Cores.fRetFatorUnidade(
  fltEmbalagemPadrao, fltEmbalagemNova: Double): Double;
begin
  Result := fltEmbalagemNova / fltEmbalagemPadrao;
end;

function TGravandoExecucaoAnjoImobiliaria2Cores.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem <= 1500 Then
    Result := 'LT'
  Else If fltEmbalagem <= 8000 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoAnjoImobiliaria2Cores.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM AN2_CADAN2    ';
end;

procedure TGravandoExecucaoAnjoImobiliaria2Cores.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem, qryEmbalagens,
  qryColorantes: TUniQuery);
Var
  strMd5: String;
  iContador: Integer;
  fltEmbalagemNv,
  fltFator: Double;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AN2_CADAN2', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('AN2_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('AN2_CODIGO').AsString := qryOrigem.FieldByName('REFERE').AsString;
  qryDestino.FieldByName('AN2_NOMCOR').AsString := qryOrigem.FieldByName('NOMCOR').AsString;
  qryDestino.FieldByName('AN2_COLECA').AsString := qryOrigem.FieldByName('SUBCOLECAO').AsString;
  qryDestino.FieldByName('AN2_CODBAS').AsString := qryOrigem.FieldByName('DESCRICAOBASE').AsString;
  qryDestino.FieldByName('AN2_PRODUT').AsString := qryOrigem.FieldByName('DESCRICAOPRODUTO').AsString;
  qryDestino.FieldByName('AN2_UNIDAD').AsString := fRetUnidade(qryEmbalagens.FieldByName('conteudo').AsFloat);
  qryDestino.FieldByName('AN2_ATIVAD').AsString := 'S';

  strMd5 := '';
  strMd5 := strMd5 + qryDestino.FieldByName('AN2_CODIGO').AsString +
                     qryDestino.FieldByName('AN2_NOMCOR').AsString +
                     qryDestino.FieldByName('AN2_COLECA').AsString +
                     qryDestino.FieldByName('AN2_CODBAS').AsString +
                     qryDestino.FieldByName('AN2_PRODUT').AsString +
                     qryDestino.FieldByName('AN2_UNIDAD').AsString;


  fltEmbalagemNv := qryEmbalagens.FieldByName('conteudo').AsFloat;
  fltFator := fRetFatorUnidade(qryOrigem.FieldByName('EMBALAGEM').AsFloat, fltEmbalagemNv);

  For iContador := 1 To 6 Do
  Begin
    If TStrUtils.fEmptyStr(qryOrigem.FieldByName('COR' + TStrUtils.fStrZero(iContador, 2)).AsString) Then
      Break;

    If Not qryColorantes.Locate('id', qryOrigem.FieldByName('COR' + TStrUtils.fStrZero(iContador, 2)).AsString, []) Then
      Break;

    qryDestino.FieldByName('AN2_FORM' + TStrUtils.fStrZero(iContador, 2)).AsString := qryColorantes.FieldByName('codigo').AsString;
    qryDestino.FieldByName('AN2_QTDC' + TStrUtils.fStrZero(iContador, 2)).AsFloat := qryOrigem.FieldByName('QTD' + TStrUtils.fStrZero(iContador, 2)).AsFloat * fltFator;

    strMd5 := strMd5 + qryDestino.FieldByName('AN2_FORM' + TStrUtils.fStrZero(iContador, 2)).AsString;
    strMd5 := strMd5 + qryDestino.FieldByName('AN2_QTDC' + TStrUtils.fStrZero(iContador, 2)).AsString;
  End;

  qryDestino.FieldByName('AN2_MD5KEY').AsString := GetMd5(strMd5);
  qryDestino.Post;
end;

function TGravandoExecucaoAnjoImobiliaria2Cores.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := False;
end;


end.

