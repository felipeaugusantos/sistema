{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Lazzumix *}
{***********************************************************************AC*}
unit untGravandoExecucaoLazzumixBases;

interface

uses
  untAbstractGravandoExecucaoLazzumix, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes;

type
  TGravandoExecucaoLazzumixBases = class(TAbstractGravandoExecucaoLazzumix)
  Var
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoLazzumixBases }

procedure TGravandoExecucaoLazzumixBases.Executar(const gravando: IGravando);
var
  qryDestino : IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath(ttBases)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      stlBases.LoadFromFile(GetPath(ttBases));

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LAZ_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      intContador := 0;
      While (intContador < stlBases.Count-1) Do
      Begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            strCodBas := Trim(stlBases[intContador]);
            Inc(intContador);

            strEmbala := Trim(stlBases[intContador]);
            Inc(intContador);

            strDesBas := Trim(stlBases[intContador]);
            Inc(intContador, 2);

            qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
            qryDestino.SQL := 'SELECT * FROM LAZ_CADBAS WHERE BAS_CODBAS = :CODBAS';
            qryDestino.ParamByName('CODBAS').AsString := strCodBas;
            qryDestino.Open;

            If qryDestino.IsEmpty Then
            Begin
              qryDestino.Insert;
              qryDestino.FieldByName('BAS_CODBAS').AsString := strCodBas;
              qryDestino.FieldByName('BAS_DESBAS').AsString := strDesBas;
              qryDestino.FieldByName('BAS_EMBALA').AsFloat  := GetEmbalagem(strEmbala);
              qryDestino.FieldByName('BAS_QTDEMB').AsString := fQtdEmbalagemMl(FloatToStr(GetEmbalagem(strEmbala)));
              qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LAZ_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
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
          gravando.RegistrarProgresso(0, intContador, stlBases.Count);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoLazzumixBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoLazzumixBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
