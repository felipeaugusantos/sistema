{**********************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Velutex Imobiliaria *}
{*******************************************************************************************PH*}
unit untGravandoExecucaoVelutexImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, untIConfTinta;

type
  TGravandoExecucaoVelutexImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    conf: IConfTinta;

    procedure RemoverNovasFormulas();
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    function fRetornaFator(strUnidade, strProduto, strUniOri:String; intRegistro: Integer):Double;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoVelutexImobiliariaNovasFormulas }

constructor TGravandoExecucaoVelutexImobiliariaNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('VEL');
end;

procedure TGravandoExecucaoVelutexImobiliariaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadVel: IDataSet;
  qryBases : IDataSet;
  fltFator : Double;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM VEL_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadVel := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('VEL_CADVEL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '   FROM VEL_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT = :PRODUT    ' +
                        '    AND BAS_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin
              qryCadVel.SQL := TAutcomTintaFactory.Get.GetInsert('VEL_CADVEL');

              qryCadVel.ParamByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('VEL_CADVEL', qryCadNfm.FieldByName('NFM_CODEMP').AsString);
              qryCadVel.ParamByName('VEL_CODEMP').AsString  := qryCadNfm.FieldByName('NFM_CODEMP').AsString;
              qryCadVel.ParamByName('VEL_CORCOD').AsString  := qryCadNfm.FieldByName('NFM_CORCOD').AsString;
              qryCadVel.ParamByName('VEL_CODBAS').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODBAS').AsString);
              qryCadVel.ParamByName('VEL_COLECA').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_COLECA').AsString);
              qryCadVel.ParamByName('VEL_PRODUT').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_PRODUT').AsString);
              qryCadVel.ParamByName('VEL_DTACAD').AsDateTime:= qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadVel.ParamByName('VEL_CODUNI').AsString  := AnsiUpperCase(qryBases.FieldByName('BAS_CODUNI').AsString);
              qryCadVel.ParamByName('VEL_NOTA__').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_NOTA__').AsString);
              qryCadVel.ParamByName('VEL_CODNOM').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODNOM').AsString);
              qryCadVel.ParamByName('VEL_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;


              fltFator := fRetornaFator(qryCadVel.ParamByName('VEL_CODUNI').AsString, qryCadVel.ParamByName('VEL_PRODUT').AsString, qryCadNfm.FieldByName('NFM_CODUNI').AsString,
                                        qryBases.RecordCount);



              For intCont := 1 To 20 Do
              Begin


                If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString)) Then
                  Break;

                qryCadVel.ParamByName('VEL_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString);
                qryCadVel.ParamByName('VEL_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
                  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
              End;

              qryCadVel.ParamByName('VEL_CODNFM').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
              qryCadVel.ParamByName('VEL_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
              qryCadVel.ParamByName('VEL_MD5KEY').AsString := GetMD5(qryCadVel.ParamByName('VEL_CORCOD').AsString +
                                                                     qryCadVel.ParamByName('VEL_CODBAS').AsString +
                                                                     qryCadVel.ParamByName('VEL_COLECA').AsString +
                                                                     qryCadVel.ParamByName('VEL_PRODUT').AsString +
                                                                     qryCadVel.ParamByName('VEL_CODUNI').AsString +
                                                                     qryCadVel.ParamByName('VEL_CODNOM').AsString);


              qryCadVel.ExecSQL;

              if not (blnGerarUnidades) then
                Break;

              qryBases.Next;
            End;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryCadNfm.Next;
          gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoVelutexImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Novas Fórmulas';
end;
function TGravandoExecucaoVelutexImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoVelutexImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoVelutexImobiliariaNovasFormulas.fRetornaFator(
  strUnidade, strProduto, strUniOri: String; intRegistro: Integer): Double;
begin
  Result := 1;
  If (Pos(strProduto, 'GRAFIATO RUSTICO_TEXTURATTO RUSTICO_CRISTAL MEDIO_GRALITE MEDIO') > 0)  And (intRegistro <> 1) Then
  Begin
    If strUnidade = 'LT' Then
      Result := 1
    Else If strUnidade = 'GL' Then
      Result := 4
    Else
      Result := 28.39;
  End
  Else If intRegistro = 2 Then
  Begin
    If strUnidade = 'LT'  Then
      Result := 1
    Else If (strUnidade = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strUnidade = 'GL' Then
      Result := 4
    Else If (strUnidade = 'LA') And (strUniOri = 'LT') Then
      Result := 20
    Else If strUnidade = 'LA' Then
      Result := 5;
  End
  Else If intRegistro = 3 Then
  Begin
    If Pos(strUnidade, 'LT_QT_') > 0 Then
      Result := 1
    Else If strUnidade = 'GL' Then
      Result := 4
    Else If strUnidade = 'LA' Then
      Result := 20;
  End;
end;

{function TGravandoExecucaoVelutexImobiliariaNovasFormulas.fRetFatorUnidade(
  strUnidade: String): Double;
begin
  Result := 1;
  If (strUnidade = conf.fGet('VELGAL')) Then
    Result := 3.6
  Else If (strUnidade = conf.fGet('VELQUA')) Then
    Result := 0.9
  Else If (strUnidade = conf.fGet('VELLAT')) Then
    Result := 18;
end;}

procedure TGravandoExecucaoVelutexImobiliariaNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE               ' +
          ' FROM                 ' +
          '   VEL_CADVEL         ' +
          ' WHERE VEL_CODNFM IN  ' +
          '   (SELECT            ' +
          '     NFM_CODNFM       ' +
          '   FROM               ' +
          '     VEL_CADNFM)      ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE               ' +
          ' FROM                 ' +
          '   VEL_CADVEL         ' +
          ' WHERE VEL_CODNFM IN  ' +
          '   (SELECT            ' +
          '     NFM_CODNFM       ' +
          '   FROM               ' +
          '     VEL_CADNFM       ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
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
