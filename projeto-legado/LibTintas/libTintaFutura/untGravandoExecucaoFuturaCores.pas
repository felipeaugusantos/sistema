{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Futura  *}
{**********************************************************************AC*}
unit untGravandoExecucaoFuturaCores;

interface

uses
  untAbstractGravandoExecucaoFutura, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, DBFUniProvider,
  Vcl.Graphics, Windows;

type
  TGravandoExecucaoFuturaCores = class(TAbstractGravandoExecucaoFutura)
  Private
    function fRetUnidade(strIdEmbalagem: String): String;
    function fRetFatorUnidade(fltEmbalagemPadrao: Double; fltEmbalagemNova: Double): Double;
    function fRGBToTColor(R, G, B: Byte): TColor;
    function fTColorToHex(AColor: TColor): String;
    function fPreencheRgbHexa(qryCor: IDataSet): Boolean;
  public
    function fGetPath(intContador: Integer): String; override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoFuturaCores }

procedure TGravandoExecucaoFuturaCores.Executar(const gravando: IGravando);
var
  qryCores: TUniQuery;
  qryCadCor: IDataSet;
  strSQL: String;
  intQuantidade: Integer;
  qryEmbalagems: TUniQuery;
  fltEmbalagemNv: Double;
  fltFator: Double;
  qryColorantes: TUniQuery;
  AColor: TColor;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

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
    qryCadCor.SQL := '    DELETE FROM FUT_CADFUT    ';
    qryCadCor.ExecSQL;
    qryCadCor.SQL.Empty;
    Gravando.Texto := 'Cadastro de Cores deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('FUT_CADFUT');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Cores...';
    qryCadCor.SQL := '      SELECT * FROM FUT_CADFUT    ';
    qryCadCor.Open;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryCores.First;

    Try
      While Not qryCores.Eof Do
      Begin
        qryCadCor.Insert;
        qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FUT_CADFUT', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadCor.FieldByName('FUT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadCor.FieldByName('FUT_CODBAS').AsString := qryCores.FieldByName('DESCRICAOBASE').AsString;
        qryCadCor.FieldByName('FUT_REFERE').AsString := qryCores.FieldByName('REFERE').AsString;
        qryCadCor.FieldByName('FUT_NOMCOR').AsString := qryCores.FieldByName('NOMCOR').AsString;
        qryCadCor.FieldByName('FUT_PRODUT').AsString := qryCores.FieldByName('DESCRICAOPRODUTO').AsString;
        qryCadCor.FieldByName('FUT_SPRODU').AsString := qryCores.FieldByName('SUBCOLECAO').AsString;
        qryCadCor.FieldByName('FUT_DESCRI').AsString := qryCadCor.FieldByName('FUT_PRODUT').AsString + ' ' + qryCadCor.FieldByName('FUT_CODBAS').AsString;
        qryCadCor.FieldByName('FUT_UNIDAD').AsString := fRetUnidade(qryCores.FieldByName('ID_EMB').AsString);
        qryCadCor.FieldByName('FUT_RED___').AsInteger := qryCores.FieldByName('RED').AsInteger;
        qryCadCor.FieldByName('FUT_GREEN_').AsInteger := qryCores.FieldByName('GREEN').AsInteger;
        qryCadCor.FieldByName('FUT_BLUE__').AsInteger := qryCores.FieldByName('BLUE').AsInteger;
        qryCadCor.FieldByName('FUT_FAMILI').AsString :=  qryCores.FieldByName('FAMILIACOR').AsString;
        qryCadCor.FieldByName('FUT_ATIVAD').AsString := 'S';
        qryCadCor.FieldByName('FUT_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('FUT_REFERE').AsString +
                                                               qryCadCor.FieldByName('FUT_CODBAS').AsString +
                                                               qryCadCor.FieldByName('FUT_NOMCOR').AsString +
                                                               qryCadCor.FieldByName('FUT_PRODUT').AsString +
                                                               qryCadCor.FieldByName('FUT_UNIDAD').AsString);

        If fPreencheRgbHexa(qryCadCor) Then
        Begin
          AColor := fRGBToTColor(qryCores.FieldByName('RED').AsInteger, qryCores.FieldByName('GREEN').AsInteger, qryCores.FieldByName('BLUE').AsInteger);

          qryCadCor.FieldByName('FUT_R_G_B_').AsString := fTColorToHex(AColor);
        End;

        If Not qryEmbalagems.Locate('id', qryCores.FieldByName('ID_EMB').AsString, []) Then
          Exit;

        fltEmbalagemNv := qryEmbalagems.FieldByName('conteudo').AsFloat;
        fltFator := fRetFatorUnidade(qryCores.FieldByName('EMBALAGEM').AsFloat, fltEmbalagemNv);

        For intQuantidade := 1 To 6 Do
        Begin
          If TStrUtils.fEmptyStr(qryCores.FieldByName('COR' + TStrUtils.fStrZero(intQuantidade, 2)).AsString) Then
            Break;

          If Not qryColorantes.Locate('id', qryCores.FieldByName('COR' + TStrUtils.fStrZero(intQuantidade, 2)).AsString, []) Then
            Break;

          qryCadCor.FieldByName('FUT_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := qryColorantes.FieldByName('descricao').AsString;
          qryCadCor.FieldByName('FUT_QTDB' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat := qryCores.FieldByName('QTD' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat * fltFator;
        End;

        qryCadCor.Post;

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
    FreeAndNil(qryCores);
    FreeAndNil(qryEmbalagems);
    FreeAndNil(qryColorantes);
  End;
end;

function TGravandoExecucaoFuturaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoFuturaCores.fGetPath(intContador: Integer): String;
begin
  Result := conf.fGet('PATFUT');
end;


function TGravandoExecucaoFuturaCores.fPreencheRgbHexa(
  qryCor: IDataSet): Boolean;
begin
  Result := True;

  If qryCor.FieldByName('FUT_RED___').AsInteger = 0 Then
  Begin
    Result := False;

    If qryCor.FieldByName('FUT_GREEN_').AsInteger <> 0 Then
      Exit(True);

    If qryCor.FieldByName('FUT_BLUE__').AsInteger <> 0 Then
      Exit(True);
  End
  Else If qryCor.FieldByName('FUT_GREEN_').AsInteger = 0 Then
  Begin
    Result := False;

    If qryCor.FieldByName('FUT_RED___').AsInteger <> 0 Then
      Exit(True);

    If qryCor.FieldByName('FUT_BLUE__').AsInteger <> 0 Then
      Exit(True);
  End
  Else If qryCor.FieldByName('FUT_BLUE__').AsInteger = 0 Then
  Begin
    Result := False;

    If qryCor.FieldByName('FUT_RED___').AsInteger <> 0 Then
      Exit(True);

    If qryCor.FieldByName('FUT_GREEN_').AsInteger <> 0 Then
      Exit(True);
  End;
end;

function TGravandoExecucaoFuturaCores.fRetFatorUnidade(fltEmbalagemPadrao,
  fltEmbalagemNova: Double): Double;
begin
  Result := fltEmbalagemNova / fltEmbalagemPadrao;
end;

function TGravandoExecucaoFuturaCores.fRetUnidade(strIdEmbalagem: String): String;
begin
  Result := 'LT';

  If Pos(strIdEmbalagem, '3_9_') > 0 Then
    Result := 'GL'
  Else If Pos(strIdEmbalagem, '4_') > 0 Then
    Result := 'LA';
end;

function TGravandoExecucaoFuturaCores.fRGBToTColor(R, G, B: Byte): TColor;
begin
  Result := RGB(R, G, B);
end;

function TGravandoExecucaoFuturaCores.fTColorToHex(AColor: TColor): String;
var
  R, G, B: Byte;
begin
  R := GetRValue(AColor);
  G := GetGValue(AColor);
  B := GetBValue(AColor);

  Result := IntToHex(R, 2) + IntToHex(G, 2) + IntToHex(B, 2);
end;

end.
