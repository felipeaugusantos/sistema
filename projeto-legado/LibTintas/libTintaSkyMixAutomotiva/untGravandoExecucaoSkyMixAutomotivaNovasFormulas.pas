{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta SkyMixAutomotiva *}
{********************************************************************************AC*}
unit untGravandoExecucaoSkyMixAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoSkyMixAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    function fRetornaVariante(strAnuancia:String):String;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoSkyMixAutomotivaNovasFormulas }

constructor TGravandoExecucaoSkyMixAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoSkyMixAutomotivaNovasFormulas.Executar(const gravando: IGravando);
Var
  qryCadNfm: IDataSet;
  qrySkyMix: IDataSet;
  qryDelete: IDataSet;
  fltFator: Double;
  intContador: Integer;
  strTipoDil:String;
begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qrySkyMix := TAutcomTintaFactory.Get.fGetDataSet;

  qryCadNfm.SQL := '    SELECT * FROM SKY_CADNFM    ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
  End;

  qryCadNfm.Open;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SKY_CADSKY');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  qrySkyMix.SQL.Empty;
  qrySkyMix.SQL := '    SELECT * FROM SKY_CADSKY WHERE FALSE    ';
  qrySkyMix.Open;

  While Not qryCadNfm.Eof Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
    qryDelete.SQL := '    DELETE FROM SKY_CADSKY WHERE SKY_CODNFM = :CODNFM  ';

    If Not TStrUtils.fEmptyStr(strCodNfm) Then
      qryDelete.ParamByName('CODNFM').AsString := strCodNfm
    Else
      qryDelete.ParamByName('CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;

    qryDelete.ExecSQL;

    qrySkyMix.Insert;
    qrySkyMix.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SKY_CADSKY', TAutcomTintaFactory.Get.GetCodEmp);
    qrySkyMix.FieldByName('SKY_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qrySkyMix.FieldByName('SKY_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qrySkyMix.FieldByName('SKY_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qrySkyMix.FieldByName('SKY_ANOFAB').AsString := qryCadNfm.FieldByName('NFM_ANOFAB').AsString;
    qrySkyMix.FieldByName('SKY_CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;
    qrySkyMix.FieldByName('SKY_ANUANC').AsString := qryCadNfm.FieldByName('NFM_ANUANC').AsString;
    qrySkyMix.FieldByName('SKY_CORPAI').AsString := qryCadNfm.FieldByName('NFM_CORPAI').AsString;
    qrySkyMix.FieldByName('SKY_NACIMP').AsString := qryCadNfm.FieldByName('NFM_NACIMP').AsString;
    qrySkyMix.FieldByName('SKY_CODMON').AsString := qryCadNfm.FieldByName('NFM_CODMON').AsString;
    qrySkyMix.FieldByName('SKY_CODGRU').AsString := qryCadNfm.FieldByName('NFM_CODGRU').AsString;
    qrySkyMix.FieldByName('SKY_CODSGR').AsString := qryCadNfm.FieldByName('NFM_CODSGR').AsString;
    qrySkyMix.FieldByName('SKY_CONDIL').AsString := qryCadNfm.FieldByName('NFM_CONDIL').AsString;
    qrySkyMix.FieldByName('SKY_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
    qrySkyMix.FieldByName('SKY_VARIAN').AsString := fRetornaVariante(qryCadNfm.FieldByName('NFM_ANUANC').AsString);
    qrySkyMix.FieldByName('SKY_OBS001').AsString := qryCadNfm.FieldByName('NFM_OBS001').AsString;
    qrySkyMix.FieldByName('SKY_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
    qrySkyMix.FieldByName('SKY_VERSAO').AsString := '1';
    qrySkyMix.FieldByName('SKY_ACRMOB').AsString := qryCadNfm.FieldByName('NFM_ACRMOB').AsString;
    qrySkyMix.FieldByName('SKY_CODNFM').AsString := qrySkyMix.FieldByName('SKY_CODPRO').AsString;


    If qryCadNfm.FieldByName('NFM_CONDIL').AsString = 'DILUIDO' Then
      strTipoDil := 'D';

    fltFator := 1;

    For intContador := 1 To 20 Do
    Begin

      If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      qrySkyMix.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);


      If Not TStrUtils.fEmptyStr(strTipoDil) Then
        qrySkyMix.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador,2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB'  + TStrUtils.fStrZero(intContador,2)).AsFloat * fltFator
      Else
        qrySkyMix.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    End;

    strTipoDil := '';

    qrySkyMix.FieldByName('SKY_MD5KEY').AsString := GetMD5(qrySkyMix.FieldByName('SKY_CODPRO').AsString +
                                                           qrySkyMix.FieldByName('SKY_DESCRI').AsString +
                                                           qrySkyMix.FieldByName('SKY_ANOFAB').AsString +
                                                           qrySkyMix.FieldByName('SKY_ANUANC').AsString +
                                                           qrySkyMix.FieldByName('SKY_CORPAI').AsString +
                                                           qrySkyMix.FieldByName('SKY_NACIMP').AsString +
                                                           qrySkyMix.FieldByName('SKY_CODMON').AsString +
                                                           qrySkyMix.FieldByName('SKY_CODGRU').AsString +
                                                           qrySkyMix.FieldByName('SKY_CODSGR').AsString +
                                                           qrySkyMix.FieldByName('SKY_VERSAO').AsString);

    qrySkyMix.Post;
    qryCadNfm.Next;
    Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);


  End;
end;

function TGravandoExecucaoSkyMixAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoSkyMixAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSkyMixAutomotivaNovasFormulas.fRetornaVariante(
  strAnuancia: String): String;
  Function fCodigoVariantesCores(strCodigo:String):String;
  begin
    Result := '';

    If strCodigo = 'A' Then
     Result := 'Principal'
    Else If strCodigo = 'T' Then
      Result := 'Tri-Coat'
    Else If strCodigo = 'B' Then
      Result := 'Mais Clara'
    Else If strCodigo = 'C' Then
      Result := 'Mais Escura'
    Else If strCodigo = 'D' Then
      Result := 'Mais Azul'
    Else If strCodigo = 'E' Then
      Result := 'Mais Amarelo'
    Else If strCodigo = 'F' Then
      Result := 'Mais Verde'
    Else If strCodigo = 'G' Then
      Result := 'Mais Vermelho'
    ELse If strCodigo = 'H' Then
      Result := 'Mais Fino'
    Else If strCodigo = 'I' Then
      Result := 'Mais Graúdo'
    Else If strCodigo = 'J' Then
      Result := 'Frente'
    Else If strCodigo = 'K' Then
      Result := 'Alumínio'
    Else If strCodigo = 'W' Then
      Result := 'Limpo'
    Else If strCodigo =  'X' Then
      Result := 'Sujo'
    Else If strCodigo = 'Y' Then
      Result := 'Leitoso'
    Else If strCodigo = 'Z' Then
      Result := 'No Ângulo';
  end;
Var
  intContador:Integer;
Begin
  Result := '';
  If Not TStrUtils.fEmptyStr(strAnuancia) Then
    For intContador := 1 To Length(strAnuancia) Do
    Begin
      If TStrUtils.fEmptyStr(Result) Then
        Result := fCodigoVariantesCores(Copy(strAnuancia, intContador, 1))
      Else
        Result := Result + ' e ' + fCodigoVariantesCores(Copy(strAnuancia, intContador, 1));
    End;
End;

end.
