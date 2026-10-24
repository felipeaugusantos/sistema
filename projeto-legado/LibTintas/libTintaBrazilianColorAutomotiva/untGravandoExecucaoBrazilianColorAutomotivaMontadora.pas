{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta BrazilianColorAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoBrazilianColorAutomotivaMontadora;

interface

uses
  untAbstractGravandoExecucaoBrazilianColorAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

type
  TGravandoExecucaoBrazilianColorAutomotivaMontadora = class(TAbstractGravandoExecucaoBrazilianColorAutomotiva)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  Private
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoBrazilianColorAutomotivaMontadora }

procedure TGravandoExecucaoBrazilianColorAutomotivaMontadora.Executar(const gravando: IGravando);
Var
  strCodMontadora : String;
begin
  Try
    Try

      gravando.Texto := 'Verificando path dos arquivos...';

      if not FileExists(AnsiReplaceStr(GetPath, '"', '')) then
      begin
        gravando.Texto := Format('O arquivo [%s] não existe, ou não foi encontrado!', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      end;

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Path validado com sucesso...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BZC_CADMON');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

      pCreateConnection;

      gravando.Texto := 'Excluindo os registros da BZC_CADMON...';
      qryDestino.SQL := 'DELETE FROM BZC_CADMON';
      qryDestino.ExecSQL;


      tabela.CommandText := 'SELECT * '+
                            '  FROM MIX_Montadoras';
      tabela.Open;

      gravando.Texto := 'Preparando para importação dos registros...';

      tabela.First;

      qryDestino.SQL := 'SELECT * FROM BZC_CADMON';
      qryDestino.Open;

      gravando.RegistrarProgresso(0, 0, 0);

      While Not tabela.Eof Do
      Begin

        if gravando.Status <> sgGravando then
        begin
          Exit;
        end;

        strCodMontadora := TStrUtils.fStrZero(Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('id_MIX_Montadora').AsString))), 5);

        If Not (qryDestino.Locate('MON_CODMON', strCodMontadora , [])) Then
        Begin
          qryDestino.Insert;
          qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZC_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
          qryDestino.FieldByName('MON_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryDestino.FieldByName('MON_CODMON').AsString := strCodMontadora;
          qryDestino.FieldByName('MON_DESCRI').AsString := Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('Montadora').AsString)));
          qryDestino.FieldByName('MON_SIGLA_').AsString := Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('Sigla').AsString)));
          qryDestino.Post;

        end;

        gravando.RegistrarProgresso(1, tabela.RecNo, tabela.RecordCount);
        tabela.Next;
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    pDestroyConnection;
  End;

end;

function TGravandoExecucaoBrazilianColorAutomotivaMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;

end.
