{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta CoralImobiliaria *}
{*******************************************************************************PH*}
unit untGravandoExecucaoCoralImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoCoralImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fRetProximoCodSeq: Integer;
    function fRetCodEmbalagem(strCodEmbOrigem: String; strUniDes: String;
      strUniNfm: String; strProdut: String): String;
    function fEmbalagemProporcaoExiste(strCodEmbOrigem: String; strUniDes: String;
      strUniNfm: String; strProdut: String): Boolean;
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri,
      strProdut: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fRetFatorEmbalagemPadraoPersonalizadaLata(AProduto: String): Double;
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

{ TGravandoExecucaoCoralImobiliariaNovasFormulas }

constructor TGravandoExecucaoCoralImobiliariaNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoCoralImobiliariaNovasFormulas.Executar(const gravando: IGravando);
//const
//  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
//  arrPesos: array[0..2] of Double = (1, 4, 20);
var
  qryCadNfm          : IDataSet;
  qryCadCIM          : IDataSet;
  intCont            : Integer;
//  intUnidade         : Integer;
  qryBases           : IDataSet;
  intCodSeq          : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := ' SELECT *                           ' +
                       '   FROM CORIMO_CADNFM               ' +
                       '  INNER JOIN CORIMO_CADBAS          ' +
                       '     ON NFM_CODBAS = BAS_BASE__     ' +
                       '       AND NFM_DESPRO = BAS_DESCRI  ' +
                       '       AND NFM_UNIDAD = BAS_UNIDAD  ';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadCIM := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CORIMO_CADCOR');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      intCodSeq := fRetProximoCodSeq;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_UNIDAD              ' +
                        '   FROM CORIMO_CADBAS           ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_DESCRI = :PRODUT    ' +
                        '    AND BAS_BASE__ = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;

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
            //for intUnidade := 0 to 2 do
            //begin
              If fEmbalagemProporcaoExiste(qryCadNfm.FieldByName('NFM_CODEMB').AsString,
                                           qryBases.FieldByName('BAS_UNIDAD').AsString,
                                           qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                                           qryCadNfm.FieldByName('NFM_DESPRO').AsString) Then //arrUnidades[intUnidade]
              Begin
                qryCadCIM.SQL := TAutcomTintaFactory.Get.GetInsert('CORIMO_CADCOR');

                qryCadCIM.ParamByName('COR_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
                qryCadCIM.ParamByName('COR_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadCIM.ParamByName('COR_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
                qryCadCIM.ParamByName('COR_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                qryCadCIM.ParamByName('COR_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
                qryCadCIM.ParamByName('COR_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString; //arrUnidades[intUnidade];
                qryCadCIM.ParamByName('COR_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
                qryCadCIM.ParamByName('COR_COLID2').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                qryCadCIM.ParamByName('COR_UNIVER').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                qryCadCIM.ParamByName('COR_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                qryCadCIM.ParamByName('COR_CODITE').Value    := Null;
                qryCadCIM.ParamByName('COR_PREVEN').AsFloat  := 0.0;
                qryCadCIM.ParamByName('COR_PRECUS').AsFloat  := 0.0;
                qryCadCIM.ParamByName('COR_COLVEN').AsFloat  := 0.0;
                qryCadCIM.ParamByName('COR_COLCUS').AsFloat  := 0.0;
                qryCadCIM.ParamByName('COR_COLID1').AsString := '';

                qryCadCIM.ParamByName('COR_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

                for intCont := 1 to 20 do
                begin
                  If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
                    Break;

                  qryCadCIM.ParamByName('COR_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                  qryCadCIM.ParamByName('COR_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
                    qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
                      fRetPesoUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString,
                                      qryBases.RecordCount,
                                      qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                                      qryCadNfm.FieldByName('NFM_DESPRO').AsString); //arrPesos[intUnidade];
                end;

                qryCadCIM.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CORIMO_CADCOR', TAutcomTintaFactory.Get.GetCodEmp);

                qryCadCIM.ParamByName('COR_CODEMB').AsString :=
                  fRetCodEmbalagem(qryCadNfm.FieldByName('NFM_CODEMB').AsString,
                                   qryBases.FieldByName('BAS_UNIDAD').AsString,
                                   qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                                   qryCadNfm.FieldByName('NFM_DESPRO').AsString);  //arrUnidades[intUnidade]

                qryCadCIM.ParamByName('COR_CODUNI').AsString := qryCadCIM.ParamByName('COR_UNIDAD').AsString;
                qryCadCIM.ParamByName('COR_DESPRO').AsString := qryCadNfm.FieldByName('BAS_DESCRI').AsString;

                qryCadCIM.ParamByName('COR_MD5KEY').AsString := GetMD5(qryCadCIM.ParamByName('COR_DESCRI').AsString +
                                                                       qryCadCIM.ParamByName('COR_CODIGO').AsString +
                                                                       qryCadCIM.ParamByName('COR_UNIDAD').AsString +
                                                                       qryCadCIM.ParamByName('COR_COLID1').AsString +
                                                                       qryCadCIM.ParamByName('COR_COLID2').AsString +
                                                                       qryCadCIM.ParamByName('COR_DESPRO').AsString +
                                                                       qryCadCIM.ParamByName('COR_CODBAS').AsString +
                                                                       qryCadCIM.ParamByName('COR_CODEMB').AsString +
                                                                       qryCadCIM.ParamByName('COR_CODUNI').AsString +
                                                                       qryCadCIM.ParamByName('COR_UNIVER').AsString);

                qryCadCIM.ExecSQL;

                if not (blnGerarUnidades) then
                  Break;

                Inc(intCodSeq);
              End;
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

function TGravandoExecucaoCoralImobiliariaNovasFormulas.fEmbalagemProporcaoExiste(
  strCodEmbOrigem, strUniDes, strUniNfm, strProdut: String): Boolean;
  Var
    qryGen: IDataSet;
    strFiltro: String;
begin
  Result := False;


  If Pos('TEXTURA', strProdut) > 0 Then
    strFiltro := '3000, 13000'
  Else If Trim(strProdut) = 'CORAL MACTRA VEDBEM IMPERALL' Then
    strFiltro := '2800, 13800'
  Else If (Pos(strUniNfm, 'QT_LT_') > 0) Then
    strFiltro := strCodEmbOrigem + ', ' + strCodEmbOrigem  + ' * 4, ' + strCodEmbOrigem + ' * 20'
  Else If (strUniNfm = 'GL') Then
    strFiltro := strCodEmbOrigem + ', ' + strCodEmbOrigem  + ' * 5'
  Else
    strFiltro := strCodEmbOrigem;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT EMB_CODEMB,   ' +
                '        EMB_UNIDAD    ' +
                '   FROM CORIMO_CADEMB ' +
                '  WHERE EMB_CODEMB IN ( ' + strFiltro + ' )';
  qryGen.Open;

  If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
    Result := True;
end;

function TGravandoExecucaoCoralImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoCoralImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoCoralImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoCoralImobiliariaNovasFormulas.fRetCodEmbalagem(
  strCodEmbOrigem, strUniDes, strUniNfm, strProdut: String): String;
  Var
    qryGen: IDataSet;
    strFiltro: String;
begin

  If Pos('TEXTURA', strProdut) > 0 Then
    strFiltro := '3000, 13000'
  Else If Trim(strProdut) = 'CORAL MACTRA VEDBEM IMPERALL' Then
    strFiltro := '2800, 13800'
  Else If (Pos(strUniNfm, 'QT_LT_') > 0) Then
    strFiltro := strCodEmbOrigem + ', ' + strCodEmbOrigem  + ' * 4, ' + strCodEmbOrigem + ' * 20'
  Else If (strUniNfm = 'GL') Then
    strFiltro := strCodEmbOrigem + ', ' + strCodEmbOrigem  + ' * 5'
  Else
    strFiltro := strCodEmbOrigem;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT EMB_CODEMB,   ' +
                '        EMB_UNIDAD    ' +
                '   FROM CORIMO_CADEMB ' +
                '  WHERE EMB_CODEMB IN ( ' + strFiltro + ' )';
  qryGen.Open;

  If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
  Begin
    Result := qryGen.FieldByName('EMB_CODEMB').AsString;
  End
  Else
    Result := strCodEmbOrigem;
end;

function TGravandoExecucaoCoralImobiliariaNovasFormulas.fRetFatorEmbalagemPadraoPersonalizadaLata(AProduto: String): Double;
begin
  Result := 5;

  If Pos('TEXTURA', AProduto) > 0 Then
    Result := (13000 / 3000)
  Else If Trim(AProduto) = 'CORAL MACTRA VEDBEM IMPERALL' Then
    Result := (13800 / 2800);
end;


function TGravandoExecucaoCoralImobiliariaNovasFormulas.fRetPesoUnidade(
  strCodUni: String; intRegistros: Integer; strUniOri, strProdut: String): Double;
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
      Result := fRetFatorEmbalagemPadraoPersonalizadaLata(strProdut);
  End;
end;

function TGravandoExecucaoCoralImobiliariaNovasFormulas.fRetProximoCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT IFNULL(MAX(COR_CODSEQ), 0) + 1 AS MAXIMO FROM CORIMO_CADCOR;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoCoralImobiliariaNovasFormulas.RemoverNovasFormulas;
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
          '   CORIMO_CADCOR               ' +
          ' WHERE COR_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     CORIMO_CADNFM)            ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   CORIMO_CADCOR                        ' +
          ' WHERE COR_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     CORIMO_CADNFM                         ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm) + ') ';
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
