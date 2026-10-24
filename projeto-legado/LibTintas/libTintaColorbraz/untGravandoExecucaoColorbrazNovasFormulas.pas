{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Colorbraz *}
{*******************************************************************************PH*}
unit untGravandoExecucaoColorbrazNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoColorbrazNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fFatorUnidade(fltUniOri: Double; fltUniAtu: Double): Double;
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

{ TGravandoExecucaoColorbrazNovasFormulas }

constructor TGravandoExecucaoColorbrazNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoColorbrazNovasFormulas.Executar(const gravando: IGravando);
Var
  qryCadNfm, qryBases, qryCadCLB: IDataSet;
  intContador: Integer;
  fltFator: Double;
begin
  Try
    Try
      Gravando.Texto := 'Carregando Dados...';

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCLB := TAutcomTintaFactory.Get.fGetDataSet;
      qryBases  := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '  SELECT  * FROM CLB_CADNFM       ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      Gravando.Texto := 'Deletando Novas Fórmulas cadastradas...';
      qryCadNfm.Open;
      RemoverNovasFormulas();
      Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

      qryCadCLB.Close;
      qryCadCLB.SQL := '    SELECT * FROM CLB_CADCLB WHERE FALSE      ';
      qryCadCLB.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CLB_CADCLB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      While Not qryCadNfm.Eof Do
      Begin

        qryBases.Close;
        qryBases.SQL := '';
        qryBases.SQL := qryBases.SQL + '  SELECT              ';
        qryBases.SQL := qryBases.SQL + '    *                 ';
        qryBases.SQL := qryBases.SQL + '  FROM                ';
        qryBases.SQL := qryBases.SQL + '    CLB_CADBAS        ';
        qryBases.SQL := qryBases.SQL + '  INNER JOIN CADITE ON        ';
        qryBases.SQL := qryBases.SQL + '    BAS_CODITE = ITE_CODITE         ';
        qryBases.SQL := qryBases.SQL + '  WHERE BAS_CODBAS = :CODBAS              ';
        qryBases.SQL := qryBases.SQL + '    AND BAS_PRODUT = :PRODUT              ';

        qryBases.SQL := qryBases.SQL + fGerarUnidadesSQL(blnGerarUnidades);
        qryBases.SQL := qryBases.SQL + fGerarUnidadeSQL(blnGerarUnidades, strUnidadeMenor, blnAtualizarUnidade);
        qryBases.SQL := qryBases.SQL + fGeraTodasUnidades(strCodNfm, qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If fGeraUnidade(blnGerarUnidades, strUnidadeMenor, blnAtualizarUnidade) Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;

        While Not qryBases.Eof Do
        Begin
          qryCadCLB.Insert;
          qryCadCLB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CLB_CADCLB', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCLB.FieldByName('CLB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCLB.FieldByName('CLB_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadCLB.FieldByName('CLB_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadCLB.FieldByName('CLB_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadCLB.FieldByName('CLB_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadCLB.FieldByName('CLB_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
          qryCadCLB.FieldByName('CLB_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadCLB.FieldByName('CLB_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadCLB.FieldByName('CLB_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          fltFator := fFatorUnidade(qryCadNfm.FieldByName('NFM_CONTEU').AsFloat, qryBases.FieldByName('BAS_CONTEU').AsFloat);

          For IntContador := 1 To 20 Do
          Begin
            qryCadCLB.FieldByName('CLB_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadCLB.FieldByName('CLB_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
          End;

          qryCadCLB.FieldByName('CLB_MD5KEY').AsString := GetMD5(qryCadCLB.FieldByName('CLB_CODIGO').AsString +
                                                                 qryCadCLB.FieldByName('CLB_CODBAS').AsString +
                                                                 qryCadCLB.FieldByName('CLB_NOMCOR').AsString +
                                                                 qryCadCLB.FieldByName('CLB_PRODUT').AsString +
                                                                 qryCadCLB.FieldByName('CLB_UNIDAD').AsString);
          qryCadCLB.Post;
          qryBases.Next;
        End;
        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;


    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally

  End;
end;

function TGravandoExecucaoColorbrazNovasFormulas.fFatorUnidade(fltUniOri,
  fltUniAtu: Double): Double;
begin
  Result := fltUniAtu / fltUniOri;
end;

function TGravandoExecucaoColorbrazNovasFormulas.fGerarUnidadeSQL(
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

function TGravandoExecucaoColorbrazNovasFormulas.fGerarUnidadesSQL(
  blnGerarUnidades: Boolean): String;
begin
  Result := '';

  If Not blnGerarUnidades Then
    Result := ' AND BAS_UNIDAD = :CODUNI  ';
end;

function TGravandoExecucaoColorbrazNovasFormulas.fGeraTodasUnidades(strCodNfm,
  strUnidade: String): String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    Result := fGetUnidadesGeracaoCadNfm(strUnidade);
end;

function TGravandoExecucaoColorbrazNovasFormulas.fGeraUnidade(
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

function TGravandoExecucaoColorbrazNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoColorbrazNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoColorbrazNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoColorbrazNovasFormulas.RemoverNovasFormulas;
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
          '   CLB_CADCLB        ' +
          ' WHERE CLB_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     CLB_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   CLB_CADCLB        ' +
          ' WHERE CLB_CODIGO =  ' + QuotedStr(strCodNfm) + ' ';
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
