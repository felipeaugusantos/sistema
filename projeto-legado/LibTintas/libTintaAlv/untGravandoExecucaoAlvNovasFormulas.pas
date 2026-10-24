{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Alv *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAlvNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoAlvNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fGetUnidadesGeracaoCadNfm(strUnidade:String): String;
    function fRetPesoUnidade(fltBasEmb: Double; fltBasNfm: Double): Double;
    function fGerarUnidadesSQL(blnGerarUnidades: Boolean): String;
    function fGerarUnidadeSQL(blnGerarUnidades: Boolean; strUnidadeMenor: String; blnAtualizar: Boolean): String;
    function fGeraUnidade(blnGerarUnidades: Boolean; strUnidadeMenor: String; blnAtualizar: Boolean): Boolean;
    function fGeraTodasUnidades(strCodNfm: String; strUnidade: String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoAlvNovasFormulas }

constructor TGravandoExecucaoAlvNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoAlvNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadGlo: IDataSet;
  qryBases: IDataSet;
  intCont: Integer;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm.SQL := '    SELECT * FROM ALV_CADNFM    ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);



  Gravando.Texto := 'Deletando Novas Fórmulas cadastradas...';
  qryCadNfm.Open;
  RemoverNovasFormulas();
  Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('ALV_CADALV');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadGlo := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadGlo.SQL := '    SELECT * FROM ALV_CADALV WHERE FALSE    ';
  qryCadGlo.Open;

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT  * FROM ALV_CADBAS          ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '     WHERE BAS_CODBAS = :BASE   AND     ' +
                        '     BAS_PRODUT = :PRODUT             ' ;

        qryBases.SQL := qryBases.SQL + fGerarUnidadesSQL(blnGerarUnidades);
        qryBases.SQL := qryBases.SQL + fGerarUnidadeSQL(blnGerarUnidades, strUnidadeMenor, blnAtualizarUnidade);
        qryBases.SQL := qryBases.SQL + fGeraTodasUnidades(strCodNfm, qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('BASE').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If fGeraUnidade(blnGerarUnidades, strUnidadeMenor, blnAtualizarUnidade) Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin
          qryCadGlo.Insert;
          qryCadGlo.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALV_CADALV', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadGlo.FieldByName('ALV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadGlo.FieldByName('ALV_DESCOR').AsString := qryCadNfm.FieldByName('NFM_DESCOR').AsString;
          qryCadGlo.FieldByName('ALV_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadGlo.FieldByName('ALV_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadGlo.FieldByName('ALV_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadGlo.FieldByName('ALV_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadGlo.FieldByName('ALV_SISTEM').AsString := 'PERSONALIZADAS';
          qryCadGlo.FieldByName('ALV_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadGlo.FieldByName('ALV_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadGlo.FieldByName('ALV_VOLUME').AsFloat  := qryBases.FieldByName('BAS_EMBALA').AsFloat;
          qryCadGlo.FieldByName('ALV_DTACAD').AsDate  := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

          For intCont := 1 To 20 Do
          Begin
            qryCadGlo.FieldByName('ALV_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

            qryCadGlo.FieldByName('ALV_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_EMBALA').AsFloat,
                                                                                                           qryCadNfm.FieldByName('NFM_EMBALA').AsFloat);
          End;

          qryCadGlo.FieldByName('ALV_MD5KEY').AsString := GetMd5(qryCadGlo.FieldByName('ALV_CODIGO').AsString +
                                                                 qryCadGlo.FieldByName('ALV_DESCOR').AsString +
                                                                 qryCadGlo.FieldByName('ALV_CODBAS').AsString +
                                                                 qryCadGlo.FieldByName('ALV_PRODUT').AsString +
                                                                 qryCadGlo.FieldByName('ALV_UNIDAD').AsString +
                                                                 qryCadGlo.FieldByName('ALV_SISTEM').AsString +
                                                                 FloatToStr(qryCadGlo.FieldByName('ALV_VOLUME').AsFloat));
          qryCadGlo.Post;
          qryBases.Next;
        End;
        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Novas Fórmulas processado com sucesso...';
  End;

End;

function TGravandoExecucaoAlvNovasFormulas.fGerarUnidadeSQL(
  blnGerarUnidades: Boolean; strUnidadeMenor: String;
  blnAtualizar: Boolean): String;
begin
  Result := '';

  If Not blnAtualizar Then
  Begin
    If Not TStrUtils.fEmptyStr(strUnidadeMenor) Then
    Begin
      If blnGerarUnidades Then
        Result := ' AND BAS_UNIDAD <> :CODUNI ';
    End;
  End;
end;

function TGravandoExecucaoAlvNovasFormulas.fGerarUnidadesSQL(
  blnGerarUnidades: Boolean): String;
begin
  Result := '';

  If Not blnGerarUnidades Then
    Result := ' AND BAS_UNIDAD = :CODUNI  ';
end;

function TGravandoExecucaoAlvNovasFormulas.fGeraTodasUnidades(strCodNfm,
  strUnidade: String): String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    Result := fGetUnidadesGeracaoCadNfm(strUnidade);
end;

function TGravandoExecucaoAlvNovasFormulas.fGeraUnidade(
  blnGerarUnidades: Boolean; strUnidadeMenor: String;
  blnAtualizar: Boolean): Boolean;
begin
  Result := False;

  If Not blnAtualizar Then
  Begin
    If Not TStrUtils.fEmptyStr(strUnidadeMenor) Then
    Begin
      If blnGerarUnidades Then
        Result := True;
    End;
  End;
end;

function TGravandoExecucaoAlvNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoAlvNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoAlvNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAlvNovasFormulas.fRetPesoUnidade(fltBasEmb,
  fltBasNfm: Double): Double;
begin
  Result := fltBasEmb / fltBasNfm;
end;

procedure TGravandoExecucaoAlvNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   ALV_CADALV        ' +
          ' WHERE ALV_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     ALV_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE ALV_CADALV   ' +
          ' FROM                ' +
          '   ALV_CADALV JOIN ALV_CADNFM ON ALV_CADNFM.NFM_CODNFM = ALV_CADALV.ALV_CODIGO  ' +
          ' WHERE NFM_CODNFM =  ' + QuotedStr(strCodNfm);
      end;

      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

end.
