{******************************************************************************}
{* Classe responsável pela geração do cadastro de Cores da tinta Killing *}
{***************************************************************************PH*}
unit untGravandoExecucaoKillingCores;

interface

uses
  untAbstractGravandoExecucaoKilling, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,Data.DB, Variants,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Windows,
  Vcl.Forms, Vcl.Graphics, UniClientDataSet;
type
  TGravandoExecucaoKillingCores = class(TAbstractGravandoExecucaoKilling)
  Private
    //Alteração MD5KEY
    FNameConsKey: String;
    FNameColumn: String;
    FNameBanco: String;
    FNameTable: String;
    function fRetRetConstraintUniqueKey(): String;
    Procedure pRemoveAddUniqueKey(blnRemover: Boolean);
    procedure DeletarMd5KeyDuplicado(Gravando :IGravando);
    Procedure DeletarRegistros;
    function fRetUnidade(ADesEmb: String): String;
    function fRetFatorUnidade(fltEmbalagemPadrao: Double; fltEmbalagemNova: Double): Double;
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery; qryEmbalagens: TUniQuery; qryColorantes:  TUniQuery); Reintroduce;
    function GetSqlDestino(): String; Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

Uses untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoKillingCores }

procedure TGravandoExecucaoKillingCores.DeletarMd5KeyDuplicado(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD,    ' +
                '        KIL_MD5KEY          ' +
                '   FROM KILD_CADKIL         ' +
                '  GROUP BY KIL_MD5KEY       ' +
                ' HAVING COUNT(*) > 1        ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados KILD_CADKIL...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE                   ' +
                    '   FROM KILD_CADKIL       ' +
                    '  WHERE KIL_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('KIL_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;
  End;
end;

procedure TGravandoExecucaoKillingCores.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM KILD_CADKIL  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoKillingCores.Executar(const gravando: IGravando);
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

      strSQL := '';
      strSQL := strSQL + '  SELECT       ';
      strSQL := strSQL + '    base.codigo AS CODIGOBASE,    ';
      strSQL := strSQL + '    produto.codigo AS CODFML,     ';
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
      strSQL := strSQL + '    padraocor.codigo as CODCOR,     ';
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

      FNameConsKey := fRetRetConstraintUniqueKey;
      Gravando.Texto := 'Removendo UNIQUE KEY...';
      pRemoveAddUniqueKey(True);
      Gravando.Texto := 'UNIQUE KEY removida...';

      Gravando.Texto := 'Deletando registros da tabela KILD_CADKIL...';
      DeletarRegistros;
      Gravando.Texto := 'Registros excluidos com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KILD_CADKIL');
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

    DeletarMd5KeyDuplicado(Gravando);
    Gravando.Texto := 'Adicionando UNIQUE KEY...';
    pRemoveAddUniqueKey(False);
  End;
end;

function TGravandoExecucaoKillingCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoKillingCores.fRetFatorUnidade(fltEmbalagemPadrao,
  fltEmbalagemNova: Double): Double;
begin
  Result := fltEmbalagemNova / fltEmbalagemPadrao;
end;

function TGravandoExecucaoKillingCores.fRetRetConstraintUniqueKey: String;
Var
  FQuery: TUniQuery;
  FSQL: String;
begin
  Try
    Try
      FQuery := TAutcomTintaFactory.Get.fCriaQuery();
      FNameColumn := 'KIL_MD5KEY';
      FNameTable := 'KILD_CADKIL';
      FNameBanco := FQuery.Connection.Database;

      FSQL := '';
      FSQL := FSQL + ' SELECT  TABLE_NAME,      ' +
                     '         COLUMN_NAME,     ' +
                     '         CONSTRAINT_NAME  ' +
                     ' FROM                     ' +
                     '  INFORMATION_SCHEMA.KEY_COLUMN_USAGE   ' +
                     ' WHERE CONSTRAINT_SCHEMA = :CONSCH AND  ' +
                     '       TABLE_NAME = :TABNAM AND         ' +
                     '       COLUMN_NAME = :COLNAM            ' ;

      FQuery.Close;
      FQuery.SQL.Clear;
      FQuery.SQL.Add(FSQL);
      FQuery.ParamByName('CONSCH').AsString := FNameBanco;
      FQuery.ParamByName('TABNAM').AsString := FNameTable;
      FQuery.ParamByName('COLNAM').AsString := FNameColumn;
      FQuery.Open;

      Result := FQuery.FieldByName('CONSTRAINT_NAME').AsString;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    If Assigned(FQuery) Then
      FreeAndNil(FQuery);
  End;
end;

function TGravandoExecucaoKillingCores.fRetUnidade(ADesEmb: String): String;
begin
  Result := Trim(Copy(ADesEmb, 1, 3));
end;

function TGravandoExecucaoKillingCores.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM KILD_CADKIL    ';
end;

procedure TGravandoExecucaoKillingCores.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem, qryEmbalagens,
  qryColorantes: TUniQuery);
Var
  strMd5Key: String;
  iContador: Integer;
  fltEmbalagemNv,
  fltFator: Double;
  fltQuantidade: Double;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KILD_CADKIL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('KIL_CODCOR').AsString := qryOrigem.FieldByName('CODCOR').AsString;
  qryDestino.FieldByName('KIL_NOMCOR').AsString := qryOrigem.FieldByName('NOMCOR').AsString;
  qryDestino.FieldByName('KIL_DESCRI').AsString := qryOrigem.FieldByName('DESCRICAOPRODUTO').AsString;
  qryDestino.FieldByName('KIL_REFERE').AsString := qryOrigem.FieldByName('SUBCOLECAO').AsString;
  qryDestino.FieldByName('KIL_CODFML').AsString := qryOrigem.FieldByName('CODFML').AsString;
  qryDestino.FieldByName('KIL_CODBAS').AsString := qryOrigem.FieldByName('CODIGOBASE').AsString;
  qryDestino.FieldByName('KIL_CODUNI').AsString := fRetUnidade(qryEmbalagens.FieldByName('descricao').AsString);
  qryDestino.FieldByName('KIL_ATIVAD').AsString := 'S';

  strMd5Key := '';
  strMd5Key := strMd5Key + qryDestino.FieldByName('KIL_CODCOR').AsString + qryDestino.FieldByName('KIL_NOMCOR').AsString +
                           qryDestino.FieldByName('KIL_DESCRI').AsString + qryDestino.FieldByName('KIL_REFERE').AsString +
                           qryDestino.FieldByName('KIL_CODFML').AsString + qryDestino.FieldByName('KIL_CODBAS').AsString +
                           qryDestino.FieldByName('KIL_CODUNI').AsString;

  fltEmbalagemNv := qryEmbalagens.FieldByName('conteudo').AsFloat;
  fltFator := fRetFatorUnidade(qryOrigem.FieldByName('EMBALAGEM').AsFloat, fltEmbalagemNv);

  For iContador := 1 To 6 Do
  Begin
    If TStrUtils.fEmptyStr(qryOrigem.FieldByName('COR' + TStrUtils.fStrZero(iContador, 2)).AsString) Then
      Break;

    If Not qryColorantes.Locate('id', qryOrigem.FieldByName('COR' + TStrUtils.fStrZero(iContador, 2)).AsString, []) Then
      Break;

    fltQuantidade :=  qryOrigem.FieldByName('QTD' + TStrUtils.fStrZero(iContador, 2)).AsFloat / (29.5735 / 48); //SHOT MANUAL

    qryDestino.FieldByName('KIL_FORM' + TStrUtils.fStrZero(iContador, 2)).AsString := qryColorantes.FieldByName('codigo').AsString;
    qryDestino.FieldByName('KIL_QTDB' + TStrUtils.fStrZero(iContador, 2)).AsFloat := fltQuantidade * fltFator;

    strMd5Key := strMd5Key + qryDestino.FieldByName('KIL_FORM' + TStrUtils.fStrZero(iContador, 2)).AsString;
    strMd5Key := strMd5Key + qryDestino.FieldByName('KIL_QTDB' + TStrUtils.fStrZero(iContador, 2)).AsString;
  End;

  qryDestino.FieldByName('KIL_MD5KEY').AsString := GetMD5(strMd5Key);
  qryDestino.Post;
end;

function TGravandoExecucaoKillingCores.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoKillingCores.pRemoveAddUniqueKey(
  blnRemover: Boolean);
Var
  FQuery: IDataSet;
begin
  FQuery := TAutcomTintaFactory.Get.fGetDataSet;

  If BlnRemover Then
    FQuery.SQL := ' ALTER TABLE ' + FNameTable + ' DROP INDEX ' + FNameConsKey
  Else
    FQuery.SQL := ' ALTER TABLE ' + FNameTable + ' ADD CONSTRAINT ' + FNameConsKey + ' UNIQUE (' + FNameColumn + ')';
  FQuery.ExecSQL;
end;

end.


