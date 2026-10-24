{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Maestria *}
{*******************************************************************************AC*}
unit untGravandoExecucaoMaestriaBases;

interface

uses
  untAbstractGravandoExecucaoMaestria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoMaestriaBases = class(TAbstractGravandoExecucaoMaestria)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoMaestriaBases }

procedure TGravandoExecucaoMaestriaBases.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  qryCadBas    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  slQuebra     : TStringList;
  intArquivos  : Integer;
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

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros MAE_CADBAS...';
      qryCadBas.Close;
      qryCadBas.SQL := '  DELETE FROM MAE_CADBAS    ';
      qryCadBas.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';


      gravando.Texto := 'Arquivo Validado com Sucesso ...';
      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MAE_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';
      gravando.Texto := 'Iniciando Geração do Cadastro de Bases...';

      qryCadBas.Close;
      qryCadBas.SQL := 'SELECT * '+
                       '  FROM MAE_CADBAS ';
      qryCadBas.Open;

      For intArquivos := 0 To stlPaths.Count - 1 Do
      Begin
        slArquivo     := TStringList.Create;
        slQuebra      := TStringList.Create;

        slArquivo.LoadFromFile(GetPath + '\' + stlPaths[intArquivos]);

        intProcesso := 0;

        for intCont := 0 to slArquivo.Count - 1 do
        begin
          if gravando.Status <> sgGravando then
            Exit;

          slQuebra.Delimiter := ';';
          slQuebra.StrictDelimiter := True;
          slQuebra.DelimitedText := slArquivo[intCont];

          If intCont > 0 Then
          Begin
            If Not qryCadBas.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD;BAS_EMBALA', VarArrayOf([slQuebra[3], slQuebra[5],
              fRetCodUnidade(StrToFloat(slQuebra[4])), StrToFloat(slQuebra[4])]), []) Then
            Begin
              qryCadBas.Insert;
              qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MAE_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadBas.FieldByName('BAS_CODBAS').AsString := slQuebra[3];
              qryCadBas.FieldByName('BAS_PRODUT').AsString := slQuebra[5];
              qryCadBas.FieldByName('BAS_UNIDAD').AsString := fRetCodUnidade(StrToFloat(slQuebra[4]));
              qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := StrToFloat(slQuebra[4]);
              qryCadBas.Post;
            End;
          End;
          Inc(intProcesso);
          gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
        End;

        FreeAndNil(slArquivo);
        FreeAndNil(slQuebra);

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

function TGravandoExecucaoMaestriaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoMaestriaBases.GetSqlDestino: string;
begin
  Result := '';
end;

function TGravandoExecucaoMaestriaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

end.
