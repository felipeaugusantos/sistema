{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoFalcaoBases;

interface

uses
  untAbstractGravandoExecucaoFalcao, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoFalcaoBases = class(TAbstractGravandoExecucaoFalcao)
  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fRetDescricao(strValor : String) : String;
    function fRetLinha(strValor : String) : String;

  end;

implementation

{ TGravandoExecucaoFalcaoBases}

procedure TGravandoExecucaoFalcaoBases.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  slQuebraLinha: TStringList;
  qryCadBas    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração das bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Arquivo Validado com Sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('FAL_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Bases...';

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\BASES.txt');

      intProcesso := 0;

      for intCont := 0 to slArquivo.Count - 1 do
      begin
        if gravando.Status <> sgGravando then
          Exit;

        slQuebraLinha.Delimiter := '|';
        slQuebraLinha.StrictDelimiter := True;
        slQuebraLinha.DelimitedText := slArquivo[intCont];

        qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
        qryCadBas.SQL := 'SELECT * '+
                         '  FROM FAL_CADBAS '+
                         ' WHERE BAS_CODBAS = :CODBAS '+
                         '   AND BAS_CODUNI = :CODUNI '+
                         '   AND BAS_LINHA_ = :LINHA_ ';
        qryCadBas.ParamByName('CODBAS').AsString := slQuebraLinha[0];
        qryCadBas.ParamByName('CODUNI').AsString := slQuebraLinha[2];
        qryCadBas.ParamByName('LINHA_').AsString := fRetLinha(slQuebraLinha[1]);
        qryCadBas.Open;

        If (qryCadBas.IsEmpty) Then
        Begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FAL_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := slQuebraLinha[0];
          qryCadBas.FieldByName('BAS_DESCRI').AsString := fRetDescricao(slQuebraLinha[1]);
          qryCadBas.FieldByName('BAS_CODUNI').AsString := slQuebraLinha[2];
          qryCadBas.FieldByName('BAS_LINHA_').AsString := fRetLinha(slQuebraLinha[1]);
          qryCadBas.FieldByName('BAS_DESLIN').AsString := slQuebraLinha[3];
          qryCadBas.Post;
        End;

      Inc(intProcesso);
      gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);

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

function TGravandoExecucaoFalcaoBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoFalcaoBases.fRetDescricao(strValor: String): String;
begin
  Result := Copy(strValor, Pos('-',strValor) + 1 ,length(strValor));
end;

function TGravandoExecucaoFalcaoBases.fRetLinha(strValor: String): String;
begin
  Result := Copy(strValor,0,Pos('-',strValor )-1);
end;

end.

