{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Ciacollor *}
{**********************************************************************PH*}
unit untGravandoExecucaoCiacollorBases;

interface

uses
  untAbstractGravandoExecucaoCiacollor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, SQLiteUniProvider;

type
  TGravandoExecucaoCiacollorBases = class(TAbstractGravandoExecucaoCiacollor)
  Private
    function fRetTotalRegistros(): Integer;
    function fRetUnidade(fltEmbalagem: Double): String;
    function fRetEmbalagem(fltEmbalagem: Double): Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
  end;

implementation

uses untStrUtils;


{ TGravandoExecucaoCiacollorBases }

procedure TGravandoExecucaoCiacollorBases.Executar(const gravando: IGravando);
Var
  qryBases: TUniQuery;
  qryDestino: IDataSet;
  strSQL: String;
  intRegistros: Integer;
begin
  Try
    qryBases := TUniQuery.Create(Nil);
    qryBases.Connection := fConexaoSQLiteStudio();

    strSQL := '';
    strSQL := strSQL + '  SELECT        ';
    strSQL := strSQL + '  	B.NOME AS BASE,   ';
    strSQL := strSQL + '  	P.NOME AS PRODUTO,    ';
    strSQL := strSQL + '  	E.CAPACIDADE AS EMBALAGEM   ';
    strSQL := strSQL + '  FROM          ';
    strSQL := strSQL + '  	PRODUTO_BASE AS PB    ';
    strSQL := strSQL + '  INNER JOIN BASE AS B ON       ';
    strSQL := strSQL + '  	PB.BASE_ID = B.ID     ';
    strSQL := strSQL + '  INNER JOIN PRODUTO AS P ON    ';
    strSQL := strSQL + '  	PB.PRODUTO_ID = P.ID  ';
    strSQL := strSQL + '  INNER JOIN PRODUTO_EMBALAGEM AS PE ON   ';
    strSQL := strSQL + '  	PB.PRODUTO_ID = PE.PRODUTO_ID   ';
    strSQL := strSQL + '  INNER JOIN EMBALAGEM AS E ON  ';
    strSQL := strSQL + '  	PE.EMBALAGEM_ID = E.ID    ';
    strSQL := strSQL + '  WHERE P.ATIVO <> "N"    ';

    qryBases.Close;
    qryBases.SQL.Clear;
    qryBases.SQL.Add(strSQL);
    qryBases.Open;

    If qryBases.IsEmpty Then
    Begin
      Gravando.Texto := 'Cadastro de bases vazio! Verificar.';
      Exit;
    End;

    intRegistros := fRetTotalRegistros();

    Gravando.Texto := 'Deletando registros da tabela CIA_CADBAS...';
    qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
    qryDestino.Close;
    qryDestino.SQL := ' DELETE FROM CIA_CADBAS  ';
    qryDestino.ExecSQL;
    Gravando.Texto := 'Registros deletados com sucesso...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('CIA_CADBAS');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo cadastro de bases...';
    qryDestino.SQL := ' SELECT * FROM CIA_CADBAS    ';
    qryDestino.Open;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryBases.First;

    Try
      While Not qryBases.Eof Do
      Begin
        If Not qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_CODUNI;BAS_VOLUME', VarArrayOf([
          qryBases.FieldByName('BASE').AsString ,qryBases.FieldByName('PRODUTO').AsString,
          fRetUnidade(qryBases.FieldByName('EMBALAGEM').AsFloat), fRetEmbalagem(qryBases.FieldByName('EMBALAGEM').AsFloat)]), []) Then
        Begin
          qryDestino.Insert;
          qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CIA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryDestino.FieldByName('BAS_CODBAS').AsString := qryBases.FieldByName('BASE').AsString;
          qryDestino.FieldByName('BAS_PRODUT').AsString := qryBases.FieldByName('PRODUTO').AsString;
          qryDestino.FieldByName('BAS_DESCRI').AsString := qryBases.FieldByName('PRODUTO').AsString;
          qryDestino.FieldByName('BAS_VOLUME').AsFloat  := fRetEmbalagem(qryBases.FieldByName('EMBALAGEM').AsFloat);
          qryDestino.FieldByName('BAS_CODUNI').AsString := fRetUnidade(qryBases.FieldByName('EMBALAGEM').AsFloat);
          qryDestino.Post;
        End;

        qryBases.Next;
        Gravando.RegistrarProgresso(0, qryBases.RecNo, intRegistros);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryBases) Then
      FreeAndNil(qryBases);
  End;
end;

function TGravandoExecucaoCiacollorBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoCiacollorBases.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATCIA');
end;

function TGravandoExecucaoCiacollorBases.fRetEmbalagem(
  fltEmbalagem: Double): Double;
begin
  Result := fltEmbalagem * 1000;
end;

function TGravandoExecucaoCiacollorBases.fRetTotalRegistros: Integer;
Var
  qryTotalRegistros: TUniQuery;
  strSQL: String;
begin
  Try
    qryTotalRegistros := TUniQuery.Create(Nil);
    qryTotalRegistros.Connection := fConexaoSQLiteStudio();

    strSQL := strSQL + '  SELECT COUNT(*) AS QTD_REGISTROS    ';
    strSQL := strSQL + '  FROM          ';
    strSQL := strSQL + '  	PRODUTO_BASE AS PB    ';
    strSQL := strSQL + '  INNER JOIN BASE AS B ON       ';
    strSQL := strSQL + '  	PB.BASE_ID = B.ID     ';
    strSQL := strSQL + '  INNER JOIN PRODUTO AS P ON    ';
    strSQL := strSQL + '  	PB.PRODUTO_ID = P.ID  ';
    strSQL := strSQL + '  INNER JOIN PRODUTO_EMBALAGEM AS PE ON   ';
    strSQL := strSQL + '  	PB.PRODUTO_ID = PE.PRODUTO_ID   ';
    strSQL := strSQL + '  INNER JOIN EMBALAGEM AS E ON  ';
    strSQL := strSQL + '  	PE.EMBALAGEM_ID = E.ID    ';
    strSQL := strSQL + '  WHERE P.ATIVO <> "N"  ';

    qryTotalRegistros.Close;
    qryTotalRegistros.SQL.Clear;
    qryTotalRegistros.SQL.Add(strSQL);
    qryTotalRegistros.Open;

    Result := qryTotalRegistros.FieldByName('QTD_REGISTROS').AsInteger;
  Finally
    FreeAndNil(qryTotalRegistros);
  End;
end;

function TGravandoExecucaoCiacollorBases.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 2 Then
    Result := 'LT'
  Else If fltEmbalagem < 8 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

end.
