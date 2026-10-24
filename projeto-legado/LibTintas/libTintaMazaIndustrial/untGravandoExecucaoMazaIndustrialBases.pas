{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta MazaIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoMazaIndustrialBases;

interface

uses
  untAbstractGravandoExecucaoMazaIndustrial, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni;

type
  TGravandoExecucaoMazaIndustrialBases = class(TAbstractGravandoExecucaoMazaIndustrial)
  public
    function fQtdEmbalagemMl(strEmbalagem: String): String;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoMazaIndustrialBases }

procedure TGravandoExecucaoMazaIndustrialBases.Executar(const gravando: IGravando);
var
  qryCadBas: IDataSet;
  qryBases: TUniQuery;
  strSQL: String;
begin
  If (Gravando.Status <> sgGravando) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT       ';
  strSQL := strSQL + '   fc.id_componente AS IDBASE,    ';
  strSQL := strSQL + '   co.codigo as CODBASE,          ';
  strSQL := strSQL + '   co.descricao as DESCBASE,      ';
  strSQL := strSQL + '   co.volume_embalagem_ml AS EMB, ';
  strSQL := strSQL + '   co.peso_especifico as PESESP   ';
  strSQL := strSQL + '  FROM formula_composicao AS fc       ';
  strSQL := strSQL + '  INNER JOIN componente AS co ON      ';
  strSQL := strSQL + '    co.id = fc.id_componente      ';
  strSQL := strSQL + '  INNER JOIN formula as FORM ON       ';
  strSQL := strSQL + '    FORM.id = fc.id_formula       ';
  strSQL := strSQL + '  INNER JOIN produto as PRO ON        ';
  strSQL := strSQL + '    PRO.id = FORM.id_produto      ';
  strSQL := strSQL + '  WHERE PRO.tipo = ''INDUSTRIAL''       ';

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
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := '  DELETE FROM MZD_CADBAS   ';
  qryCadBas.ExecSQL;
  qryCadBas.SQL.Empty;
  Gravando.Texto := 'Cadastro de Bases deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('MZD_CADBAS');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Bases...';
  qryCadBas.SQL := '   SELECT * FROM MZD_CADBAS   ';
  qryCadBas.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    While Not qryBases.Eof Do
    Begin
      If Not qryCadBas.Locate('BAS_CODBAS', qryBases.FieldByName('CODBASE').AsString, []) Then
      Begin
        qryCadBas.Insert;
        qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZD_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadBas.FieldByName('BAS_CODBAS').AsString := qryBases.FieldByName('CODBASE').AsString;
        qryCadBas.FieldByName('BAS_DESCRI').AsString := qryBases.FieldByName('DESCBASE').AsString;
        qryCadBas.FieldByName('BAS_EFEITO').AsString := '';
        qryCadBas.FieldByName('BAS_LINHA_').AsString := '';
        qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := qryBases.FieldByName('EMB').AsFloat;
        qryCadBas.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryCadBas.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
        qryCadBas.FieldByName('BAS_PESESP').AsFloat  := qryBases.FieldByName('PESESP').AsFloat;
        qryCadBas.Post;
      End;

      qryBases.Next;
      Gravando.RegistrarProgresso(0, qryBases.RecNo, qryBases.RecordCount);
    End;

    Gravando.Texto := 'Gravando Bases Diluentes...';

    qryBases.Close;
    qryBases.SQL.Clear;
    qryBases.SQL.Add('SELECT * FROM componente WHERE tipo = ''REDUCER'' ');
    qryBases.Open;
    qryBases.First;

    While Not qryBases.Eof Do
    Begin
      If Not qryCadBas.Locate('BAS_CODBAS', qryBases.FieldByName('codigo').AsString, []) Then
      Begin
        qryCadBas.Insert;
        qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZD_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadBas.FieldByName('BAS_CODBAS').AsString := qryBases.FieldByName('codigo').AsString;
        qryCadBas.FieldByName('BAS_DESCRI').AsString := qryBases.FieldByName('descricao').AsString;
        qryCadBas.FieldByName('BAS_EFEITO').AsString := 'DILUENTE';
        qryCadBas.FieldByName('BAS_LINHA_').AsString := '';
        qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := qryBases.FieldByName('volume_embalagem_ml').AsFloat;
        qryCadBas.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryCadBas.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
        qryCadBas.FieldByName('BAS_PESESP').AsFloat  := qryBases.FieldByName('peso_especifico').AsFloat;
        qryCadBas.Post;
      End;

      qryBases.Next;
      Gravando.RegistrarProgresso(0, qryBases.RecNo, qryBases.RecordCount);
    End;
  Finally
    FreeAndNil(qryBases);
  End;
End;

function TGravandoExecucaoMazaIndustrialBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoMazaIndustrialBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;



end.
