{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta GlobalColor *}
{***************************************************************************PH*}
unit untGravandoExecucaoGlobalColorColorantes;

interface

uses
  untAbstractGravandoExecucaoGlobalColor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Variants;
type
  TGravandoExecucaoGlobalColorColorantes = class(TAbstractGravandoExecucaoGlobalColor)
  private
    function fRetQtdEmbalagem(strUnidade:String):Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoGlobalColorCores }

procedure TGravandoExecucaoGlobalColorColorantes.Executar(const gravando: IGravando);
Var
  qryCadCol :IDataSet;
  qryCadEmb : IDataSet;
  intContador : Integer;
  intUnidade : Integer;
  fltQtd: Double;
Const
  arrayCodigo: Array[1..13] Of String = ('AXX', 'B', 'C', 'L', 'R', 'I', 'T', 'E', 'V', 'KX', 'F', 'D', 'AXN');
  ArrayNome: Array[1..13] Of String = ('AMERELO', 'PRETO', 'AMARELO ÓXIDO', 'RAW UMBER', 'VERMELHO', 'MARROM ÓXIDO',
      'AMARELO', 'AZUL', 'MAGENTA', 'BRANCO', 'VERMELHO ÓXIDO', 'VERDE', 'AMARELO');
  ArrayUnidade: Array[1..3] Of String = ('LT', 'GL', 'LA');
begin
  Gravando.Texto := 'Carregando dados do Cadastro de Colorantes...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('GLO_CADCOL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Colorante...';
  qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadCol.SQL := 'DELETE FROM GLO_CADCOL';
  qryCadCol.ExecSQL;
  qryCadCol.SQL.Empty;
  qryCadCol.SQL := '    SELECT * FROM GLO_CADCOL WHERE FALSE    ';
  qryCadCol.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Processando Cadastro de Colorante...';
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try
      For IntContador := 1 To 13 Do
      Begin
        If Not qryCadCol.Locate('COL_CODCOL', VarArrayOf([ArrayCodigo[intContador]]), []) Then
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GLO_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('COL_CODCOL').AsString := arrayCodigo[intContador];
          qryCadCol.FieldByName('COL_DESCRI').AsString := ArrayNome[intContador];
          qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 946;
          qryCadCol.Post;

        End;
        Gravando.RegistrarProgresso(0, intContador, 13);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Colorante processado com sucesso!';
  End;

  Gravando.RegistrarProgresso(0, 0, 0);

  Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('GLO_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Embalagem...';
  qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadEmb.SQL := 'DELETE FROM GLO_CADEMB';
  qryCadEmb.ExecSQL;
  qryCadEmb.SQL.Empty;
  qryCadEmb.SQL := '    SELECT * FROM GLO_CADEMB WHERE FALSE    ';
  qryCadEmb.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Processando Cadastro de Embalagem...';

  Try
    Try
      For intUnidade := 1 To 3 Do
      Begin
        If Not qryCadEmb.Locate('EMB_CODEMB', VarArrayOf([IntToStr(intUnidade)]), []) Then
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadEmb.Insert;
          qryCadEmb.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GLO_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadEmb.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadEmb.FieldByName('EMB_CODEMB').AsString := IntToStr(intUnidade);
          qryCadEmb.FieldByName('EMB_UNIDAD').AsString := ArrayUnidade[intUnidade];

          fltQtd := fRetQtdEmbalagem(qryCadEmb.FieldByName('EMB_UNIDAD').AsString);
          qryCadEmb.FieldByName('EMB_QTDEMB').AsFloat := fltQtd;
          qryCadEmb.Post;
        End;
        Gravando.RegistrarProgresso(0, intUnidade, 3);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Embalagem processado com sucesso!';
  End;


end;

function TGravandoExecucaoGlobalColorColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes e Embalagens';
end;



function TGravandoExecucaoGlobalColorColorantes.fRetQtdEmbalagem(
  strUnidade: String): Double;
begin
  Result := 0;

  If strUnidade = 'LT' Then
    Result := 810
  Else If strUnidade = 'GL' Then
    Result := 3240
  Else If strUnidade = 'LA' Then
    Result := 16200;
end;

end.

