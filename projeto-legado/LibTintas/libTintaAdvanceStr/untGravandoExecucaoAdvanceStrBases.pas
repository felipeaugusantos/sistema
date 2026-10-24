{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta AdvanceStr *}
{*******************************************************************************AC*}
unit untGravandoExecucaoAdvanceStrBases;

interface

uses
  untAbstractGravandoExecucaoAdvanceStr, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, DBFUniProvider;

type
  TGravandoExecucaoAdvanceStrBases = class(TAbstractGravandoExecucaoAdvanceStr)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoAdvanceStrBases }

procedure TGravandoExecucaoAdvanceStrBases.Executar(const gravando: IGravando);
var
  qryBases: TUniQuery;
  qryCadBas: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    strSQL := '  SELECT                                   ' +
              '    pro.descricao_pt AS PRODUTO,           ' +
              '    co.tipo AS TIPBAS,                     ' +
              '    co.descricao AS DESCBASE,              ' +
              '    co.codigo AS CODBASE,                  ' +
              '    emb.capacidade_ml AS EMBBASE           ' +
              '  FROM                                     ' +
              '    componente as co                       ' +
              '  INNER JOIN produto AS pro ON             ' +
              '   pro.id = co.id_produto                  ' +
              '  INNER JOIN embalagem as emb ON           ' +
              '    pro.id_fabricante = emb.id_fabricante  ' +
              '  WHERE pro.liberado = true and            ' +
              '        emb.liberado = true and            ' +
              '         co.liberado = true                ' +
              '  ORDER BY pro.descricao_pt;               ';

    Gravando.Texto := 'Carregando dados do Cadastro de Bases...';
    qryBases := TUniQuery.Create(Nil);
    qryBases.Connection := fConexaoPostgreSQL;
    qryBases.Close;
    qryBases.SQL.Clear;
    qryBases.SQL.Add(strSQL);
    qryBases.Open;
    qryBases.First;

    If qryBases.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de bases está vazio. Verificar!';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Bases...';
    IsDeletarRegistros();
    Gravando.Texto := 'Cadastro de Bases deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('ADS_CADBAS');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Bases...';
    qryCadBas := GetDataSetDestino();

    If (Gravando.Status <> sgGravando) Then
    Exit;

    Try
      While Not qryBases.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExistente(qryCadBas, qryBases) Then
          GravarRegistro(qryCadBas, qryBases);

        qryBases.Next;
        Gravando.RegistrarProgresso(0, qryBases.RecNo, qryBases.RecordCount);
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

function TGravandoExecucaoAdvanceStrBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAdvanceStrBases.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATADS');
end;

function TGravandoExecucaoAdvanceStrBases.fRetUnidade(fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 1000 Then
    Result := 'QT'
  Else If fltEmbalagem < 5000 Then
    Result := 'GL'
  Else If fltEmbalagem < 18001 Then
    Result := 'LA'
  Else
    Result := 'BD'
end;

function TGravandoExecucaoAdvanceStrBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ADS_CADBAS';
end;

procedure TGravandoExecucaoAdvanceStrBases.GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADS_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('DESCBASE').AsString;
  qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('EMBBASE').AsFloat);
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := qryOrigem.FieldByName('EMBBASE').AsFloat;
  qryDestino.FieldByName('BAS_PRODUT').AsString := qryOrigem.FieldByName('PRODUTO').AsString;
  qryDestino.Post;
end;

procedure TGravandoExecucaoAdvanceStrBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ADS_CADBAS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAdvanceStrBases.IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([qryOrigem.FieldByName('DESCBASE').AsString,
    qryOrigem.FieldByName('PRODUTO').AsString, fRetUnidade(qryOrigem.FieldByName('EMBBASE').AsFloat)]), []);
end;


end.
