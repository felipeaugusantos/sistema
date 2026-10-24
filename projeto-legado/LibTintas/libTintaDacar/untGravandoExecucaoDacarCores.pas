{**************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Dacar    *}
{***********************************************************************AC*}
unit untGravandoExecucaoDacarCores;

interface

uses
  untAbstractGravandoExecucaoDacar, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, Classes, Math, Variants, System.Win.ComObj;

type
  TGravandoExecucaoDacarCores = class(TAbstractGravandoExecucaoDacar)
  Private
    function fRetMd5Key(qryCadCor : IDataSet; stlQuebra: TStringList) : String;
    function fRetUnidade(strUnidade : String) : String;
    function fVerificaMd5Key(stlQuebra: TStringList): String;
  Public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoDacarCores }


procedure TGravandoExecucaoDacarCores.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  slQuebraLinha: TStringList;
  qryCadCor    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  strCodigo    : String;
  intQuantidade: Integer;
  intCodSeq    : Integer;
begin
  Try

    Try
      If Not FileExists(fGetNomeArquivo)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração de cores não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Arquivo Validado com Sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DAC_CADDAC');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Excluindo os registros...';
      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCor.SQL := 'DELETE FROM DAC_CADDAC';
      qryCadCor.ExecSQL;

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slArquivo.LoadFromFile(fGetNomeArquivo);
      intProcesso   := 0;
      IntQuantidade := 0;
      intCodSeq     := 0;

      For intCont := 0 to slArquivo.Count - 1 do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        slQuebraLinha.Delimiter := ';';
        slQuebraLinha.StrictDelimiter := True;
        slQuebraLinha.DelimitedText := slArquivo[intCont];

        If intCont > 0 Then
        Begin


          strCodigo := UpperCase(slQuebraLinha[5]);

          qryCadCor.Close;
          qryCadCor.SQL := 'SELECT * '+
                           '  FROM DAC_CADDAC '+
                           ' WHERE DAC_MD5KEY = :MD5KEY     ';

          qryCadCor.ParamByName('MD5KEY').AsString := fVerificaMd5Key(slQuebraLinha);
          qryCadCor.Open;

          If (qryCadCor.IsEmpty) Then
          Begin
            IntQuantidade := 1;

            Inc(intCodSeq);

            qryCadCor.Insert;
            qryCadCor.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('DAC_CADDAC', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCor.FieldByName('DAC_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCor.FieldByName('DAC_DTACAD').AsDate    := Date;
            qryCadCor.FieldByName('DAC_CODSEQ').AsString  := TStrUtils.fStrZero(intCodSeq, 6);
            qryCadCor.FieldByName('DAC_CODCOR').AsString  := slQuebraLinha[1];
            qryCadCor.FieldByName('DAC_NOMCOR').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[2]));
            qryCadCor.FieldByName('DAC_DESCRI').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[3]));
            qryCadCor.FieldByName('DAC_CODFML').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[3]));
            qryCadCor.FieldByName('DAC_REFERE').AsString  := slQuebraLinha[1];
            qryCadCor.FieldByName('DAC_CODUNI').AsString  := fRetUnidade(UpperCase(slQuebraLinha[5]));
            qryCadCor.FieldByName('DAC_DESUNI').AsString  := fRetUnidade(UpperCase(slQuebraLinha[5]));
            qryCadCor.FieldByName('DAC_COLECA').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[0]));
            qryCadCor.FieldByName('DAC_EMBALA').AsFloat   := StrToFloat(slQuebraLinha[6]);
            qryCadCor.FieldByName('DAC_CODBAS').AsString  := UpperCase(fTiraCaracEspeciais(slQuebraLinha[4]));

            qryCadCor.FieldByName('DAC_FORM' + TStrUtils.fStrZero(IntQuantidade, 2)).AsString := slQuebraLinha[7];
            qryCadCor.FieldByName('DAC_QTDB' + TStrUtils.fStrZero(IntQuantidade, 2)).AsFloat  := strTofloat(AnsiReplaceStr(slQuebraLinha[9],'.',','));

            qryCadCor.FieldByName('DAC_MD5KEY').AsString  := fRetMd5Key(qryCadCor, slQuebraLinha);

            qryCadCor.Post;
          End
          else
          begin
            Inc(IntQuantidade);

            qryCadCor.Edit;
            qryCadCor.FieldByName('DAC_FORM' + TStrUtils.fStrZero(IntQuantidade, 2)).AsString := slQuebraLinha[7];
            qryCadCor.FieldByName('DAC_QTDB' + TStrUtils.fStrZero(IntQuantidade, 2)).AsFloat  := strTofloat(AnsiReplaceStr(slQuebraLinha[9],'.',','));
            qryCadCor.Post;
          end;

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
    If Assigned(slQuebraLinha) Then
      FreeAndNil(slQuebraLinha);

    If Assigned(slArquivo) Then
      FreeAndNil(slArquivo);

  End;
end;

function TGravandoExecucaoDacarCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoDacarCores.fRetMd5Key(qryCadCor: IDataSet; stlQuebra: TStringList): String;
begin
  Result :=  GetMD5(stlQuebra[1] +
                   UpperCase(stlQuebra[4]) +
                   UpperCase(fTiraCaracEspeciais(stlQuebra[3])) +
                   UpperCase(fTiraCaracEspeciais(stlQuebra[3])) +
                   UpperCase(fTiraCaracEspeciais(stlQuebra[0])) +
                   fRetUnidade(UpperCase(stlQuebra[5])));
end;

function TGravandoExecucaoDacarCores.fRetUnidade(strUnidade: String): String;
begin
  Result := 'LT';

  If strUnidade = 'GALÃO' Then
    Result := 'GL'
  else If strUnidade = 'LATA' Then
    Result := 'LA';
end;

function TGravandoExecucaoDacarCores.fVerificaMd5Key(
  stlQuebra: TStringList): String;
begin
  Result :=  GetMD5(stlQuebra[1] +
                   UpperCase(stlQuebra[4]) +
                   UpperCase(fTiraCaracEspeciais(stlQuebra[3])) +
                   UpperCase(fTiraCaracEspeciais(stlQuebra[3])) +
                   UpperCase(fTiraCaracEspeciais(stlQuebra[0])) +
                   fRetUnidade(UpperCase(stlQuebra[5])));
end;

end.
