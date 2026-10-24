{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta TexturaCia *}
{*******************************************************************************PH*}
unit untGravandoExecucaoTexturaCiaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoTexturaCiaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoTexturaCiaNovasFormulas }

constructor TGravandoExecucaoTexturaCiaNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoTexturaCiaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadGlo: IDataSet;
  qryBases: IDataSet;
  intCont: Integer;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm.SQL := '    SELECT * FROM TEX_CADNFM    ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);



  Gravando.Texto := 'Deletando Novas Fórmulas cadastradas...';
  qryCadNfm.Open;
  RemoverNovasFormulas();
  Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('TEX_CADTEX');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadGlo := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadGlo.SQL := '    SELECT * FROM TEX_CADTEX WHERE FALSE    ';
  qryCadGlo.Open;

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT  * FROM TEX_CADBAS          ' +
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
          qryCadGlo.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('TEX_CADTEX', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadGlo.FieldByName('TEX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadGlo.FieldByName('TEX_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadGlo.FieldByName('TEX_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadGlo.FieldByName('TEX_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadGlo.FieldByName('TEX_EMBALA').AsFloat  := qryBases.FieldByName('BAS_EMBALA').AsFloat;
          qryCadGlo.FieldByName('TEX_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadGlo.FieldByName('TEX_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadGlo.FieldByName('TEX_CATALO').AsString := qryCadNfm.FieldByName('NFM_CATALO').AsString;
          qryCadGlo.FieldByName('TEX_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
          qryCadGlo.FieldByName('TEX_INTENS').AsString := qryCadNfm.FieldByName('NFM_INTENS').AsString;
          qryCadGlo.FieldByName('TEX_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadGlo.FieldByName('TEX_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadGlo.FieldByName('TEX_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadGlo.FieldByName('TEX_DESEMB').AsString := qryBases.FieldByName('BAS_DESEMB').AsString;

          For intCont := 1 To 20 Do
          Begin
            qryCadGlo.FieldByName('TEX_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

            qryCadGlo.FieldByName('TEX_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_EMBALA').AsFloat,
                                                                                                           qryCadNfm.FieldByName('NFM_EMBALA').AsFloat);
          End;

          qryCadGlo.FieldByName('TEX_MD5KEY').AsString := GetMd5(qryCadGlo.FieldByName('TEX_CODIGO').AsString +
                                                                 qryCadGlo.FieldByName('TEX_DESCRI').AsString +
                                                                 qryCadGlo.FieldByName('TEX_CODBAS').AsString +
                                                                 qryCadGlo.FieldByName('TEX_PRODUT').AsString +
                                                                 qryCadGlo.FieldByName('TEX_UNIDAD').AsString +
                                                                 qryCadGlo.FieldByName('TEX_CATALO').AsString +
                                                                 qryCadGlo.FieldByName('TEX_INTENS').AsString +
                                                                 qryCadGlo.FieldByName('TEX_EMBALA').AsString);
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

function TGravandoExecucaoTexturaCiaNovasFormulas.fGerarUnidadeSQL(
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

function TGravandoExecucaoTexturaCiaNovasFormulas.fGerarUnidadesSQL(
  blnGerarUnidades: Boolean): String;
begin
  Result := '';

  If Not blnGerarUnidades Then
    Result := ' AND BAS_UNIDAD = :CODUNI  ';
end;

function TGravandoExecucaoTexturaCiaNovasFormulas.fGeraTodasUnidades(strCodNfm,
  strUnidade: String): String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    Result := fGetUnidadesGeracaoCadNfm(strUnidade);
end;

function TGravandoExecucaoTexturaCiaNovasFormulas.fGeraUnidade(
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

function TGravandoExecucaoTexturaCiaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoTexturaCiaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoTexturaCiaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoTexturaCiaNovasFormulas.fRetPesoUnidade(fltBasEmb,
  fltBasNfm: Double): Double;
begin
  Result := fltBasEmb / fltBasNfm;
end;

procedure TGravandoExecucaoTexturaCiaNovasFormulas.RemoverNovasFormulas;
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
          '   TEX_CADTEX        ' +
          ' WHERE TEX_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     TEX_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   TEX_CADTEX        ' +
          ' WHERE TEX_CODIGO =  ' + QuotedStr(strCodNfm) + ' ';
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
