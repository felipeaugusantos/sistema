{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Dacar    *}
{***********************************************************************AC*}
unit untGravandoExecucaoDacarBases;

interface

uses
  untAbstractGravandoExecucaoDacar, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untStrUtils;

type
  TGravandoExecucaoDacarBases = class(TAbstractGravandoExecucaoDacar)
  Private
    function fRetUnidade(strUnidade : String) : String;
  Public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoDacarBases }


procedure TGravandoExecucaoDacarBases.Executar(const gravando: IGravando);
Var
  qryCadBas    : IDataSet;
  strPath      : String;

  slArquivo    : TStringList;
  slQuebraLinha: TStringList;

  intCont      : integer;
  intProcesso  : Integer;

  strCodigo    : String;
begin
  Try
    Try
      strPath := fGetNomeArquivo;

      If Not FileExists(strPath) Then
      Begin
        gravando.Texto := 'O arquivo para geração não foi encontrado!';
        gravando.Cancelar;
      End;

      if (gravando.Status <> sgGravando) then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DAC_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Abrindo o cadastro de Bases';

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slArquivo.LoadFromFile(strPath);
      intProcesso   := 0;

      qryCadBas.SQL := 'DELETE '+
                       '  FROM DAC_CADBAS; ';
      qryCadBas.ExecSQL;

      For intCont := 0 to slArquivo.Count - 1 do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        slQuebraLinha.Delimiter := ';';
        slQuebraLinha.StrictDelimiter := True;
        slQuebraLinha.DelimitedText := slArquivo[intCont];

        If (intCont > 0) Then
        Begin
          strCodigo := UpperCase(slQuebraLinha[7]);

          qryCadBas.SQL := 'SELECT * '+
                           '  FROM DAC_CADBAS '+
                           ' WHERE BAS_CODFML =:CODFML'+
                           '   AND BAS_BASE__ =:BASE__'+
                           '   AND BAS_UNIDAD =:UNIDAD';
          qryCadBas.ParamByName('CODFML').AsString := UpperCase(fTiraCaracEspeciais(slQuebraLinha[3]));
          qryCadBas.ParamByName('BASE__').AsString := UpperCase(fTiraCaracEspeciais(slQuebraLinha[4]));
          qryCadBas.ParamByName('UNIDAD').AsString := fRetUnidade(UpperCase(slQuebraLinha[5]));
          qryCadBas.Open;

          IF (qryCadBas.IsEmpty)Then
          Begin
            qryCadBas.Insert;
            qryCadBas.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('DAC_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadBas.FieldByName('BAS_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadBas.FieldByName('BAS_BASE__').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[4]));
            qryCadBas.FieldByName('BAS_DESCRI').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[3]));
            qryCadBas.FieldByName('BAS_CODFML').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[3]));
            qryCadBas.FieldByName('BAS_UNIDAD').AsString  := fRetUnidade(UpperCase(slQuebraLinha[5]));
            qryCadBas.Post;
          End;

        End;

        Inc(intProcesso);
        gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        gravando.Cancelar;
      end;
    End;
  Finally
    If Assigned(slQuebraLinha) Then
      FreeAndNil(slQuebraLinha);

    If Assigned(slArquivo) Then
      FreeAndNil(slArquivo);
  End;
end;

function TGravandoExecucaoDacarBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoDacarBases.fRetUnidade(strUnidade: String): String;
begin
  Result := 'LT';

  If strUnidade = 'GALÃO' Then
    Result := 'GL'
  Else If strUnidade = 'LATA' Then
    Result := 'LA';
end;



end.
