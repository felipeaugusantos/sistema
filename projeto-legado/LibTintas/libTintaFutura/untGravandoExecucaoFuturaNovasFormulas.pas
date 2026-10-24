{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Futura *}
{*******************************************************************************PH*}
unit untGravandoExecucaoFuturaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants;

type
  TGravandoExecucaoFuturaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
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

{ TGravandoExecucaoFuturaNovasFormulas }

constructor TGravandoExecucaoFuturaNovasFormulas.Create(const strCodNfm: string = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoFuturaNovasFormulas.Executar(const gravando: IGravando);
//  Const
//    arrUnidades: Array[1..3] of String = ('QT', 'GL', 'LA');
//    arrFatores: Array[1..3] of Integer = (1, 4, 20);
var
  qryCadNfm: IDataSet;
  qryCadFUT: IDataSet;
  qryBases : IDataSet;
//  intCont  : Integer;
  intForm  : Integer;
  strMd5   : String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := ' SELECT *          ' +
                       '   FROM FUT_CADNFM ';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadFUT := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('FUT_CADFUT');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Cadastrando Novas Fórmulas...';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '   FROM FUT_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_CODFML = :CODFML    ' +
                        '    AND BAS_CODBAS = :CODBAS    ' +
                        '    AND BAS_PRODUT = :PRODUT    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin
//            for intCont := 1 to 3 do
//            begin
              qryCadFUT.SQL := TAutcomTintaFactory.Get.GetInsert('FUT_CADFUT');

              qryCadFUT.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FUT_CADFUT', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadFUT.ParamByName('FUT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadFUT.ParamByName('FUT_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadFUT.ParamByName('FUT_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadFUT.ParamByName('FUT_REFERE').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;

              qryCadFUT.ParamByName('FUT_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadFUT.ParamByName('FUT_UNIDAD').AsString   := qryBases.FieldByName('BAS_CODUNI').AsString; //arrUnidades[intCont];

              qryCadFUT.ParamByName('FUT_CODITE').Value    := Null;
              qryCadFUT.ParamByName('FUT_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

              qryCadFUT.ParamByName('FUT_PREVEN').AsFloat  := 0.0000;
              qryCadFUT.ParamByName('FUT_PRECUS').AsFloat  := 0.0000;
              qryCadFUT.ParamByName('FUT_COLVEN').AsFloat  := 0.0000;
              qryCadFUT.ParamByName('FUT_COLCUS').AsFloat  := 0.0000;

              strMd5 := '';

              For intForm := 1 To 20 Do
              Begin
                If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString) Then
                  Break;

                qryCadFUT.ParamByName('FUT_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString);
                qryCadFUT.ParamByName('FUT_QTDB' + TStrUtils.fStrZero(intForm, 2)).AsFloat  :=
                  fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString, qryBases.RecordCount, qryCadNfm.FieldByName('NFM_UNIDAD').AsString) * qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat;

                strMd5 := strMd5 +
                qryCadFUT.ParamByName('FUT_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString +
                FloatToStr(qryCadFUT.ParamByName('FUT_QTDB' + TStrUtils.fStrZero(intForm, 2)).AsFloat);
              End;

              qryCadFUT.ParamByName('FUT_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
              qryCadFUT.ParamByName('FUT_SPRODU').AsString := qryCadNfm.FieldByName('NFM_SPRODU').AsString;
              qryCadFUT.ParamByName('FUT_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

              strMd5 := strMd5 + qryCadFUT.ParamByName('FUT_REFERE').AsString +
                                 qryCadFUT.ParamByName('FUT_UNIDAD').AsString +
                                 qryCadFUT.ParamByName('FUT_PRODUT').AsString +
                                 qryCadFUT.ParamByName('FUT_SPRODU').AsString +
                                 qryCadFUT.ParamByName('FUT_CODBAS').AsString;

              qryCadFUT.ParamByName('FUT_MD5KEY').AsString := GetMD5(strMd5);
              qryCadFUT.ParamByName('FUT_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              qryCadFUT.ExecSQL;

              if not (blnGerarUnidades) then
                Break;
            //end;
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

function TGravandoExecucaoFuturaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoFuturaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoFuturaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoFuturaNovasFormulas.fRetPesoUnidade(strCodUni: String;
  intRegistros: Integer; strUniOri: String): Double;
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

procedure TGravandoExecucaoFuturaNovasFormulas.RemoverNovasFormulas;
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
          '   FUT_CADFUT                  ' +
          ' WHERE FUT_REFERE IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     FUT_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   FUT_CADFUT                        ' +
          ' WHERE FUT_REFERE IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     FUT_CADNFM                         ' +
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
