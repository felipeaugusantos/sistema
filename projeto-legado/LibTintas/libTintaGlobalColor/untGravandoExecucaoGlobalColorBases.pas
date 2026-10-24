{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta GlobalColor *}
{*******************************************************************************AC*}
unit untGravandoExecucaoGlobalColorBases;

interface

uses
  untAbstractGravandoExecucaoGlobalColor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils;

type
  TGravandoExecucaoGlobalColorBases = class(TAbstractGravandoExecucaoGlobalColor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoGlobalColorBases }

procedure TGravandoExecucaoGlobalColorBases.Executar(const gravando: IGravando);
var
  intUnidade,
  intProduto,
  intBase,
  intProc: Integer;

  qryCadBas : IDataSet;
Const
  arrayUnidade: Array[1..3] Of String = ('LT', 'GL', 'LA');
  ArrayProduto: Array[1..15] Of String = ('ACRILICO FOSCO PREMIUM',
    'ESMALTE SINTETICO ACETINADO PREMIUM',
    'ESMALTE SINTETICO BRILHANTE PREMIUM',
    'ACRILICO SEMI BRILHO PREMIUM',
    'ACRILICO ACETINADO PREMIUM',
    'ESMALTE BRILHANTE BASE AGUA',
    'ESMALTE ACETINADO BASE AGUA',
    'LATEX VINIL ACRILICO ECONOMICO',
    'ESMALTE SINTETICO STANDARD',
    'ESLAMTE SINTETICO SECAGEM RAPIDA',
    'ACRILICO ULTRA STANDARD',
    'GEL ENVELHECEDOR',
    'TEXTURA ACRILICA LISA',
    'TEXTURA ACRILICA RUSTICA',
    'TEXTURA ACRILICA DESENHO');
begin
  Gravando.Texto := 'Carregando dados do Cadastro de Bases...';

  If (Gravando.Status <> sgGravando) Then
    Exit;


  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('GLO_CADBAS');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Base...';
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := '  DELETE FROM GLO_CADBAS';
  qryCadBas.ExecSQL;
  qryCadBas.SQL.Empty;
  qryCadBas.SQL := '    SELECT * FROM GLO_CADBAS WHERE FALSE    ';
  qryCadBas.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Processando Cadastro de Base...';
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try

      intProc := 0;
      For IntBase := 1 To 3 Do
      Begin
        For intUnidade := 1 To 3 Do
        Begin
          For intProduto := 1 To 15 Do
          Begin
            If Not qryCadBas.Locate('BAS_BASE__;BAS_DESCRI;BAS_UNIDAD', VarArrayOf([intBase, ArrayProduto[intProduto], arrayUnidade[intUnidade]]), []) Then
            Begin

              If (Gravando.Status <> sgGravando) Then
                Break;

              Inc(IntProc);
              qryCadBas.Insert;
              qryCadBas.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('GLO_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadBas.FieldByName('BAS_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadBas.FieldByName('BAS_BASE__').AsInteger := intBase;
              qryCadBas.FieldByName('BAS_DESCRI').AsString  := ArrayProduto[intProduto];
              qryCadBas.FieldByName('BAS_UNIDAD').AsString  := arrayUnidade[intUnidade];
              qryCadBas.FieldByName('BAS_PRECUS').AsFloat   := 0.00;
              qryCadBas.FieldByName('BAS_PREVEN').AsFloat   := 0.00;
              qryCadBas.FieldByName('BAS_MARGEM').AsFloat   := 0.00;
              qryCadBas.Post;

              Gravando.RegistrarProgresso(0, intProc, 135);
            End;
          End;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Base processado com sucesso...';
  End;
end;

function TGravandoExecucaoGlobalColorBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


end.
