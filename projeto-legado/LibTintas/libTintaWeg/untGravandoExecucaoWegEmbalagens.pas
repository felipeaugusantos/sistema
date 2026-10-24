{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Weg *}
{***************************************************************************PH*}
unit untGravandoExecucaoWegEmbalagens;

interface

uses
  untAbstractGravandoExecucaoWeg, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Uni;
type
  TGravandoExecucaoWegEmbalagens = class(TAbstractGravandoExecucaoWeg)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoWegCores }

procedure TGravandoExecucaoWegEmbalagens.Executar(const gravando: IGravando);
Var
  tblCans :TUniQuery;
  DataCans: TUniConnection;
begin
  Gravando.Texto := 'Verificando Path do Arquivo...';

  If Not fValidaDiretorio Then
  Begin
    Gravando.Texto := Format('O path %s configurado não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Path verificado com sucesso...';

  Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

  qryWEG_CADEMB.Close;
  Gravando.Texto := 'Excluindo Cadastro de Embalagem inconsistente...';
  qryWEG_CADEMB.SQL.Empty;
  qryWEG_CADEMB.SQL := '    DELETE FROM WEG_CADEMB    ';
  qryWEG_CADEMB.ExecSQL;
  Gravando.Texto := 'Cadastro de Embalagem excluido...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('WEG_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Embalagem...';

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
  tblCans.SQL.Add('   SELECT * FROM \CANS.DBF   ');
  tblCans.Open;
  tblCans.First;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  qryWEG_CADEMB.SQL.Empty;
  qryWEG_CADEMB.SQL := '  SELECT * FROM WEG_CADEMB    ';
  qryWEG_CADEMB.Open;
  qryWEG_CADEMB.First;

  Gravando.Texto := Format('Processando Cadastro de %s...', ['Embalagem']);
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try
      While Not tblCans.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not fExisteEmbalagem(tblCans.FieldByName('ID').AsString, tblCans.FieldByName('NOM_Q').AsFloat) Then
        Begin
          qryWEG_CADEMB.Insert;
          qryWEG_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WEG_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
          qryWEG_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryWEG_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
          qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
          qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(tblCans.FieldByName('NOM_Q').AsFloat);
          qryWEG_CADEMB.Post;
        End;

        tblCans.Next;
        Gravando.RegistrarProgresso(0, tblCans.RecNo, tblCans.RecordCount);

      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    If Assigned(DataCans) Then
      FreeAndNil(DataCans);

    If Assigned(tblCans) Then
      FreeAndNil(tblCans);

    Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Embalagem']);
  End;


end;

function TGravandoExecucaoWegEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagem';
end;

end.

