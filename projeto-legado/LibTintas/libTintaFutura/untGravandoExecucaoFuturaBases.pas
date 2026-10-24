{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Futura           *}
{*******************************************************************************AC*}
unit untGravandoExecucaoFuturaBases;

interface

uses
  untAbstractGravandoExecucaoFutura, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, DBFUniProvider;

type
  TGravandoExecucaoFuturaBases = class(TAbstractGravandoExecucaoFutura)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
  public
    function fGetPath(intContador: Integer): String; override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoFuturaBases }

procedure TGravandoExecucaoFuturaBases.Executar(const gravando: IGravando);
var
  qryBases: TUniQuery;
  qryCadBas: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.Texto := 'Carregando Dados do Cadastro de Colorantes...';
    qryBases := TUniQuery.Create(Nil);
    qryBases.Connection := fConexaoPostgreSQL;

    strSQL := '';
    strSQL := strSQL + '  SELECT       ';
    strSQL := strSQL + '    base.descricao as DESCBASE,     ';
    strSQL := strSQL + '    produto.descricao as DESCPRODUTO,     ';
    strSQL := strSQL + '    embalagem.conteudo AS EMBALAGEM   ';
    strSQL := strSQL + '  FROM         ';
    strSQL := strSQL + '    produto_base_embalagem AS basemb    ';
    strSQL := strSQL + '  INNER JOIN embalagem ON     ';
    strSQL := strSQL + '    basemb.id_embalagem = embalagem.id  ';
    strSQL := strSQL + '  INNER JOIN base ON      ';
    strSQL := strSQL + '    basemb.id_base = base.id    ';
    strSQL := strSQL + '  INNER JOIN produto ON       ';
    strSQL := strSQL + '    basemb.id_produto = produto.id;   ';

    qryBases.Close;
    qryBases.SQL.Clear;
    qryBases.SQL.Add(strSQL);
    qryBases.Open;

    If qryBases.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de base está vazio! Verificar.';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Bases...';
    qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
    qryCadBas.SQL := '    DELETE FROM FUT_CADBAS    ';
    qryCadBas.ExecSQL;
    qryCadBas.SQL.Empty;
    Gravando.Texto := 'Cadastro de Bases deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('FUT_CADBAS');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Bases...';
    qryCadBas.SQL := '      SELECT * FROM FUT_CADBAS    ';
    qryCadBas.Open;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryBases.First;

    Try
      While Not qryBases.Eof Do
      Begin
        If Not qryCadBas.Locate('BAS_CODFML;BAS_CODBAS;BAS_PRODUT;BAS_CODUNI', VarArrayOf([
          qryBases.FieldByName('DESCBASE').AsString, qryBases.FieldByName('DESCBASE').AsString,
          qryBases.FieldByName('DESCPRODUTO').AsString, fRetUnidade(qryBases.FieldByName('EMBALAGEM').AsFloat)]), []) Then
        Begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FUT_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_CODFML').AsString := qryBases.FieldByName('DESCBASE').AsString;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := qryBases.FieldByName('DESCBASE').AsString;
          qryCadBas.FieldByName('BAS_DESCRI').AsString := qryBases.FieldByName('DESCBASE').AsString;
          qryCadBas.FieldByName('BAS_PRODUT').AsString := qryBases.FieldByName('DESCPRODUTO').AsString;
          qryCadBas.FieldByName('BAS_CODUNI').AsString := fRetUnidade(qryBases.FieldByName('EMBALAGEM').AsFloat);
          qryCadBas.Post;
        End;

        qryBases.Next;
        gravando.RegistrarProgresso(0, qryBases.RecNo, qryBases.RecordCount);
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

function TGravandoExecucaoFuturaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoFuturaBases.fGetPath(intContador: Integer): String;
begin
  Result := Conf.fGet('PATFUT');
end;

function TGravandoExecucaoFuturaBases.fRetUnidade(fltEmbalagem: Double): String;
begin
  Result := '';

  If fltEmbalagem < 1500 Then
    Result := 'LT'
  Else If fltEmbalagem < 5000 Then
    Result := 'GL'
  Else If fltEmbalagem > 5000 Then
    Result := 'LA';
end;

{ procedure TGravandoExecucaoFuturaBases.GravarRegistro(const qryOrigem: TDataSet;
  const qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FUT_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODFML').AsString := LimpaTexto(qryOrigem.FieldByName('base').AsString);
  qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(qryOrigem.FieldByName('base').AsString);
  qryDestino.FieldByName('BAS_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('base').AsString);
  qryDestino.FieldByName('BAS_CODUNI').AsString := LimpaTexto(fRetUnidade(qryOrigem.FieldByName('embalagem').AsFloat));
  qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('produto').AsString);
  qryDestino.Post;
end;

function TGravandoExecucaoFuturaBases.IsRegistroExistente(
  const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODFML;BAS_CODBAS;BAS_PRODUT;BAS_CODUNI', VarArrayOf([LimpaTexto(qryOrigem.FieldByName('base').AsString),
    LimpaTexto(qryOrigem.FieldByName('base').AsString), LimpaTexto(qryOrigem.FieldByName('produto').AsString),
    LimpaTexto(fRetUnidade(qryOrigem.FieldByName('embalagem').AsFloat))]),  []);
end;   }

end.
