{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta RennerImobiliaria *}
{*******************************************************************************AC*}
unit untGravandoExecucaoRennerImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoRennerImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils;

type
  TGravandoExecucaoRennerImobiliariaBases = class(TAbstractGravandoExecucaoRennerImobiliaria)
  private
    procedure pProcessarCadBas(registroRenner: TRegistroRennerImobiliaria);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoRennerImobiliariaBases }

procedure TGravandoExecucaoRennerImobiliariaBases.Executar(const gravando: IGravando);
var
  intCont   : Integer;
  strNomArq : String;
  intLinha,
  intLinhas : Integer;
  strLinha  : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      If stlArquivos.Count <= 0 Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases está vazio...';
        gravando.Cancelar;
        Exit;
      End;

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REI_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.SQL := 'SELECT * FROM REI_CADBAS';
      qryCadBas.Open;

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando a Geração do Cadastro de Bases ...';

      For intCont := 0 To stlArquivos.Count - 1 Do
      Begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            If (Pos('Tabela', stlArquivos.Strings[intCont]) > 0) Then
              Continue;

            strNomArq := stlArquivos.Strings[intCont];

            intLinhas := fContaLinhas(strNomArq);

            AssignFile(arqRenner, strNomArq);
            Reset(arqRenner);

            intLinha := 1;

            gravando.Texto := 'Iniciando processo de gravação do arquivo...' + strNomArq;

            While Not Eof(arqRenner) Do
            Begin
              Readln(arqRenner, strLinha);
              registroRenner := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

              If Trim(registroRenner.IdSeq) = 'IdSeq' Then
                Continue;

              if gravando.Status <> sgGravando then
                Exit;

              pProcessarCadBas(registroRenner);

              gravando.RegistrarProgresso(0, intLinha, intLinhas);
              intLinha := intLinha + 1;
            End;
          Except
            on E: Exception do
            begin
              gravando.Cancelar;
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            End;
          End;
        Finally
          gravando.Texto := 'Finalizado o processo de gravação do arquivo...' + strNomArq;
        End;
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

function TGravandoExecucaoRennerImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TGravandoExecucaoRennerImobiliariaBases.pProcessarCadBas(
  registroRenner: TRegistroRennerImobiliaria);
begin
  If Not qryCadBas.Locate('BAS_CODBAS;BAS_DESCRI;BAS_UNIDAD',
    VarArrayOf([fGetString(registroRenner.IdBase), fGetString(registroRenner.Produto) + ' ' + fGetString(registroRenner.Base), fGetUnidade(fGetString(registroRenner.Embalagem))]),
    []) Then
  Begin
    qryCadBas.Insert;
    qryCadBas.FieldByName('BAS_CODBAS').AsString := fGetString(registroRenner.IdBase);
    qryCadBas.FieldByName('BAS_DESCRI').AsString := fGetString(registroRenner.Produto) + ' ' + fGetString(registroRenner.Base);
    qryCadBas.FieldByName('BAS_UNIDAD').AsString := fGetUnidade(fGetString(registroRenner.Embalagem));
    qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REI_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryCadBas.Post;
  End;
end;

end.
