{******************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta QualyVinil *}
{***************************************************************************PH*}
unit untGravandoExecucaoQualyVinilBases;

interface

uses
  untAbstractGravandoExecucaoQualyVinil, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;

type
  TGravandoExecucaoQualyVinilBases = class(TAbstractGravandoExecucaoQualyVinil)
  Private
    function fRetUnidade(strIdEmb: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,
  untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoQualyVinilCores }


procedure TGravandoExecucaoQualyVinilBases.Executar(const gravando: IGravando);
var
  qryLocBases: TUniQuery;
  qryMakBases: TUniQuery;
  qryCadBas: IDataSet;
  strSQL: String;
begin
  Gravando.Texto := 'Verificando Path...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := 'Os arquivos de geração não foram encontrado! Rever configurações.';
    Exit;
  End;

  Gravando.Texto := 'Carregando Dados...';

  strSQL := '';
  strSQL := strSQL + '  SELECT * FROM PRECO_PRODBASE    ';

  qryLocBases := TUniQuery.Create(Nil);
  qryLocBases.Connection := fConexaoQualyVinilLocal;
  qryLocBases.Close;
  qryLocBases.SQL.Clear;
  qryLocBases.SQL.Add(strSQL);
  qryLocBases.Open;

  strSQL := '';
  strSQL := strSQL + '  SELECT        ';
  strSQL := strSQL + '    B.CODIGO AS BASE,         ';
  strSQL := strSQL + '    B.DESCR AS DESCRICAO,     ';
  strSQL := strSQL + '    B.ID_BASE,                ';
  strSQL := strSQL + '    B.ID_LINHA,               ';
  strSQL := strSQL + '    L.DESCR AS PRODUTO        ';
  strSQL := strSQL + '  FROM                        ';
  strSQL := strSQL + '    BASES B                   ';
  strSQL := strSQL + '  INNER JOIN LINHA L ON       ';
  strSQL := strSQL + '    B.ID_LINHA = L.ID_LINHA   ';

  qryMakBases := TUniQuery.Create(Nil);
  qryMakBases.Connection := fConexaoQualyVinilMaker;
  qryMakBases.Close;
  qryMakBases.SQL.Clear;
  qryMakBases.SQL.Add(strSQL);
  qryMakBases.Open;

  qryLocBases.First;
  qryMakBases.First;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('QUA_CADBAS');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  Gravando.Texto := 'Deletando Cadastro de Bases...';
  qryCadBas.SQL := '  DELETE FROM QUA_CADBAS';
  qryCadBas.ExecSQL;
  Gravando.Texto := 'Cadastro de Bases deletado...';

  qryCadBas.Close;
  qryCadBas.SQL := '  SELECT * FROM QUA_CADBAS      ';
  qryCadBas.Open;

  Gravando.Texto := 'Processando Cadastro de Bases...';
  Gravando.RegistrarProgresso(0, 0, 0);

  While Not qryLocBases.Eof Do
  Begin

    If Not qryMakBases.Locate('ID_BASE', VarArrayOf([qryLocBases.FieldByName('ID_BASE').AsString]), []) Then
    Begin
      Gravando.RegistrarProgresso(0, qryLocBases.RecNo, qryLocBases.RecordCount);
      qryLocBases.Next;
      Continue;
    End;

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryCadBas.Insert;
    qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('QUA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCadBas.FieldByName('BAS_CODBAS').AsString := qryMakBases.FieldByName('BASE').AsString;
    qryCadBas.FieldByName('BAS_DESCRI').AsString := qryMakBases.FieldByName('DESCRICAO').AsString;
    qryCadBas.FieldByName('BAS_PRODUT').AsString := qryMakBases.FieldByName('PRODUTO').AsString;
    qryCadBas.FieldByName('BAS_CODUNI').AsString := fRetUnidade(qryLocBases.FieldByName('ID_EMB').AsString);
    qryCadBas.Post;

    Gravando.RegistrarProgresso(0, qryLocBases.RecNo, qryLocBases.RecordCount);
    qryLocBases.Next;
  End;

  FreeAndNil(qryLocBases);
  FreeAndNil(qryMakBases);
end;

function TGravandoExecucaoQualyVinilBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoQualyVinilBases.fRetUnidade(strIdEmb: String): String;
begin
  Result := '';

  If strIdEmb = '1' Then
    Result := 'QT'
  Else If Pos(strIdEmb, '2_4_7') > 0 Then
    Result := 'GL'
  Else If Pos(strIdEmb, '3_5_6') > 0 Then
    Result := 'LA';
end;

end.

