{****************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta StarmixWeb *}
{*************************************************************************AC*}
unit untGravandoExecucaoStarmixWebBases;

interface

uses
  untAbstractGravandoExecucaoStarmixWeb, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils;

type
  TGravandoExecucaoStarmixWebBases = class(TAbstractGravandoExecucaoStarmixWeb)
  Private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoStarmixWebBases }

procedure TGravandoExecucaoStarmixWebBases.Executar(const gravando: IGravando);
var
  qryDestino : IDataSet;
  intContador: Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      pPreenchendoCdsParaGeracao(gravando);

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('STW_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'SELECT * FROM STW_CADBAS';
      qryDestino.Open;

      intContador := 0;

      cdsBases.First;
      While Not cdsBases.Eof Do
      Begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            Inc(intContador);

            If (Not qryDestino.Locate('BAS_CODBAS', cdsBases.FieldByName('CODIGO').AsString, [])) Then
            Begin
              qryDestino.Insert;
              qryDestino.FieldByName('BAS_CODBAS').AsString := cdsBases.FieldByName('CODIGO').AsString;
              qryDestino.FieldByName('BAS_CODSEQ').AsString := cdsBases.FieldByName('CODSEQ').AsString;
              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('STW_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('BAS_EMBALA').AsFloat  := cdsBases.FieldByName('EMBALA').AsFloat;
              qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(cdsBases.FieldByName('EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
              qryDestino.FieldByName('BAS_PESESP').AsFloat  := cdsBases.FieldByName('PESESP').AsFloat;
              qryDestino.FieldByName('BAS_DESBAS').AsString := cdsBases.FieldByName('NOME').AsString;
              qryDestino.Post;
            End;
          Except
            on E: Exception do
            begin
              gravando.Cancelar;
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          gravando.RegistrarProgresso(0, intContador, cdsBases.RecordCount);
        End;
        cdsBases.Next;
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoStarmixWebBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoStarmixWebBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
