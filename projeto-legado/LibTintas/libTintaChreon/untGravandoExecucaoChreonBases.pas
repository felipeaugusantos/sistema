{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Chreon *}
{*******************************************************************************AC*}
unit untGravandoExecucaoChreonBases;

interface

uses
  untAbstractGravandoExecucaoChreon, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoChreonBases = class(TAbstractGravandoExecucaoChreon)
  Private
    procedure GravarBases(RegChreon: TRegistroChreon; qryBases: IDataSet);
    procedure DeletarBases(const Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoChreonBases }

procedure TGravandoExecucaoChreonBases.DeletarBases(const Gravando: IGravando);
Var
  qryGen: IDataSet;
begin
  Gravando.Texto := 'Deletando Registros CHR_CADBAS...';
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM CHR_CADBAS  ';
  qryGen.ExecSQL;
  Gravando.Texto := 'Registros deletados com sucesso...';
end;

procedure TGravandoExecucaoChreonBases.Executar(const gravando: IGravando);
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
        Gravando.Texto := 'Path para a geração do arquivo de bases não é válido...';
        Gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Path validado com sucesso ...';

      If stlArquivos.Count <= 0 Then
      Begin
        Gravando.Texto := 'Path para o geração do arquivo de bases está vazio...';
        Gravando.Cancelar;
        Exit;
      End;

      If gravando.Status <> sgGravando Then
        Exit;

      DeletarBases(Gravando);

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CHR_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Iniciando a Geração do Cadastro de Bases ...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := ' SELECT * FROM CHR_CADBAS  ';
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

          GravarBases(registroChreon, qryDestino);

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

function TGravandoExecucaoChreonBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


procedure TGravandoExecucaoChreonBases.GravarBases(RegChreon: TRegistroChreon; qryBases: IDataSet);
Var
  intUnidade: Integer;
  intContador: Integer;
begin
  intUnidade := fGetCountUnidades(fGetString(RegChreon.Product));

  For intContador := 1 To intUnidade Do
  Begin
    If Not qryBases.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([
      fGetString(RegChreon.Base), fGetString(RegChreon.Product), fGetUnidade(intContador)]), []) Then
    Begin
      qryBases.Insert;
      qryBases.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CHR_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
      qryBases.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryBases.FieldByName('BAS_CODBAS').AsString := fGetString(RegChreon.Base);
      qryBases.FieldByName('BAS_PRODUT').AsString := fGetString(RegChreon.Product);
      qryBases.FieldByName('BAS_EMBALA').AsFloat  := fGetUnidadeEmbalagem(intContador, fGetString(RegChreon.Product));
      qryBases.FieldByName('BAS_UNIDAD').AsString := fGetUnidade(intContador);
      qryBases.Post;
    End;
  End;
end;

end.
