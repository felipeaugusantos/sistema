{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Dacasa *}
{*******************************************************************************PH*}
unit untGravandoExecucaoDacasaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoDacasaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoDacasaNovasFormulas }

constructor TGravandoExecucaoDacasaNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoDacasaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadGlo: IDataSet;
  qryBases: IDataSet;
  intCont: Integer;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm.SQL := '    SELECT * FROM DCA_CADNFM    ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);



  Gravando.Texto := 'Deletando Novas Fórmulas cadastradas...';
  qryCadNfm.Open;
  RemoverNovasFormulas();
  Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('DCA_CADDCA');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadGlo := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadGlo.SQL := '    SELECT * FROM DCA_CADDCA WHERE FALSE    ';
  qryCadGlo.Open;

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT  * FROM DCA_CADBAS          ' +
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
          qryCadGlo.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DCA_CADDCA', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadGlo.FieldByName('DCA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadGlo.FieldByName('DCA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadGlo.FieldByName('DCA_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadGlo.FieldByName('DCA_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadGlo.FieldByName('DCA_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadGlo.FieldByName('DCA_COLECA').AsString := qryCadNfm.FieldByName('NFM_COLECA').AsString;
          qryCadGlo.FieldByName('DCA_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadGlo.FieldByName('DCA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadGlo.FieldByName('DCA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadGlo.FieldByName('DCA_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

          For intCont := 1 To 20 Do
          Begin
            qryCadGlo.FieldByName('DCA_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

            qryCadGlo.FieldByName('DCA_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_EMBALA').AsFloat,
                                                                                                           qryCadNfm.FieldByName('NFM_EMBALA').AsFloat);
          End;

          qryCadGlo.FieldByName('DCA_MD5KEY').AsString := GetMd5(qryCadGlo.FieldByName('DCA_CODIGO').AsString +
                                                                 qryCadGlo.FieldByName('DCA_NOMCOR').AsString +
                                                                 qryCadGlo.FieldByName('DCA_CODBAS').AsString +
                                                                 qryCadGlo.FieldByName('DCA_PRODUT').AsString +
                                                                 qryCadGlo.FieldByName('DCA_UNIDAD').AsString +
                                                                 qryCadGlo.FieldByName('DCA_COLECA').AsString);
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

function TGravandoExecucaoDacasaNovasFormulas.fGerarUnidadeSQL(
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

function TGravandoExecucaoDacasaNovasFormulas.fGerarUnidadesSQL(
  blnGerarUnidades: Boolean): String;
begin
  Result := '';

  If Not blnGerarUnidades Then
    Result := ' AND BAS_UNIDAD = :CODUNI  ';
end;

function TGravandoExecucaoDacasaNovasFormulas.fGeraTodasUnidades(strCodNfm,
  strUnidade: String): String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    Result := fGetUnidadesGeracaoCadNfm(strUnidade);
end;

function TGravandoExecucaoDacasaNovasFormulas.fGeraUnidade(
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

function TGravandoExecucaoDacasaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoDacasaNovasFormulas.fGetUnidadesGeracaoCadNfm(
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

function TGravandoExecucaoDacasaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoDacasaNovasFormulas.fRetPesoUnidade(fltBasEmb,
  fltBasNfm: Double): Double;
begin
  Result := fltBasEmb / fltBasNfm;
end;

procedure TGravandoExecucaoDacasaNovasFormulas.RemoverNovasFormulas;
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
          '   DCA_CADDCA        ' +
          ' WHERE DCA_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     DCA_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   DCA_CADDCA        ' +
          ' WHERE DCA_CODIGO =  ' + QuotedStr(strCodNfm) + ' ';
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
