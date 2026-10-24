{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta CoralImobiliaria *}
{**********************************************************************PH*}
unit untGravandoExecucaoCoralImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoCoralImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, System.Classes, Uni, PostgreSQLUniProvider, Vcl.Graphics, Windows;

type
  TGravandoExecucaoCoralImobiliariaCores = class(TAbstractGravandoExecucaoCoralImobiliaria)
  Private
    qryColorantes: TUniQuery;
    qryColecoes: TUniQuery;
    strDescri    : String;
    intCodSeq    : Integer;
    function fRetUnidade(fltEmbalagem: Double): String;
    function CorParaHx(AColor: TColor): String;
    function CorParaRGB(AColor: TColor; strSigla: String): String;
    procedure IsDeletarRegistros();
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); Override;
    function GetSqlDestino(): String; Override;
  Public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoCoralImobiliariaCores }

function TGravandoExecucaoCoralImobiliariaCores.CorParaHx(AColor: TColor): String;
Var
  R, G, B: Byte;
begin
  R := GetRValue(AColor);
  G := GetGValue(AColor);
  B := GetBValue(AColor);

  Result := IntToHex(R, 2) + IntToHex(G, 2) + IntToHex(B, 2);
end;

function TGravandoExecucaoCoralImobiliariaCores.CorParaRGB(AColor: TColor; strSigla: String): String;
Var
  LValue: LongInt;
  R, G, B: Byte;
begin
  Result := '';

  LValue := colorToRGB(AColor);
  R := LValue;
  G := LValue shr 8;
  B := LValue shr 16;

  If strSigla = 'R' Then
    Result := IntToStr(R)
  Else If strSigla = 'G' Then
    Result := IntToStr(G)
  Else If strSigla = 'B' Then
    Result := IntToStr(B);
end;

procedure TGravandoExecucaoCoralImobiliariaCores.Executar(const gravando: IGravando);
var
  qryCores: TUniQuery;
  qryCadCor: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    strSQL := '  SELECT                                                          ' +
              '    CP.cor_id AS COLORID,                                         ' +
              '    CP.cor2_id AS NOTATION,                                       ' +
              '    B.codigo AS BASE,                                             ' +
              '    EMBPAD.nominal AS EMB_PADRAO,                                 ' +
              '    PROEMB.nominal AS PROX_EMBAL,                                 ' +
              '    L.descr AS PRODUCT,                                           ' +
              '    P.formula AS FORMULA,                                         ' +
              '    CP.familia AS FAMILIA,                                        ' +
              '    CP.cor1 AS COLOR,                                             ' +
              '    CP.nome_cor AS COLID2,                                        ' +
              '    PB.id_prodbase AS IDEMB,                                      ' +
              '    P.obs as OBSERV                                               ' +
              '  FROM                                                            ' +
              '    frmpadrao AS P                                                ' +
              '  INNER JOIN corespadrao AS CP ON                                 ' +
              '    CP.cor_id = P.cor_id                                          ' +
              '  INNER JOIN produtobase AS PB ON                                 ' +
              '    PB.id_base = P.id_base AND                                    ' +
              '    PB.id_linha = P.id_linha                                      ' +
              '  INNER JOIN bases AS B ON                                        ' +
              '    B.id_base = PB.id_base                                        ' +
              '  INNER JOIN linha AS L ON                                        ' +
              '    L.id_linha = PB.id_linha                                      ' +
              '  INNER JOIN embalagens AS EMBPAD ON                              ' +
              '    P.id_emb = EMBPAD.id_emb                                      ' +
              '  INNER JOIN embalagens AS PROEMB ON                              ' +
              '    PB.id_emb = PROEMB.id_emb                                     ' +
              '  ORDER BY CP.cor_id, B.codigo, L.descr, PROEMB.nominal;          ';


    Gravando.Texto := 'Carregando dados do Cadastro de Cores...';
    qryCores := TUniQuery.Create(Nil);
    qryCores.Connection := fConexaoPostgreSQL;
    qryCores.Close;
    qryCores.SQL.Clear;
    qryCores.SQL.Add(strSQL);
    qryCores.Open;
    qryCores.First;

    If qryCores.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de Cores está vazio. Verificar!';
      Exit;
    End;

    qryColorantes := TUniQuery.Create(Nil);
    qryColorantes.Connection := fConexaoPostgreSQL;
    qryColorantes.Close;
    qryColorantes.SQL.Clear;
    qryColorantes.SQL.Add('SELECT * FROM corantes');
    qryColorantes.Open;

    strSQL := ' SELECT           ' +
              '   COL.descricao AS COLECAO,  ' +
              '   CC.cor_id AS CORID         ' +
              ' FROM             ' +
              ' corcolecao AS CC ' +
              'INNER JOIN tabformulas AS COL ON  ' +
		          ' COL.id_tabformulas = CC.id_colecao ';

    qryColecoes := TUniQuery.Create(Nil);
    qryColecoes.Connection := fConexaoPostgreSQL;
    qryColecoes.Close;
    qryColecoes.SQL.Clear;
    qryColecoes.SQL.Add(strSQL);
    qryColecoes.Open;


    Gravando.Texto := 'Deletando Cadastro de Cores...';
    IsDeletarRegistros();
    Gravando.Texto := 'Cadastro de Cores deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('CORIMO_CADCOR');
    Gravando.Texto := 'PROCOD verificado com sucesso!';

    Gravando.Texto := 'Abrindo Cadastro de Cores...';
    qryCadCor := GetDataSetDestino();

    strDescri := fGetParteDescricao();
    intCodSeq := 1;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Try
      While Not qryCores.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExistente(qryCadCor, qryCores) Then
          GravarRegistro(qryCadCor, qryCores);

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

    If Assigned(qryColorantes) Then
      FreeAndNil(qryColorantes);

    If Assigned(qryColecoes) Then
      FreeAndNil(qryColecoes);
  End;
end;

function TGravandoExecucaoCoralImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoCoralImobiliariaCores.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  Result := 'LT';

  If fltEmbalagem < 1500 Then
    Result := 'LT'
  Else If fltEmbalagem < 8500 Then
    Result := 'GL'
  Else If fltEmbalagem < 20000 Then
    Result := 'LA';
end;

function TGravandoExecucaoCoralImobiliariaCores.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM CORIMO_CADCOR     ';
end;

procedure TGravandoExecucaoCoralImobiliariaCores.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
Var
  strFormula: String;
  intContador: Integer;
  intPos: Integer;
  Color: TColor;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CORIMO_CADCOR', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COR_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
  qryDestino.FieldByName('COR_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;



  If TStrUtils.fEmptyStr(strDescri) Then
    qryDestino.FieldByName('COR_DESCRI').AsString := Trim(qryOrigem.FieldByName('NOTATION').AsString + ' ' + qryOrigem.FieldByName('PRODUCT').AsString + ' ' + qryOrigem.FieldByName('BASE').AsString)
  Else
    qryDestino.FieldByName('COR_DESCRI').AsString := '[' + strDescri + '] ' + Trim(qryOrigem.FieldByName('NOTATION').AsString + ' ' + qryOrigem.FieldByName('PRODUCT').AsString + ' ' + qryOrigem.FieldByName('BASE').AsString);

  qryDestino.FieldByName('COR_CODIGO').AsString := qryOrigem.FieldByName('COLORID').AsString;
  qryDestino.FieldByName('COR_COLID1').AsString := qryOrigem.FieldByName('COLORID').AsString;
  qryDestino.FieldByName('COR_COLID2').AsString := qryOrigem.FieldByName('COLID2').AsString;
  qryDestino.FieldByName('COR_DESPRO').AsString := qryOrigem.FieldByName('PRODUCT').AsString;
  qryDestino.FieldByName('COR_CODBAS').AsString := qryOrigem.FieldByName('BASE').AsString;
  qryDestino.FieldByName('COR_CODEMB').AsString := qryOrigem.FieldByName('PROX_EMBAL').AsString;
  qryDestino.FieldByName('COR_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('PROX_EMBAL').AsFloat);
  qryDestino.FieldByName('COR_CODUNI').AsString := fRetUnidade(qryOrigem.FieldByName('PROX_EMBAL').AsFloat);
  qryDestino.FieldByName('COR_UNIVER').AsString := qryOrigem.FieldByName('NOTATION').AsString;
  qryDestino.FieldByName('COR_ID_EMB').AsString := qryOrigem.FieldByName('IDEMB').AsString;
  qryDestino.FieldByName('COR_OBSERV').AsString := qryOrigem.FieldByName('OBSERV').AsString;
  qryDestino.FieldByName('COR_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('COR_DESCRI').AsString +
                                                          qryDestino.FieldByName('COR_CODIGO').AsString +
                                                          qryDestino.FieldByName('COR_UNIDAD').AsString +
                                                          qryDestino.FieldByName('COR_COLID1').AsString +
                                                          qryDestino.FieldByName('COR_COLID2').AsString +
                                                          qryDestino.FieldByName('COR_DESPRO').AsString +
                                                          qryDestino.FieldByName('COR_CODBAS').AsString +
                                                          qryDestino.FieldByName('COR_CODEMB').AsString +
                                                          qryDestino.FieldByName('COR_CODUNI').AsString +
                                                          qryDestino.FieldByName('COR_UNIVER').AsString);

  If Not (TStrUtils.fEmptyStr(qryOrigem.FieldByName('COLOR').AsString)) And
    (qryOrigem.FieldByName('COLOR').AsString <> '0') Then
  Begin
    Color := StringToColor(qryOrigem.FieldByName('COLOR').AsString);
    qryDestino.FieldByName('COR_R_G_B_').AsString := CorParaHx(Color);
    qryDestino.FieldByName('COR_RED___').AsString := CorParaRGB(Color, 'R');
    qryDestino.FieldByName('COR_GREEN_').AsString := CorParaRGB(Color, 'G');
    qryDestino.FieldByName('COR_BLUE__').AsString := CorParaRGB(Color, 'B');
  End;

  If Not qryColecoes.Locate('CORID', qryOrigem.FieldByName('COLORID').AsString, []) Then
    qryDestino.FieldByName('COR_COLECA').AsString := ''
  Else
    qryDestino.FieldByName('COR_COLECA').AsString := qryColecoes.FieldByName('COLECAO').AsString;

  qryDestino.FieldByName('COR_TONALI').AsString := qryOrigem.FieldByName('FAMILIA').AsString;

  strFormula := qryOrigem.FieldByName('FORMULA').AsString;
  intContador := 1;

  While Not TStrUtils.fEmptyStr(strFormula) Do
  Begin
    intPos := Pos(',', strFormula);

    If Not qryColorantes.Locate('id_corante', Copy(strFormula, 1, intPos - 1), []) Then
      Break;

    qryDestino.FieldByName('COR_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := qryColorantes.FieldByName('codigo').AsString;

    strFormula := Copy(strFormula, intPos + 1 , Length(strFormula));
    intPos := Pos(',', strFormula);

    If intPos <= 0 Then
      intPos := Length(strFormula) + 1;

    qryDestino.FieldByName('COR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=  TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ',')) *
      (qryOrigem.FieldByName('PROX_EMBAL').AsFloat / qryOrigem.FieldByName('EMB_PADRAO').AsFloat);

    strFormula := Copy(strFormula, intPos + 1, Length(strFormula));

    Inc(intContador);
  End;

  qryDestino.Post;
  Inc(intCodSeq);
end;

procedure TGravandoExecucaoCoralImobiliariaCores.IsDeletarRegistros;
begin
  TAutcomTintaFactory.Get.TruncateTable('CORIMO_CADCOR');
end;

function TGravandoExecucaoCoralImobiliariaCores.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := False;
end;

end.

