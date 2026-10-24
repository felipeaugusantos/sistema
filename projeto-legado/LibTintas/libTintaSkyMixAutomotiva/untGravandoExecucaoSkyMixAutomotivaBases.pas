{************************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta SkyMixAutomotiva *}
{*********************************************************************************AC*}
unit untGravandoExecucaoSkyMixAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoSkyMixAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

type
  TGravandoExecucaoSkyMixAutomotivaBases = class(TAbstractGravandoExecucaoSkyMixAutomotiva)
  Private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    function fRetUnidade(fltEmbalagem: Double):String;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoSkyMixAutomotivaBases }

procedure TGravandoExecucaoSkyMixAutomotivaBases.Executar(const gravando: IGravando);
Var
  slArquivo    : TStringList;
  qryCadBas    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  slQuebra     : TStringList;
begin
  Try
    Try
      Gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração das bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Arquivo Validado com Sucesso ...';

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros SKY_CADBAS...';
      qryCadBas.Close;
      qryCadBas.SQL := '  DELETE FROM SKY_CADBAS    ';
      qryCadBas.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';


      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SKY_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso!';
      Gravando.Texto := 'Iniciando Geração do Cadastro de Bases...';

      slArquivo     := TStringList.Create;
      slQuebra      := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\' + 'Base.txt');
      intProcesso := 0;

      For intCont := 0 To slArquivo.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        slQuebra.Delimiter := '|';
        slQuebra.StrictDelimiter := True;
        slQuebra.DelimitedText := slArquivo[intCont];

        qryCadBas.Close;
        qryCadBas.SQL := 'SELECT * '+
                         '  FROM SKY_CADBAS '+
                         ' WHERE BAS_CODBAS = :CODBAS ';
        qryCadBas.ParamByName('CODBAS').AsString := Trim(slQuebra[1]);
        qryCadBas.Open;

        If qryCadBas.IsEmpty Then
        Begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SKY_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_CODPRO').AsString := Trim(slQuebra[0]);
          qryCadBas.FieldByName('BAS_CODBAS').AsString := Trim(slQuebra[1]);
          qryCadBas.FieldByName('BAS_PESESP').AsFloat  := StrToFloat(Trim(slQuebra[2]));
          qryCadBas.FieldByName('BAS_DESCRI').AsString := Trim(slQuebra[3]);
          qryCadBas.FieldByName('BAS_CODUNI').AsString := Trim(fRetUnidade(StrToFloat(slQuebra[15])));
          qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := StrToFloat(slQuebra[15]);
          qryCadBas.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryCadBas.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
          qryCadBas.Post
        End;

        Inc(intProcesso);
        Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;
    Except
      On E: Exception Do
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    FreeAndNil(slArquivo);
    FreeAndNil(slQuebra);
  End;
end;

function TGravandoExecucaoSkyMixAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoSkyMixAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoSkyMixAutomotivaBases.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 1000 Then
    Result := fCfgTin('SKYULT')
  Else If fltEmbalagem < 5000 Then
    Result := fCfgTin('SKYUGL')
  Else
    Result := fCfgTin('SKYULA');
end;

end.
