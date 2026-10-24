{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Bautech *}
{*******************************************************************************PH*}
unit untGravandoExecucaoBautechNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoBautechNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function TemVolumeEspecifico(const qryCadNfm: IDataSet; const qryVolumeEspecifico: IDataSet): Boolean;
    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fRetProdutoBautech(strProdut: String): String;
//    function fBaseProduto(strCodBas, strCodUni: String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    function fHabilitaOpcao(): Boolean;
    procedure Executar(const gravando: IGravando);
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoBautechNovasFormulas }

constructor TGravandoExecucaoBautechNovasFormulas.Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoBautechNovasFormulas.Executar(const gravando: IGravando);
//const
//  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
//  arrPesos: array[0..2] of Double = (1, 4, 20);
var
  qryCadNfm          : IDataSet;
  qryCadBAU          : IDataSet;
  qryBases           : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont            : Integer;
//  intUnidade         : Integer;
  fltFatorEspecifico : Double;
  strMd5             : String;
begin


  Try
    Try

      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM BAU_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadBAU := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BAU_CADBAU');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI,             ' +
                        '        BAS_DESCRI              ' +
                        '   FROM BAU_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_DESCRI LIKE :DESCRI ' +
                        '    AND BAS_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAU_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAU_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('DESCRI').AsString := '%' + fRetProdutoBautech(qryCadNfm.FieldByName('NFM_PRODUT').AsString) + '%';
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            if TemVolumeEspecifico(qryCadNfm, qryVolumeEspecifico) then
            begin
              fltFatorEspecifico := qryVolumeEspecifico.FieldByName('NFM_VOLUME').AsFloat;
              while not qryVolumeEspecifico.Eof do
              begin
                Try
                  Try
                    qryCadBAU.SQL := TAutcomTintaFactory.Get.GetInsert('BAU_CADBAU');

                    qryCadBAU.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BAU_CADBAU',
                                                                      TAutcomTintaFactory.Get.GetCodEmp);

                    qryCadBAU.ParamByName('BAU_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                    qryCadBAU.ParamByName('BAU_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                    qryCadBAU.ParamByName('BAU_PRODUT').AsString := qryBases.FieldByName('BAS_DESCRI').AsString;
                    qryCadBAU.ParamByName('BAU_UNIDAD').AsString := qryVolumeEspecifico.FieldByName('NFM_UNIDAD').AsString;
                    qryCadBAU.ParamByName('BAU_PREVEN').AsFloat  := 0;
                    qryCadBAU.ParamByName('BAU_PRECUS').AsFloat  := 0;
                    qryCadBAU.ParamByName('BAU_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
                    qryCadBAU.ParamByName('BAU_CODUNI').AsString := qryVolumeEspecifico.FieldByName('NFM_UNIDAD').AsString;
                    qryCadBAU.ParamByName('BAU_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                    qryCadBAU.ParamByName('BAU_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
                    qryCadBAU.ParamByName('BAU_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DATCAD').AsDate;
                    qryCadBAU.ParamByName('BAU_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                    strMd5 := '';
                    strMd5 := strMd5 + qryCadBau.ParamByName('BAU_CODBAS').AsString;
                    strMd5 := strMd5 + qryCadBau.ParamByName('BAU_PRODUT').AsString;
                    strMd5 := strMd5 + qryCadBau.ParamByName('BAU_CODUNI').AsString;
                    strMd5 := strMd5 + qryCadBau.ParamByName('BAU_DESCRI').AsString;
                    strMd5 := strMd5 + qryCadBau.ParamByName('BAU_NOMCOR').AsString;

                    for intCont := 1 to 20 do
                    begin
                      if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                        Break;

                      if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                        Break;

                      qryCadBAU.ParamByName('BAU_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                      qryCadBAU.ParamByName('BAU_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                        qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
                        qryVolumeEspecifico.FieldByName('NFM_VOLUME').AsFloat / fltFatorEspecifico;

                      strMd5 := strMd5 + qryCadBAU.ParamByName('BAU_FORM' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
                      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryCadBAU.ParamByName('BAU_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
                        ',', '.', [rfReplaceAll]);
                    end;

                    qryCadBAU.ParamByName('BAU_MD5KEY').AsString := GetMD5(strMd5);

                    qryCadBAU.ExecSQL;
                  Except
                    on E: Exception do
                    begin
                      gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
                    end;
                  End;
                Finally
                  qryVolumeEspecifico.Next;
                End;
              end;
            end
            else
            begin
              qryBases.First;
              While Not qryBases.Eof Do
              Begin
//              for intUnidade := 0 to 2 do
//              begin
                qryCadBAU.SQL := TAutcomTintaFactory.Get.GetInsert('BAU_CADBAU');

                qryCadBAU.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BAU_CADBAU',
                                                                  TAutcomTintaFactory.Get.GetCodEmp);

                qryCadBAU.ParamByName('BAU_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadBAU.ParamByName('BAU_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                qryCadBAU.ParamByName('BAU_PRODUT').AsString := qryBases.FieldByName('BAS_DESCRI').AsString;
                qryCadBAU.ParamByName('BAU_UNIDAD').AsString := qryBases.FieldByName('BAS_CODUNI').AsString; //arrUnidades[intUnidade];
                qryCadBAU.ParamByName('BAU_PREVEN').AsFloat  := 0;
                qryCadBAU.ParamByName('BAU_PRECUS').AsFloat  := 0;
                qryCadBAU.ParamByName('BAU_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
                qryCadBAU.ParamByName('BAU_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString; //arrUnidades[intUnidade];
                qryCadBAU.ParamByName('BAU_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                qryCadBAU.ParamByName('BAU_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
                qryCadBAU.ParamByName('BAU_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
                qryCadBAU.ParamByName('BAU_ACRMOB').AsFloat := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                strMd5 := '';
                strMd5 := strMd5 + qryCadBau.ParamByName('BAU_CODBAS').AsString;
                strMd5 := strMd5 + qryCadBau.ParamByName('BAU_PRODUT').AsString;
                strMd5 := strMd5 + qryCadBau.ParamByName('BAU_CODUNI').AsString;
                strMd5 := strMd5 + qryCadBau.ParamByName('BAU_DESCRI').AsString;
                strMd5 := strMd5 + qryCadBau.ParamByName('BAU_NOMCOR').AsString;

                for intCont := 1 to 20 do
                begin
                  if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                    Break;

                  if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                    Break;

                  qryCadBAU.ParamByName('BAU_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString :=
                    qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString;

                  qryCadBAU.ParamByName('BAU_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                    qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString, qryBases.RecordCount, qryCadNfm.FieldByName('NFM_UNIDAD').AsString); //arrPesos[intUnidade];

                  strMd5 := strMd5 + qryCadBAU.ParamByName('BAU_FORM' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
                  strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryCadBAU.ParamByName('BAU_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
                    ',', '.', [rfReplaceAll]);
                end;

                qryCadBAU.ParamByName('BAU_MD5KEY').AsString := GetMD5(strMd5);

                qryCadBAU.ExecSQL;

                if not (blnGerarUnidades) then
                  Break;
              //end;
                qryBases.Next;
              End;
            end;
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

{function TGravandoExecucaoBautechNovasFormulas.fBaseProduto(strCodBas,
  strCodUni: String): String;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT BAS_DESCRI ' +
                  '   FROM BAU_CADBAS ' +
                  '  WHERE BAS_CODBAS = :CODBAS ' +
                  '    AND BAS_CODUNI = :CODUNI ';

    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.ParamByName('CODUNI').AsString := strCodUni;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_DESCRI').AsString;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;
 }
function TGravandoExecucaoBautechNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoBautechNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoBautechNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoBautechNovasFormulas.fRetProdutoBautech(strProdut: String): String;
begin
  Result := strProdut;

  If Pos('3,2', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('3,2', strProdut) - 1)
  Else If Pos('16,2', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('16,2', strProdut) - 1)
  Else If Pos('810', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('810', strProdut) - 1);
end;

function TGravandoExecucaoBautechNovasFormulas.fRetPesoUnidade(
  strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
begin
  Result := 1;
  If intRegistros = 3 Then
  Begin
    If Pos(strCodUni, 'LT_QT_') > 0 Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If strCodUni = 'LA' Then
      Result := 20;
  End
  Else If intRegistros = 2 Then
  Begin
    If strCodUni = 'LT' Then
      Result := 1
    Else If (strCodUni = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If (strCodUni = 'LA') And (strUniOri = 'LT') Then
      Result := 20
    Else If strCodUni = 'LA' Then
      Result := 5;
  End;
end;

procedure TGravandoExecucaoBautechNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   BAU_CADBAU                  ' +
          ' WHERE LEFT(BAU_NOMCOR, 12) IN ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     BAU_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   BAU_CADBAU                           ' +
          ' WHERE LEFT(BAU_NOMCOR, 12) IN          ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     BAU_CADNFM                         ' +
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

function TGravandoExecucaoBautechNovasFormulas.TemVolumeEspecifico(const qryCadNfm: IDataSet; const qryVolumeEspecifico: IDataSet): Boolean;
begin
  Result := False;
  Try
    Try
        
      qryVolumeEspecifico.Close;
      qryVolumeEspecifico.SQL :=
        ' SELECT                         ' +
        '   *                            ' +
        ' FROM                           ' +
        '   BAU_NFMEMB                   ' +
        ' WHERE NFM_CODNFM = :NFM_CODNFM ' +
        '   AND NFM_CODBAS = :NFM_CODBAS ' +
        '   AND NFM_VOLUME > 0           ' +
        ' ORDER BY NFM_VOLUME            ';

      qryVolumeEspecifico.ParamByName('NFM_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
      qryVolumeEspecifico.ParamByName('NFM_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
      qryVolumeEspecifico.Open;
      qryVolumeEspecifico.First;

      Result := qryVolumeEspecifico.RecordCount > 0;
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
