{******************************************************************************}
{* Classe responsável pela geração do cadastro de Embalagem da tinta Advance *}
{***************************************************************************PH*}
unit untGravandoExecucaoAdvanceEmbalagem;

interface

uses
  untAbstractGravandoExecucaoAdvance, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Uni;
type
  TGravandoExecucaoAdvanceEmbalagem = class(TAbstractGravandoExecucaoAdvance)
  private
    function fRetUnidade(fltQtdEmb:Double):String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoAdvanceCores }

procedure TGravandoExecucaoAdvanceEmbalagem.Executar(const gravando: IGravando);
Var
  qryUniEmbalagem: TUniQuery;
  conEmbalagem:TUniConnection;
Begin
  Try
    Try
      Gravando.Texto := 'Verificando diretorio configurado...';

      If Not fValidaDiretorio Then
      Begin
        Gravando.Texto := Format('O diretorio %s não está configurado corretamente ou não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Diretorio verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

      conEmbalagem := GetDbfAdvance(GetPath);

      If Not conEmbalagem.Connected Then
        conEmbalagem.Connected := True;

      qryUniEmbalagem := GetSQLAdvance('    SELECT * FROM \CANS.DBF     ', conEmbalagem);


      Gravando.Texto := 'Deletando Cadastro de Embalagem...';
      qryADV_CADEMB.Close;
      qryADV_CADEMB.SQL.Empty;
      qryADV_CADEMB.SQL := '    DELETE FROM ADVCOR_CADEMB     ';
      qryADV_CADEMB.ExecSQL;
      Gravando.Texto := 'Cadastro de Embalagem deletado...';

      qryADV_CADEMB.SQL.Empty;
      qryADV_CADEMB.SQL := '    SELECT * FROM ADVCOR_CADEMB     ';
      qryADV_CADEMB.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ADVCOR_CADEMB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.RegistrarProgresso(0, 0, 0);
      Gravando.Texto := Format('Processando Cadastro de Embalagem: [%s]', [AnsiReplaceStr(GetPath + '\CANS.DBF', '"', '')]);

      While Not qryUniEmbalagem.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryADV_CADEMB.Insert;
        qryADV_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADVCOR_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
        qryADV_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryADV_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(qryUniEmbalagem.FieldByName('ID').AsString), 2);
        qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := qryUniEmbalagem.FieldByName('NOM_Q').AsFloat;
        qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(qryUniEmbalagem.FieldByName('NOM_Q').AsFloat);
        qryADV_CADEMB.Post;
        qryUniEmbalagem.Next;
        gravando.RegistrarProgresso(0, qryUniEmbalagem.RecNo, qryUniEmbalagem.RecordCount);

      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally

  End;

end;

function TGravandoExecucaoAdvanceEmbalagem.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagem';
end;



function TGravandoExecucaoAdvanceEmbalagem.fRetUnidade(
  fltQtdEmb: Double): String;
begin
  Result := '';
  If (fltQtdEmb > 800 )  And (fltQtdEmb <= 1000) Then
    Result := 'LT'
  Else If (fltQtdEmb > 3000) And (fltQtdEmb <= 4500) Then
    Result := 'GL'
  Else If (fltQtdEmb > 16000) And (fltQtdEmb <= 20000) Then
    Result := 'LA';
end;

end.

