{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta QualyVinil *}
{***************************************************************************PH*}
unit untGravandoExecucaoQualyVinilColorantes;

interface

uses
  untAbstractGravandoExecucaoQualyVinil, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;

type
  TGravandoExecucaoQualyVinilColorantes = class(TAbstractGravandoExecucaoQualyVinil)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,
  untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoQualyVinilCores }


procedure TGravandoExecucaoQualyVinilColorantes.Executar(const gravando: IGravando);
Var
  qryColorantes: TUniQuery;
  qryCadCol: IDataSet;
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
  strSQL := strSQL + '  SELECT * FROM CORANTES    ';

  qryColorantes := TUniQuery.Create(Nil);
  qryColorantes.Connection := fConexaoQualyVinilLocal;
  qryColorantes.Close;
  qryColorantes.SQL.Clear;
  qryColorantes.SQL.Add(strSQL);
  qryColorantes.Open;

  qryColorantes.First;

  If (Gravando.Status <> sgGravando) Then
      Exit;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('QUA_CADCOL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
  Gravando.Texto := 'Deletando Cadastro de Colorantes...';
  qryCadCol.SQL := '  DELETE FROM QUA_CADCOL';
  qryCadCol.ExecSQL;
  Gravando.Texto := 'Cadastro de Colorantes deletado...';

  qryCadCol.Close;
  qryCadCol.SQL := '  SELECT * FROM QUA_CADCOL     ';
  qryCadCol.Open;

  While Not qryColorantes.Eof Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryCadCol.Insert;
    qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('QUA_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
    qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCadCol.FieldByName('COL_CODCOL').AsString := qryColorantes.FieldByName('CODIGO').AsString;
    qryCadCol.FieldByName('COL_DESCRI').AsString := qryColorantes.FieldByName('DESCR').AsString;
    qryCadCol.FieldByName('COL_EMBALA').AsFloat  := qryColorantes.FieldByName('VOLUMEEMB_ML').AsFloat;
    qryCadCol.Post;

    Gravando.RegistrarProgresso(0, qryColorantes.RecNo, qryColorantes.RecordCount);
    qryColorantes.Next;
  End;

  If Assigned(qryColorantes) Then
    FreeAndNil(qryColorantes);

end;

function TGravandoExecucaoQualyVinilColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;


end.

