{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta AnjoSintetica *}
{***************************************************************************PH*}
unit untGravandoExecucaoAnjoSinteticaColorantes;

interface

uses
  untAbstractGravandoExecucaoAnjoSintetica, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Uni;
type
  TGravandoExecucaoAnjoSinteticaColorantes = class(TAbstractGravandoExecucaoAnjoSintetica)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoAnjoSinteticaCores }

procedure TGravandoExecucaoAnjoSinteticaColorantes.Executar(const gravando: IGravando);
Var
  tblCans: TUniQuery;
  DataCans: TUniConnection;
  intContador:Integer;
begin
  Gravando.Texto := 'Verificando path do arquivo...';

  If Not fValidaDiretorio Then
  Begin
    Gravando.Texto := Format('O path %s configurado não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

  DataCans := TUniConnection.Create(Nil);
  DataCans.ProviderName := 'DBF';
  DataCans.LoginPrompt := False;
  DataCans.Database := GetPath;

  If Not (DataCans.Connected) Then
    DataCans.Connected := True;

  tblCans := TUniQuery.Create(Nil);
  tblCans.Connection := DataCans;

  tblCans.Close;
  tblCans.SQL.Clear;
  tblCans.SQL.Add('   SELECT * FROM \CANS.DBF');
  tblCans.Open;
  tblCans.First;

  Gravando.Texto := 'Deletando Cadastro de Embalagem...';

  qryAJA_CADEMB.Close;
  qryAJA_CADEMB.SQL.Empty;
  qryAJA_CADEMB.SQL := '    DELETE FROM AJA_CADEMB    ';
  qryAJA_CADEMB.ExecSQL;

  Gravando.Texto := 'Cadastro de Embalagem deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('AJA_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryAJA_CADEMB.SQL.Empty;
  qryAJA_CADEMB.SQL := '    SELECT * FROM AJA_CADEMB WHERE FALSE    ';
  qryAJA_CADEMB.Open;

  Gravando.RegistrarProgresso(0, 0, 0);
  Gravando.Texto := 'Processando Cadastro de Embalagem...';

   If (Gravando.Status <> sgGravando) Then
    Exit;

  For intContador := 1 To tblCans.RecordCount Do
  Begin
    If Not TStrUtils.fEmptyStr(tblCans.FieldByName('NOM_Q').AsString) Then
    Begin
      If Not fExisteEmbalagem(tblCans.FieldByName('ID').AsString, tblCans.FieldByName('NOM_Q').AsFloat) Then
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryAJA_CADEMB.Insert;
        qryAJA_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AJA_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
        qryAJA_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryAJA_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
        qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;

        If qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat = 900 Then
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'LT'
        Else If qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat = 3600 Then
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'GL'
        Else
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'LA';

        qryAJA_CADEMB.Post;
      End;
    End;
    tblCans.Next;
    Gravando.RegistrarProgresso(0, intContador, tblCans.RecordCount);
  End;
end;

function TGravandoExecucaoAnjoSinteticaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;



end.

