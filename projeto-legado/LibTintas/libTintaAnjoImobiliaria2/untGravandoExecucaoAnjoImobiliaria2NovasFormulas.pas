{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta AnjoImobiliaria2 *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAnjoImobiliaria2NovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoAnjoImobiliaria2NovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoAnjoImobiliaria2NovasFormulas }

constructor TGravandoExecucaoAnjoImobiliaria2NovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoAnjoImobiliaria2NovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadGlo: IDataSet;
  qryBases: IDataSet;
  intCont: Integer;
  strMd5: String;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm.SQL := '    SELECT * FROM AN2_CADNFM    ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);



  Gravando.Texto := 'Deletando Novas Fórmulas cadastradas...';
  qryCadNfm.Open;
  RemoverNovasFormulas();
  Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('AN2_CADAN2');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadGlo := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadGlo.SQL := '    SELECT * FROM AN2_CADAN2 WHERE FALSE    ';
  qryCadGlo.Open;

  Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT  * FROM AN2_CADBAS          ' +
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

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin
          qryCadGlo.Insert;
          qryCadGlo.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AN2_CADAN2', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadGlo.FieldByName('AN2_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadGlo.FieldByName('AN2_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
          qryCadGlo.FieldByName('AN2_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadGlo.FieldByName('AN2_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadGlo.FieldByName('AN2_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadGlo.FieldByName('AN2_COLECA').AsString := qryCadNfm.FieldByName('NFM_COLECA').AsString;
          qryCadGlo.FieldByName('AN2_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadGlo.FieldByName('AN2_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadGlo.FieldByName('AN2_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadGlo.FieldByName('AN2_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

          strMd5 := '';
          strMd5 := strMd5 + qryCadGlo.FieldByName('AN2_CODIGO').AsString +
                             qryCadGlo.FieldByName('AN2_NOMCOR').AsString +
                             qryCadGlo.FieldByName('AN2_CODBAS').AsString +
                             qryCadGlo.FieldByName('AN2_PRODUT').AsString +
                             qryCadGlo.FieldByName('AN2_UNIDAD').AsString +
                             qryCadGlo.FieldByName('AN2_COLECA').AsString;

          For intCont := 1 To 20 Do
          Begin
            qryCadGlo.FieldByName('AN2_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

            qryCadGlo.FieldByName('AN2_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_EMBALA').AsFloat,
                                                                                                           qryCadNfm.FieldByName('NFM_EMBALA').AsFloat);

            strMd5 := strMd5 + qryCadGlo.FieldByName('AN2_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString;
            strMd5 := strMd5 + qryCadGlo.FieldByName('AN2_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsString;
          End;

          qryCadGlo.FieldByName('AN2_MD5KEY').AsString := GetMd5(strMd5);

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

function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fGerarUnidadeSQL(
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

function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fGerarUnidadesSQL(
  blnGerarUnidades: Boolean): String;
begin
  Result := '';

  If Not blnGerarUnidades Then
    Result := ' AND BAS_UNIDAD = :CODUNI  ';
end;

function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fGeraTodasUnidades(strCodNfm,
  strUnidade: String): String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    Result := fGetUnidadesGeracaoCadNfm(strUnidade);
end;

function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fGeraUnidade(
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

function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA","BD") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD IN ("LA","BD") '
  Else If strUnidade = 'BD' Then
    Result := ' AND BAS_UNIDAD = "BD" ';
end;

function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAnjoImobiliaria2NovasFormulas.fRetPesoUnidade(fltBasEmb,
  fltBasNfm: Double): Double;
begin
  Result := fltBasEmb / fltBasNfm;
end;

procedure TGravandoExecucaoAnjoImobiliaria2NovasFormulas.RemoverNovasFormulas;
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
          '   AN2_CADAN2        ' +
          ' WHERE AN2_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODIGO      ' +
          '   FROM              ' +
          '     AN2_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   AN2_CADAN2        ' +
          ' WHERE AN2_CODIGO =  ' + QuotedStr(strCodNfm) + ' ';
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
