{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Chreon *}
{**********************************************************************PH*}
unit untGravandoExecucaoChreonCores;

interface

uses
  untAbstractGravandoExecucaoChreon, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.Win.ComObj;

type
  TGravandoExecucaoChreonCores = class(TAbstractGravandoExecucaoChreon)
  Private
    function fGetFatorUnidade(fltFator, fltFatorFixo: Double): Double;
    procedure GravarCores(RegChreon: TRegistroChreon; qryCores: IDataSet);
    procedure DeletarCores(const Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoChreonCores }

procedure TGravandoExecucaoChreonCores.DeletarCores(const Gravando: IGravando);
Var
  qryGen: IDataSet;
begin
  Gravando.Texto := 'Deletando Registros CHR_CADCHR...';
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM CHR_CADCHR  ';
  qryGen.ExecSQL;
  Gravando.Texto := 'Registros deletados com sucesso...';
end;

procedure TGravandoExecucaoChreonCores.Executar(const gravando: IGravando);
var
  intCont     : Integer;
  strNomArq   : String;
  intLinha,
  intLinhas   : Integer;
  strLinha    : String;
  qryDestino  : IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        Gravando.Texto := 'Path para a geração do arquivo de cores não é válido...';
        Gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Path validado com sucesso ...';

      If stlArquivos.Count <= 0 Then
      Begin
        Gravando.Texto := 'Path para o geração do arquivo de cores está vazio...';
        Gravando.Cancelar;
        Exit;
      End;

      If gravando.Status <> sgGravando Then
        Exit;

      DeletarCores(Gravando);

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CHR_CADCHR');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Iniciando a Geração do Cadastro de Cores ...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := ' SELECT * FROM CHR_CADCHR  ';
      qryDestino.Open;

      For intCont := 0 To stlArquivos.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Break;

        strNomArq := stlArquivos.Strings[intCont];
        intLinhas := fContaLinhas(strNomArq);
        AssignFile(arqChreon, strNomArq);
        Reset(arqChreon);
        intLinha := 1;

        While Not Eof(arqChreon) Do
        Begin
          Readln(arqChreon, strLinha);
          registroChreon := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

          If Trim(registroChreon.RecordId) = 'RecordId' Then
            Continue;

          If gravando.Status <> sgGravando Then
            Exit;

          GravarCores(registroChreon, qryDestino);

          Gravando.RegistrarProgresso(0, intLinha, intLinhas);
          intLinha := intLinha + 1;
        End;
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
  End;
end;

function TGravandoExecucaoChreonCores.fGetFatorUnidade(fltFator,
  fltFatorFixo: Double): Double;
begin
  Result := fltFator / fltFatorFixo;
end;

function TGravandoExecucaoChreonCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


procedure TGravandoExecucaoChreonCores.GravarCores(RegChreon: TRegistroChreon;
  qryCores: IDataSet);
Var
  intUnidade: Integer;
  intContador: Integer;
  fltFator: Double;
  intQuantidade: Integer;
begin
  intUnidade := fGetCountUnidades(fGetString(RegChreon.Product));

  For intContador := 1 To intUnidade Do
  Begin
    qryCores.Insert;
    qryCores.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CHR_CADCHR', TAutcomTintaFactory.Get.GetCodEmp);
    qryCores.FieldByName('CHR_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCores.FieldByName('CHR_CODIGO').AsString := fGetString(RegChreon.ColorId);
    qryCores.FieldByName('CHR_NOMCOR').AsString := fGetString(RegChreon.Notation);
    qryCores.FieldByName('CHR_DESCRI').AsString := fGetString(RegChreon.Notation);
    qryCores.FieldByName('CHR_CODBAS').AsString := fGetString(RegChreon.Base);
    qryCores.FieldByName('CHR_PRODUT').AsString := fGetString(RegChreon.Product);
    qryCores.FieldByName('CHR_UNIDAD').AsString := fGetUnidade(intContador);
    qryCores.FieldByName('CHR_COLECA').AsString := fGetString(RegChreon.SourceFile);
    qryCores.FieldByName('CHR_PALETA').AsString := fGetString(RegChreon.Palette);

    fltFator := fGetFatorUnidade(fGetUnidadeEmbalagem(intContador, fGetString(RegChreon.Product)), fGetUnidadeEmbalagem(1, fGetString(RegChreon.Product)));

    For intQuantidade := 1 To 5 Do
    Begin
      If TStrUtils.fEmptyStr(fGetString(RegChreon.Tinter[intQuantidade])) Then
        Break;


      qryCores.FieldByName('CHR_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := fGetString(RegChreon.Tinter[intQuantidade]);
      qryCores.FieldByName('CHR_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(fGetString(RegChreon.Shot[intQuantidade])) * fltFator;
    End;

    qryCores.FieldByName('CHR_MD5KEY').AsString := GetMD5(qryCores.FieldByName('CHR_CODIGO').AsString +
                                                          qryCores.FieldByName('CHR_NOMCOR').AsString +
                                                          qryCores.FieldByName('CHR_CODBAS').AsString +
                                                          qryCores.FieldByName('CHR_PRODUT').AsString +
                                                          qryCores.FieldByName('CHR_UNIDAD').AsString +
                                                          qryCores.FieldByName('CHR_COLECA').AsString +
                                                          qryCores.FieldByName('CHR_PALETA').AsString);
    qryCores.Post;
  End;
end;

end.

