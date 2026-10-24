{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta MazaImobiliaria *}
{***************************************************************************PH*}
unit untGravandoExecucaoMazaImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoMazaImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, DBFUniProvider;

Type
  TGravandoExecucaoMazaImobiliariaBases = class(TAbstractGravandoExecucaoMazaImobiliaria)
  private
    function fRetUnidade(fltEmbalagem: Double): String;
  public
    function fGetPath(intContador: Integer): String; override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

implementation

Uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoMazaImobiliariaCores }

procedure TGravandoExecucaoMazaImobiliariaBases.Executar(const gravando: IGravando);
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
    qryCadBas.SQL := '    DELETE FROM MZI_CADBAS    ';
    qryCadBas.ExecSQL;
    qryCadBas.SQL.Empty;
    Gravando.Texto := 'Cadastro de Bases deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('MZI_CADBAS');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Bases...';
    qryCadBas.SQL := '      SELECT * FROM MZI_CADBAS    ';
    qryCadBas.Open;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryBases.First;

    Try
      While Not qryBases.Eof Do
      Begin
        If Not qryCadBas.Locate('BAS_CODBAS;BAS_PRODUT;BAS_CODUNI', VarArrayOf([qryBases.FieldByName('DESCBASE').AsString,
          qryBases.FieldByName('DESCPRODUTO').AsString, fRetUnidade(qryBases.FieldByName('EMBALAGEM').AsFloat)]), []) Then
        Begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZI_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := qryBases.FieldByName('DESCBASE').AsString;
          qryCadBas.FieldByName('BAS_DESCRI').AsString := qryBases.FieldByName('DESCPRODUTO').AsString;
          qryCadBas.FieldByName('BAS_CODUNI').AsString := fRetUnidade(qryBases.FieldByName('EMBALAGEM').AsFloat);
          qryCadBas.FieldByName('BAS_PRODUT').AsString := qryBases.FieldByName('DESCPRODUTO').AsString;
          qryCadBas.Post;
        End;

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

function TGravandoExecucaoMazaImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoMazaImobiliariaBases.fGetPath(
  intContador: Integer): String;
begin
  Result := Conf.fGet('PATMZI');
end;

function TGravandoExecucaoMazaImobiliariaBases.fRetUnidade(
  fltEmbalagem: Double): String;
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

