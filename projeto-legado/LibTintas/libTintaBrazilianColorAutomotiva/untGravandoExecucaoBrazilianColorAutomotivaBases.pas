{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta BrazilianColorAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoBrazilianColorAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoBrazilianColorAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils;

type
  TGravandoExecucaoBrazilianColorAutomotivaBases = class(TAbstractGravandoExecucaoBrazilianColorAutomotiva)
  private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoBrazilianColorAutomotivaBases }

procedure TGravandoExecucaoBrazilianColorAutomotivaBases.Executar(const gravando: IGravando);
Var
  strCodBase : String;
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
      TAutcomTintaFactory.Get.fInsereProCod('BZC_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

      pCreateConnection;

      gravando.Texto := 'Excluindo os registros da tabela BZC_CADBAS...';
      qryDestino.SQL := 'DELETE FROM BZC_CADBAS';
      qryDestino.ExecSQL;


      tabela.CommandText := 'SELECT * '+
                            '  FROM MIX_Bases';
      tabela.Open;

      gravando.Texto := 'Preparando para importação dos registros...';

      tabela.First;

      qryDestino.SQL := 'SELECT * FROM BZC_CADBAS';
      qryDestino.Open;

      gravando.RegistrarProgresso(0, 0, 0);

      While Not tabela.Eof Do
      Begin

        if gravando.Status <> sgGravando then
        begin
          Exit;
        end;

        strCodBase := Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('Codigo').AsString)));

        If Not (qryDestino.Locate('BAS_CODBAS', strCodBase , [])) Then
        Begin
          qryDestino.Insert;
          qryDestino.FieldByName('BAS_CODBAS').AsString := strCodBase;
          qryDestino.FieldByName('BAS_DESBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('Descricao').AsString)));
          qryDestino.FieldByName('BAS_ESPECI').AsString := Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('Especificacao').AsString)));
          qryDestino.FieldByName('BAS_PESESP').AsFloat  := tabela.FieldByName('PesoEspecifico').AsFloat;
          qryDestino.FieldByName('BAS_EMBALA').AsFloat  := tabela.FieldByName('EmbCompra').AsFloat * 1000;
          qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZC_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
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

function TGravandoExecucaoBrazilianColorAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoBrazilianColorAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
