unit untCoralImobiliaria;

interface

uses Windows, SysUtils, Classes, StrUtils, Uni, Forms, untTintadeMaquina;

Type
  TCorForMul = Record
    strCodCol: String;
    fltQtdCol: Double;
End;

Type
  TCorArrCol = Array[1..10] Of TCorForMul;


  TCoralImobiliaria = class(TTintadeMaquina)
  private
    class function fRetProximoCodSeq: Integer;
  public
    function fGravaNovasFormulas(): Boolean;
    function fGravarNovasFormulas: Boolean; override;
  End;

  function fRetornaUnidade(strCodEmb: String): String;
  function fRetFatorEmbalagem(strCodEmb: String): Double;
  function fBaseCadastrada(strCodBas, strUnidad, strDescri: String;
    qryCadBas: TUniQuery): Boolean;

  function fGravaBase(strCodBas, strUnidad, strDescri: String;
    Var intAutIncCadBas: Integer; qryCadBas: TUniQuery): Boolean;

  function fCarregaItem(strCodIte: String; qryCadIte: TUniQuery): Boolean;

  function fGravaCarCor(strCodSeq,
                        strCodEmp,
                        strCodIte,
                        strDescri,
                        strCodigo,
                        strUnidad,
                        strColId1,
                        strColId2,
                        strDesPro,
                        strCodBas,
                        strCodEmb: String;
                        fltPreVen,
                        fltPreCus,
                        fltColVen,
                        fltColCus: Double;
                        strForm01,
                        strForm02,
                        strForm03,
                        strForm04,
                        strForm05,
                        strForm06,
                        strForm07,
                        strForm08,
                        strForm09,
                        strForm10: String;
                        fltQtdC01,
                        fltQtdC02,
                        fltQtdC03,
                        fltQtdC04,
                        fltQtdC05,
                        fltQtdC06,
                        fltQtdC07,
                        fltQtdC08,
                        fltQtdC09,
                        fltQtdC10: Double;
                        Var intAutInc: Integer;
                        strAutoIncrem,
                        strCodUni,
                        strUniver: String): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;

  function fCoralImobiliariaGeraArquivo(blnGerBas: Boolean): Boolean;
  procedure pDeletaNovaFormula(strCodigo: String);

  function fGravaNovasFormulasDin(qryCadNfm: TUniQuery): Boolean;
  function fRetCodEmbalagem(strCodEmbOrigem: String; strUniDes: String): String;

implementation

uses untFuncoes,  DB,  untModulo,
  untModuloTinta, untFuncoesSimples,  Math,
  untIConfTinta, untFuncTinta;

function fRetornaUnidade(strCodEmb: String): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMB_UNIDAD AS UNIDAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIMO_CADEMB ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMB_CODEMB = :CODEMB ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMB').AsString := strCodEmb;
    Open;
    Result := FieldByName('UNIDAD').AsString;
    Close;
  End;

end;

function fBaseCadastrada(strCodBas, strUnidad, strDescri: String;
  qryCadBas: TUniQuery): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CORIMO_CADBAS.*, ';

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + '  BAS_PRECUS AS ITE_PRECUS, ';
    strSQL := strSQL + '  BAS_PREVEN AS ITE_PREVEN ';
  End
  Else
  Begin
    strSQL := strSQL + '  ITE_PRECUS, ';
    strSQL := strSQL + '  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIMO_CADBAS ';
  strSQL := strSQL + '  LEFT JOIN ITEGER ON ITE_CODITE = BAS_CODITE ';
  strSQL := strSQL + '              AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_BASE__ = :CODBAS AND ';
  strSQL := strSQL + '  BAS_UNIDAD = :UNIDAD AND ';
  strSQL := strSQL + '  BAS_DESCRI = :DESCRI ';

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodBas;
    ParamByName('UNIDAD').AsString := strUnidad;
    ParamByName('DESCRI').AsString := strDescri;
    Open;
    Result := (Not IsEmpty);
  End;

end;

function fGravaBase(strCodBas, strUnidad, strDescri: String;
  Var intAutIncCadBas: Integer; qryCadBas: TUniQuery): Boolean;
  Var
    strSQL: String;
    blnGravar: Boolean;
begin

  blnGravar := (Not fBaseCadastrada(strCodBas, strUnidad, strDescri, qryCadBas));

  Result := True;
  If (blnGravar) Then
  Begin

    Try
      strSQL := '';
      strSQL := strSQL + 'INSERT DELAYED INTO CORIMO_CADBAS ';
      strSQL := strSQL + '( ';
      strSQL := strSQL + '  BAS_BASE__, ';
      strSQL := strSQL + '  BAS_CODITE, ';
      strSQL := strSQL + '  BAS_DESCRI, ';
      strSQL := strSQL + '  BAS_UNIDAD, ';
      strSQL := strSQL + '  BAS_CODEMP, ';
      strSQL := strSQL + '  AUTOINCREM ) ';
      strSQL := strSQL + 'VALUES ( ';
      strSQL := strSQL + '  :BASE__, ';
      strSQL := strSQL + '  :CODITE, ';
      strSQL := strSQL + '  :DESCRI, ';
      strSQL := strSQL + '  :UNIDAD, ';
      strSQL := strSQL + '  :CODEMP, ';
      strSQL := strSQL + '  :AUTINC) ';

      With frmModuloTinta.qryGen001 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('BASE__').AsString  := strCodBas;
        ParamByName('CODITE').AsString  := '';
        ParamByName('DESCRI').AsString  := strDescri;
        ParamByName('UNIDAD').AsString  := strUnidad;
        ParamByName('CODEMP').AsString  := VS_strCodEmp;
        ParamByName('AUTINC').AsString  := fFormataAutInc(intAutIncCadBas, VS_strCodEmp);
        ExecSQL;
        Close;
      End;

      Inc(intAutIncCadBas);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaBase]');
      End;
    End;

  End;

end;

function fCarregaItem(strCodIte: String; qryCadIte: TUniQuery): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_PREVE1, ';
  strSQL := strSQL + '  ITE_PRECUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  With qryCadIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    Result := (Not IsEmpty);
  End;

end;

function fGravaCarCor(strCodSeq,
                      strCodEmp,
                      strCodIte,
                      strDescri,
                      strCodigo,
                      strUnidad,
                      strColId1,
                      strColId2,
                      strDesPro,
                      strCodBas,
                      strCodEmb: String;
                      fltPreVen,
                      fltPreCus,
                      fltColVen,
                      fltColCus: Double;
                      strForm01,
                      strForm02,
                      strForm03,
                      strForm04,
                      strForm05,
                      strForm06,
                      strForm07,
                      strForm08,
                      strForm09,
                      strForm10: String;
                      fltQtdC01,
                      fltQtdC02,
                      fltQtdC03,
                      fltQtdC04,
                      fltQtdC05,
                      fltQtdC06,
                      fltQtdC07,
                      fltQtdC08,
                      fltQtdC09,
                      fltQtdC10: Double;
                      Var intAutInc: Integer;
                      strAutoIncrem,
                      strCodUni,
                      strUniver: String): Boolean;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'INSERT DELAYED INTO CORIMO_CADCOR ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  COR_CODSEQ, ';
  strSQL := strSQL + '  COR_CODEMP, ';
  strSQL := strSQL + '  COR_CODITE, ';
  strSQL := strSQL + '  COR_DESCRI, ';
  strSQL := strSQL + '  COR_CODIGO, ';
  strSQL := strSQL + '  COR_UNIDAD, ';
  strSQL := strSQL + '  COR_COLID1, ';
  strSQL := strSQL + '  COR_COLID2, ';
  strSQL := strSQL + '  COR_DESPRO, ';
  strSQL := strSQL + '  COR_CODBAS, ';
  strSQL := strSQL + '  COR_CODEMB, ';
  strSQL := strSQL + '  COR_PREVEN, ';
  strSQL := strSQL + '  COR_PRECUS, ';
  strSQL := strSQL + '  COR_COLVEN, ';
  strSQL := strSQL + '  COR_COLCUS, ';
  strSQL := strSQL + '  COR_FORM01, ';
  strSQL := strSQL + '  COR_FORM02, ';
  strSQL := strSQL + '  COR_FORM03, ';
  strSQL := strSQL + '  COR_FORM04, ';
  strSQL := strSQL + '  COR_FORM05, ';
  strSQL := strSQL + '  COR_FORM06, ';
  strSQL := strSQL + '  COR_FORM07, ';
  strSQL := strSQL + '  COR_FORM08, ';
  strSQL := strSQL + '  COR_FORM09, ';
  strSQL := strSQL + '  COR_FORM10, ';
  strSQL := strSQL + '  COR_QTDC01, ';
  strSQL := strSQL + '  COR_QTDC02, ';
  strSQL := strSQL + '  COR_QTDC03, ';
  strSQL := strSQL + '  COR_QTDC04, ';
  strSQL := strSQL + '  COR_QTDC05, ';
  strSQL := strSQL + '  COR_QTDC06, ';
  strSQL := strSQL + '  COR_QTDC07, ';
  strSQL := strSQL + '  COR_QTDC08, ';
  strSQL := strSQL + '  COR_QTDC09, ';
  strSQL := strSQL + '  COR_QTDC10, ';
  strSQL := strSQL + '  COR_CODUNI, ';
  strSQL := strSQL + '  COR_UNIVER, ';
  strSQL := strSQL + '  AUTOINCREM ) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :CODSEQ, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :CODITE, ';
  strSQL := strSQL + '  :DESCRI, ';
  strSQL := strSQL + '  :CODIGO, ';
  strSQL := strSQL + '  :UNIDAD, ';
  strSQL := strSQL + '  :COLID1, ';
  strSQL := strSQL + '  :COLID2, ';
  strSQL := strSQL + '  :DESPRO, ';
  strSQL := strSQL + '  :CODBAS, ';
  strSQL := strSQL + '  :CODEMB, ';
  strSQL := strSQL + '  :PREVEN, ';
  strSQL := strSQL + '  :PRECUS, ';
  strSQL := strSQL + '  :COLVEN, ';
  strSQL := strSQL + '  :COLCUS, ';
  strSQL := strSQL + '  :FORM01, ';
  strSQL := strSQL + '  :FORM02, ';
  strSQL := strSQL + '  :FORM03, ';
  strSQL := strSQL + '  :FORM04, ';
  strSQL := strSQL + '  :FORM05, ';
  strSQL := strSQL + '  :FORM06, ';
  strSQL := strSQL + '  :FORM07, ';
  strSQL := strSQL + '  :FORM08, ';
  strSQL := strSQL + '  :FORM09, ';
  strSQL := strSQL + '  :FORM10, ';
  strSQL := strSQL + '  :QTDC01, ';
  strSQL := strSQL + '  :QTDC02, ';
  strSQL := strSQL + '  :QTDC03, ';
  strSQL := strSQL + '  :QTDC04, ';
  strSQL := strSQL + '  :QTDC05, ';
  strSQL := strSQL + '  :QTDC06, ';
  strSQL := strSQL + '  :QTDC07, ';
  strSQL := strSQL + '  :QTDC08, ';
  strSQL := strSQL + '  :QTDC09, ';
  strSQL := strSQL + '  :QTDC10, ';
  strSQL := strSQL + '  :CODUNI, ';
  strSQL := strSQL + '  :UNIVER, ';
  strSQL := strSQL + '  :AUTINC) ';

  Try

    Result := True;

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODSEQ').AsString  := strCodSeq;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('DESCRI').AsString  := strDescri;
      ParamByName('CODIGO').AsString  := strCodigo;
      ParamByName('UNIDAD').AsString  := strUnidad;
      ParamByName('COLID1').AsString  := strColId1;
      ParamByName('COLID2').AsString  := strColId2;
      ParamByName('DESPRO').AsString  := strDesPro;
      ParamByName('CODBAS').AsString  := strCodBas;
      ParamByName('CODEMB').AsString  := strCodEmb;
      ParamByName('PREVEN').AsFloat   := fltPreVen;
      ParamByName('PRECUS').AsFloat   := fltPreCus;
      ParamByName('COLVEN').AsFloat   := fltColVen;
      ParamByName('COLCUS').AsFloat   := fltColCus;
      ParamByName('FORM01').AsString  := strForm01;
      ParamByName('FORM02').AsString  := strForm02;
      ParamByName('FORM03').AsString  := strForm03;
      ParamByName('FORM04').AsString  := strForm04;
      ParamByName('FORM05').AsString  := strForm05;
      ParamByName('FORM06').AsString  := strForm06;
      ParamByName('FORM07').AsString  := strForm07;
      ParamByName('FORM08').AsString  := strForm08;
      ParamByName('FORM09').AsString  := strForm09;
      ParamByName('FORM10').AsString  := strForm10;
      ParamByName('QTDC01').AsFloat   := fltQtdC01;
      ParamByName('QTDC02').AsFloat   := fltQtdC02;
      ParamByName('QTDC03').AsFloat   := fltQtdC03;
      ParamByName('QTDC04').AsFloat   := fltQtdC04;
      ParamByName('QTDC05').AsFloat   := fltQtdC05;
      ParamByName('QTDC06').AsFloat   := fltQtdC06;
      ParamByName('QTDC07').AsFloat   := fltQtdC07;
      ParamByName('QTDC08').AsFloat   := fltQtdC08;
      ParamByName('QTDC09').AsFloat   := fltQtdC09;
      ParamByName('QTDC10').AsFloat   := fltQtdC10;
      ParamByName('CODUNI').AsString  := strCodUni;

      If Not fEmptyStr(strUniver) Then
        ParamByName('UNIVER').AsString := strUniver
      Else
        ParamByName('UNIVER').AsString := strColId1;

      ParamByName('AUTINC').AsString  := fRetAutoIncrem('CORIMO_CADCOR', VS_strCodEmp);

      ExecSQL;
      Close;
    End;

    Inc(intAutInc);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaCarCor]');
    End;
  End;

End;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    intContador: Integer;
    strAutInc: String;
    fltCusCol: Double;
    fltVenCol: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    strDesPro: String;

    strSQL: String;
    strCodSeq: String;

    intCont: Integer;
    blnGerarUnidades: Boolean;
  Const
    arrFatores: Array[1..3] Of Double = (1.0, 4.0, 20.0);
begin

  fltCusCol := 0.0;
  fltVenCol := 0.0;

  fltPreCus := 0.0;
  fltPreVen := 0.0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + 'CORIMO_CADBAS.BAS_DESCRI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CORIMO_CADBAS ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BAS_CODITE = :CODITE ';

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := qryCadNfm.FieldByName('NFM_CODITE').AsString;
      Open;
      strDesPro := FieldByName('BAS_DESCRI').AsString;
    End;

  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

//  strAutInc := fRetAutoIncrem('CORIMO_CADCOR', VS_strCodEmp);
//  strCodSeq := fAtualizaProCod('CORIMO_CADCOR');


  intContador := 0;
  {*******************************************}
  {* SOMENTE O PREÇO DA BASE                 *}
  {****************************************PH*}
  fltPreCus := fltPreCus - fltCusCol;
  fltPreVen := fltPreVen - fltVenCol;

  blnGerarUnidades := qryCadNfm.FieldByName('NFM_GERUNI').AsInteger = 1;

//  If (fMensagem('', 'Deseja gerar Litro, Galão e Lata?', ['Sim', 'Não']) = 1) Then
  If blnGerarUnidades Then
  Begin
    For intCont := 1 To 3 Do
    Begin
      strCodSeq := fStrZero(TCoralImobiliaria.fRetProximoCodSeq, 6);
      strAutInc := fRetAutoIncrem('CORIMO_CADCOR', VS_strCodEmp);
      Result := fGravaCarCor(strCodSeq,
                             VS_strCodEmp,
                             qryCadNfm.FieldByName('NFM_CODITE').AsString,
                             qryCadNfm.FieldByName('NFM_DESCRI').AsString,
                             qryCadNfm.FieldByName('NFM_CODIGO').AsString,
                             IfThen(intCont = 1, 'LT', IfThen(intCont = 2, 'GL', 'LA')),
                             '',
                             '',
                             strDesPro,
                             qryCadNfm.FieldByName('NFM_CODBAS').AsString,
                             IntToStr(qryCadNfm.FieldByName('NFM_CODEMB').AsInteger * Trunc(arrFatores[intCont])),
                             fltPreVen + (fltVenCol * arrFatores[intCont]),
                             fltPreCus + (fltCusCol * arrFatores[intCont]),
                             fltVenCol * arrFatores[intCont],
                             fltCusCol * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_FORM01').AsString,
                             qryCadNfm.FieldByName('NFM_FORM02').AsString,
                             qryCadNfm.FieldByName('NFM_FORM03').AsString,
                             qryCadNfm.FieldByName('NFM_FORM04').AsString,
                             qryCadNfm.FieldByName('NFM_FORM05').AsString,
                             qryCadNfm.FieldByName('NFM_FORM06').AsString,
                             qryCadNfm.FieldByName('NFM_FORM07').AsString,
                             qryCadNfm.FieldByName('NFM_FORM08').AsString,
                             qryCadNfm.FieldByName('NFM_FORM09').AsString,
                             qryCadNfm.FieldByName('NFM_FORM10').AsString,
                             qryCadNfm.FieldByName('NFM_QTDC01').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC02').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC03').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC04').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC05').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC06').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC07').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC08').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC09').AsFloat * arrFatores[intCont],
                             qryCadNfm.FieldByName('NFM_QTDC10').AsFloat * arrFatores[intCont],
                             intContador,
                             strAutInc,
//                             qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                             IfThen(intCont = 1, 'LT', IfThen(intCont = 2, 'GL', 'LA')),
                             qryCadNfm.FieldByName('NFM_CODIGO').AsString);
    End
  End
  Else
  Begin
    strCodSeq := fStrZero(TCoralImobiliaria.fRetProximoCodSeq, 6);
    strAutInc := fRetAutoIncrem('CORIMO_CADCOR', VS_strCodEmp);
    Result := fGravaCarCor(strCodSeq,
                           VS_strCodEmp,
                           qryCadNfm.FieldByName('NFM_CODITE').AsString,
                           qryCadNfm.FieldByName('NFM_DESCRI').AsString,
                           qryCadNfm.FieldByName('NFM_CODIGO').AsString,
                           fRetSiglaUnidade(qryCadNfm.FieldByName('NFM_UNIDAD').AsString),
                           '',
                           '',
                           strDesPro,
                           qryCadNfm.FieldByName('NFM_CODBAS').AsString,
                           qryCadNfm.FieldByName('NFM_CODEMB').AsString,
                           fltPreVen + (fltVenCol),
                           fltPreCus + (fltCusCol),
                           fltVenCol,
                           fltCusCol,
                           qryCadNfm.FieldByName('NFM_FORM01').AsString,
                           qryCadNfm.FieldByName('NFM_FORM02').AsString,
                           qryCadNfm.FieldByName('NFM_FORM03').AsString,
                           qryCadNfm.FieldByName('NFM_FORM04').AsString,
                           qryCadNfm.FieldByName('NFM_FORM05').AsString,
                           qryCadNfm.FieldByName('NFM_FORM06').AsString,
                           qryCadNfm.FieldByName('NFM_FORM07').AsString,
                           qryCadNfm.FieldByName('NFM_FORM08').AsString,
                           qryCadNfm.FieldByName('NFM_FORM09').AsString,
                           qryCadNfm.FieldByName('NFM_FORM10').AsString,
                           qryCadNfm.FieldByName('NFM_QTDC01').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC02').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC03').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC04').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC05').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC06').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC07').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC08').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC09').AsFloat,
                           qryCadNfm.FieldByName('NFM_QTDC10').AsFloat,
                           intContador,
                           strAutInc,
                           qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                           qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  End;

  frmModuloTinta.qryGen001.Close;

end;

function fCoralImobiliariaGeraArquivo(blnGerBas: Boolean): Boolean;
  Var
    strPatCor: String;
    arquivos:  TSearchRec;
    stlArquivos: TStringList;
    stlArqTxt: TStringList;
    intContador: Integer;
    intContador2: Integer;
    intContCol: Integer;
    intLinhaAtu: Integer;

    {*******************************************}
    {* DADOS DO TXT                            *}
    {****************************************MV*}
    strLinha: String;
    strRecId: String;
    strColId1: String;
    strColId2: String;
    strCodBas: String;
    strCodEmb: String;
    strDesPro: String;
    strUniver: String;

    arrColCor: TCorArrCol;

    fltPreVen: Double;
    fltPreCus: Double;
    strCodIte: String;
    strUnidad: String;

    fltVenCol: Double;
    fltCusCol: Double;

    intAutIncCadBas: Integer;
    intAutIncCadCor: Integer;

    intCodSeq: Integer;

    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
//    qryCadIte: TUniQuery;

    strSQL: String;
    qryCadNfm: TUniQuery;

    conf: IConfTinta;
begin

  conf := fGetConfTinta('CIM');

  fltVenCol := 0;
  fltCusCol := 0;
  stlArquivos := TStringList.Create;
  stlArqTxt   := TStringList.Create;
  strPatCor   := conf.fGet('TXTCOR');

  intAutIncCadBas := 1;
  intAutIncCadCor := 1;
  intCodSeq       := 1;

  qryCadBas := TUniQuery.Create(Nil);
  qryCadBas.Connection := frmModulo.Database;

  qryCadCol := fCriaQuery(Nil);

  qryCadNfm := fCriaQuery(Nil);

//  qryCadIte := TUniQuery.Create(Nil);
//  qryCadIte.Connection := frmModulo.Database;

  If (FindFirst(strPatCor + '\*.txt', faAnyFile, arquivos) = 0) Then
  Begin

    Repeat
      stlArquivos.Add(strPatCor  + '\' + arquivos.Name);
    Until (FindNext(arquivos) <> 0);

  End;
  FindClose(arquivos);

  If (stlArquivos.Count <= 0) Then
  Begin
    fMensagem('', 'Não foi encontrado nenhum arquivo para geração!', ['&Ok']);
    FreeAndNil(stlArquivos);
    Result := False;
    Exit;
  End;

  qryCadCol.SQL.Add('SELECT ');
  qryCadCol.SQL.Add('  COL_CODCOL, ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadCol.SQL.Add('  COL_PRECUS AS ITE_PRECUS, ');
    qryCadCol.SQL.Add('  COL_PREVEN AS ITE_PREVEN ');
  End
  Else
  Begin
    qryCadCol.SQL.Add('  ITE_PRECUS, ');
    qryCadCol.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  End;

  qryCadCol.SQL.Add('FROM ');
  qryCadCol.SQL.Add('  CORIMO_CADCOL');
  qryCadCol.SQL.Add('  LEFT JOIN ITEGER ON ITE_CODITE = COL_CODITE ');
  qryCadCol.SQL.Add('              AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');

  qryCadCol.Open;

  pZapTable('CORIMO_CADCOR');

  Result := True;

  For intContador := 0 To stlArquivos.Count -1 Do
  Begin

    stlArqTxt.LoadFromFile(stlArquivos[intContador]);

    For intLinhaAtu := 0 To stlArqTxt.Count -1 Do
    Begin

      Application.ProcessMessages;

      {*******************************************}
      {* LIMPA MATRIZ DE COLORANTES              *}
      {****************************************MV*}
      For intContador2 := Low(arrColCor) To High(arrColCor) Do
      Begin
        arrColCor[intContador2].strCodCol := '';
        arrColCor[intContador2].fltQtdCol := 0.0;
      End;

      strLinha := stlArqTxt[intLinhaAtu];

      strRecId  := Trim(Copy(strLinha, 001, 009));

      If (fEmptyStr(strRecId)) Or (Not fIsNumber(strRecId)) Then
      Begin
        Continue;
      End;

      If conf.fGetInteger('VERTXT') = 0 Then
      Begin

        strColId1 := Trim(Copy(strLinha, 011, 030));
        strColId2 := Trim(Copy(strLinha, 042, 050));
        strCodBas := Trim(Copy(strLinha, 144, 010));
        strCodEmb := Trim(Copy(strLinha, 155, 010));
        strDesPro := Trim(Copy(strLinha, 166, 050));
        strUniver := strColId2;

        If (fArqIniTinta(0, 'USA_FORMUL', 'CIM', 'S') = 'S') Then
        Begin

          arrColCor[01].strCodCol := Trim(Copy(strLinha, 217, 009));
          arrColCor[01].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 267, 012)), '.', ','));
          arrColCor[02].strCodCol := Trim(Copy(strLinha, 227, 009));
          arrColCor[02].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 280, 012)), '.', ','));
          arrColCor[03].strCodCol := Trim(Copy(strLinha, 237, 009));
          arrColCor[03].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 293, 012)), '.', ','));
          arrColCor[04].strCodCol := Trim(Copy(strLinha, 247, 009));
          arrColCor[04].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 306, 012)), '.', ','));
          arrColCor[05].strCodCol := Trim(Copy(strLinha, 257, 009));
          arrColCor[05].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 319, 012)), '.', ','));

        End;

        For intContador2 := Low(arrColCor) To High(arrColCor) Do
          If (arrColCor[intContador2].strCodCol = '0') Then
            arrColCor[intContador2].strCodCol := '';

      End
      Else
      Begin
        strColId1 := Trim(Copy(strLinha, 011, 030));
        strColId2 := Trim(Copy(strLinha, 505, 050));
        strCodBas := Trim(Copy(strLinha, 093, 010));
        strCodEmb := Trim(Copy(strLinha, 104, 010));
        strDesPro := Trim(Copy(strLinha, 115, 050));
        strUniver := Trim(Copy(strLinha, 042, 050));

        If (fArqIniTinta(0, 'USA_FORMUL', 'CIM', 'S') = 'S') Then
        Begin

          arrColCor[01].strCodCol := Trim(Copy(strLinha, 166, 009));
          arrColCor[01].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 216, 012)), '.', ','));
          arrColCor[02].strCodCol := Trim(Copy(strLinha, 176, 009));
          arrColCor[02].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 229, 012)), '.', ','));
          arrColCor[03].strCodCol := Trim(Copy(strLinha, 186, 009));
          arrColCor[03].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 242, 012)), '.', ','));
          arrColCor[04].strCodCol := Trim(Copy(strLinha, 196, 009));
          arrColCor[04].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 255, 012)), '.', ','));
          arrColCor[05].strCodCol := Trim(Copy(strLinha, 206, 009));
          arrColCor[05].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 268, 012)), '.', ','));

        End;

        For intContador2 := Low(arrColCor) To High(arrColCor) Do
          If (arrColCor[intContador2].strCodCol = '0') Then
            arrColCor[intContador2].strCodCol := '';

//        fltPreVen := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 466, 012)), '.', ','));
//        fltPreCus := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 490, 012)), '.', ','));
      End;

      strUnidad := fRetornaUnidade(strCodEmb);

      If (blnGerBas) Then
      Begin
        fGravaBase(strCodBas, strUnidad, strDesPro, intAutIncCadBas, qryCadBas);
      End;

      {*******************************************}
      {* SE A BASE NÃO EXISTE, NAO GERA A TINTA  *}
      {****************************************MV*}
      If (Not fBaseCadastrada(strCodBas, strUnidad, strDesPro, qryCadBas)) Then
      Begin
        Continue;
      End;

      fltPreCus := 0.0;
      fltPreVen := 0.0;
      {*******************************************}
      {* REALIZA O CÁLCULO DO PREÇO DE VENDA     *}
      {***16/05/2008***************************MV*}
      For intContCol := 1 To 5 Do
      Begin


        If (Not qryCadCol.Locate('COL_CODCOL', arrColCor[intContCol].strCodCol, [])) Then
          Continue;

        fltPreCus := fltPreCus + (arrColCor[intContCol].fltQtdCol * 0.308) * (qryCadCol.FieldByName('ITE_PRECUS').AsFloat / 1000);
        fltPreVen := fltPreVen + (arrColCor[intContCol].fltQtdCol * 0.308) * (qryCadCol.FieldByName('ITE_PREVEN').AsFloat / 1000);

      End;

      fltPreCus := 0.0;
      fltPreVen := 0.0;
      strCodIte := '';

      Result := fGravaCarCor(fStrZero(intCodSeq, 6),
                             VS_strCodEmp,
                             strCodIte,
                             Trim(strUniver + ' ' + strDesPro + ' ' + strCodBas),
                             strColId1,
                             fRetSiglaUnidade(strUnidad),
                             strColId1,
                             strColId2,
                             strDesPro,
                             strCodBas,
                             strCodEmb,
                             fltPreVen,
                             fltPreCus,
                             fltVenCol,
                             fltCusCol,
                             arrColCor[01].strCodCol,
                             arrColCor[02].strCodCol,
                             arrColCor[03].strCodCol,
                             arrColCor[04].strCodCol,
                             arrColCor[05].strCodCol,
                             arrColCor[06].strCodCol,
                             arrColCor[07].strCodCol,
                             arrColCor[08].strCodCol,
                             arrColCor[09].strCodCol,
                             arrColCor[10].strCodCol,
                             arrColCor[01].fltQtdCol,
                             arrColCor[02].fltQtdCol,
                             arrColCor[03].fltQtdCol,
                             arrColCor[04].fltQtdCol,
                             arrColCor[05].fltQtdCol,
                             arrColCor[06].fltQtdCol,
                             arrColCor[07].fltQtdCol,
                             arrColCor[08].fltQtdCol,
                             arrColCor[09].fltQtdCol,
                             arrColCor[10].fltQtdCol,
                             intAutIncCadCor,
                             '',
                             strUnidad,
                             strUniver);
      If (Result) Then
      Begin
        Inc(intCodSeq);
      End
      Else
        Break;

    End;

    If (Not Result) Then
      Break;

  End;

  {*******************************************}
  {* ATUALIZA CADCOR                         *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  PROCOD ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  PRO_CODSEQ = LPAD(:CODSEQ + 1, PRO_TAMCOD, "0"), ';
  strSQL := strSQL + '  PRO_AUTINC = :AUTINC + 1 ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_NOMARQ = "CORIMO_CADCOR" ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsInteger := intCodSeq;
    ParamByName('AUTINC').AsInteger := intAutIncCadCor;
    ExecSQL;
    Close;
  End;

  {*******************************************}
  {* ATUALIZA CADBAS                         *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  PROCOD ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  PRO_AUTINC = :AUTINC + 1 ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_NOMARQ = "CORIMO_CADBAS" ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('AUTINC').AsInteger := intAutIncCadBas;
    ExecSQL;
    Close;
  End;

  {*******************************************}
  {* PROCESSA CADASTRO DE NOVAS FORUMULAS    *}
  {****************************************MV*}
  With qryCadNfm Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CORIMO_CADNFM');
    Open;

    While (Not Eof) Do
    Begin

      Result := fGeraNovasFormulas(qryCadNfm);

      If (Not Result) Then
        Break;

      Next;
      Application.ProcessMessages;
    End;

    Close;
  End;

end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM CORIMO_CADCOR WHERE COR_CODIGO = :CODIGO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODIGO').AsString := strCodigo;
    ExecSQL;
    Close;
  End;
end;

function fRetFatorEmbalagem(strCodEmb: String): Double;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ROUND(EMB_QTDEMB / 1000, 4) AS EMB_QTDEMB ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIMO_CADEMB ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMB_CODEMB = :CODEMB ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMB').AsString := strCodEmb;
    Open;
    Result := FieldByName('EMB_QTDEMB').AsFloat;
    Close;
  End;

end;

{ TCoralImobiliaria }

function TCoralImobiliaria.fGravaNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadCor: TUniQuery;
    intCont: Integer;
    intUnid: Integer;
    blnUnid: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (1.0, 4.0, 20);
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM CORIMO_CADCOR WHERE COR_CODIGO IN (SELECT NFM_CODIGO FROM CORIMO_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM CORIMO_CADNFM ');
  qryGen.SQL.Add('   INNER JOIN CORIMO_CADBAS ');
  qryGen.SQL.Add('     ON NFM_CODBAS = BAS_BASE__ ');
  qryGen.SQL.Add('       AND NFM_DESPRO = BAS_DESCRI ');
  qryGen.SQL.Add('       AND NFM_UNIDAD = BAS_UNIDAD; ');
  qryGen.Open;
  qryGen.First;

  qryCadCor := fCriaQuery(Self);
  qryCadCor.SQL.Text := 'SELECT * FROM CORIMO_CADCOR WHERE FALSE';
  qryCadCor.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('CORIMO_CADCOR', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    blnUnid := qryGen.FieldByName('NFM_GERUNI').AsInteger <> 1;


    For intUnid := 1 To 3 Do
    Begin
      qryCadCor.Insert;

      qryCadCor.FieldByName('COR_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
      qryCadCor.FieldByName('COR_CODEMP').AsString := VS_strCodEmp;
      qryCadCor.FieldByName('COR_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;
      qryCadCor.FieldByName('COR_CODIGO').AsString := qryGen.FieldByName('NFM_CODIGO').AsString;
      qryCadCor.FieldByName('COR_UNIDAD').AsString := IfThen(blnUnid, qryGen.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);
      qryCadCor.FieldByName('COR_CODBAS').AsString := qryGen.FieldByName('NFM_CODBAS').AsString;
      qryCadCor.FieldByName('COR_UNIVER').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;

      For intCont := 1 To 10 Do
      Begin

        If fEmptyStr(qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadCor.FieldByName('COR_FORM' + fStrZero(intCont, 2)).AsString :=
          qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

        qryCadCor.FieldByName('COR_QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * IfThen(blnUnid, 1, arrFator[intUnid]);
      End;

      qryCadCor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADCOR', VS_strCodEmp);

      If blnUnid Then
      Begin
        qryCadCor.FieldByName('COR_CODEMB').AsString := qryGen.FieldByName('NFM_CODEMB').AsString;
      End
      Else
      Begin
        qryCadCor.FieldByName('COR_CODEMB').AsString :=
          fRetCodEmbalagem(qryGen.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
      End;

      qryCadCor.FieldByName('COR_CODUNI').AsString := qryCadCor.FieldByName('COR_UNIDAD').AsString;
      qryCadCor.FieldByName('COR_DESPRO').AsString := qryGen.FieldByName('BAS_DESCRI').AsString;
      qryCadCor.FieldByName('COR_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('COR_DESCRI').AsString +
                                                        qryCadCor.FieldByName('COR_CODIGO').AsString +
                                                        qryCadCor.FieldByName('COR_UNIDAD').AsString +
                                                        qryCadCor.FieldByName('COR_COLID1').AsString +
                                                        qryCadCor.FieldByName('COR_COLID2').AsString +
                                                        qryCadCor.FieldByName('COR_DESPRO').AsString +
                                                        qryCadCor.FieldByName('COR_CODBAS').AsString +
                                                        qryCadCor.FieldByName('COR_CODEMB').AsString +
                                                        qryCadCor.FieldByName('COR_CODUNI').AsString +
                                                        qryCadCor.FieldByName('COR_UNIVER').AsString);      

      qryCadCor.Post;

      If blnUnid Then Break;
    End;
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TCoralImobiliaria.fGravarNovasFormulas: Boolean;
begin
  Result := fGravaNovasFormulas;
end;

class function TCoralImobiliaria.fRetProximoCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
   qryGen := fCriaQuery(nil);

  qryGen.SQL.Text := 'SELECT IFNULL(MAX(COR_CODSEQ), 0) + 1 AS MAXIMO FROM CORIMO_CADCOR;';
   qryGen.Open;

  Result := qryGen.FieldByName('MAXIMO').AsInteger;
  FreeAndNil(qryGen);
end;

function fGravaNovasFormulasDin(qryCadNfm: TUniQuery): Boolean;
   Var
    qryGen: TUniQuery;
    intCont: Integer;
    intUnid: Integer;
    blnGerUnids: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (1.0, 4.0, 20);
begin
  qryGen := fCriaQuery(qryCadNfm);

  qryGen.SQL.Text := 'DELETE FROM CORIMO_CADCOR WHERE COR_CODIGO = ' +
    QuotedStr(qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO CORIMO_CADCOR ');
  qryGen.SQL.Add('             (COR_CODSEQ, ');
  qryGen.SQL.Add('              COR_CODEMP, ');
  qryGen.SQL.Add('              COR_DESCRI, ');
  qryGen.SQL.Add('              COR_CODIGO, ');
  qryGen.SQL.Add('              COR_UNIDAD, ');
  qryGen.SQL.Add('              COR_COLID1, ');
  qryGen.SQL.Add('              COR_COLID2, ');
  qryGen.SQL.Add('              COR_DESPRO, ');
  qryGen.SQL.Add('              COR_CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              COR_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              COR_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              AUTOINCREM, ');
  qryGen.SQL.Add('              COR_CODEMB, ');
  qryGen.SQL.Add('              COR_CODUNI, ');
  qryGen.SQL.Add('              COR_MD5KEY, ');  
  qryGen.SQL.Add('              COR_UNIVER) ');
  qryGen.SQL.Add(' VALUES (:CODSEQ, ');
  qryGen.SQL.Add('         :CODEMP, ');
  qryGen.SQL.Add('         :DESCRI, ');
  qryGen.SQL.Add('         :CODIGO, ');
  qryGen.SQL.Add('         :UNIDAD, ');
  qryGen.SQL.Add('         :COLID1, ');
  qryGen.SQL.Add('         :COLID2, ');
  qryGen.SQL.Add('         :DESPRO, ');
  qryGen.SQL.Add('         :CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('         :FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('         :QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('         :AUTOINCREM, ');
  qryGen.SQL.Add('         :CODEMB, ');
  qryGen.SQL.Add('         :CODUNI, ');
  qryGen.SQL.Add('         :MD5KEY, ');  
  qryGen.SQL.Add('         :UNIVER); ');

  blnGerUnids := qryCadNfm.FieldByName('NFM_GERUNI').AsInteger = 2;

  For intUnid := 1 To 3 Do
  Begin
    qryGen.ParamByName('CODSEQ').AsString := fStrZero(TCoralImobiliaria.fRetProximoCodSeq, 6);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryGen.ParamByName('CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
    qryGen.ParamByName('UNIVER').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;

    qryGen.ParamByName('UNIDAD').AsString :=
      IfThen(blnGerUnids, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);

    qryGen.ParamByName('DESPRO').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;
    qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADCOR', VS_strCodEmp);

    If blnGerUnids Then
    Begin
      qryGen.ParamByName('CODEMB').AsString := qryCadNfm.FieldByName('NFM_CODEMB').AsString;
    End
    Else
    Begin
      qryGen.ParamByName('CODEMB').AsString :=
        fRetCodEmbalagem(qryCadNfm.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
    End;

    qryGen.ParamByName('CODUNI').AsString := qryGen.ParamByName('UNIDAD').AsString;

    For intCont := 1 To 10 Do
    Begin
      qryGen.ParamByName('FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
        qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * arrFator[intUnid];
    End;

    qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('DESCRI').AsString +
                                              qryGen.ParamByName('CODIGO').AsString +
                                              qryGen.ParamByName('UNIDAD').AsString +
                                              qryGen.ParamByName('COLID1').AsString +
                                              qryGen.ParamByName('COLID2').AsString +
                                              qryGen.ParamByName('DESPRO').AsString +
                                              qryGen.ParamByName('CODBAS').AsString +
                                              qryGen.ParamByName('CODEMB').AsString +
                                              qryGen.ParamByName('CODUNI').AsString +
                                              qryGen.ParamByName('UNIVER').AsString);
    qryGen.ExecSQL;

    If blnGerUnids Then Break;
  End;

  Result := True;
end;

function fRetCodEmbalagem(strCodEmbOrigem: String; strUniDes: String): String;
  Var
    qryGen: TUniQuery;
begin

   qryGen := fCriaQuery();


  qryGen.SQL.Text := 'SELECT EMB_CODEMB, EMB_UNIDAD FROM CORIMO_CADEMB WHERE EMB_CODEMB IN (' +
    strCodEmbOrigem + ', ' + strCodEmbOrigem  + ' * 4, ' + strCodEmbOrigem + ' * 20)';
   qryGen.Open;

  If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
  Begin
    Result := qryGen.FieldByName('EMB_CODEMB').AsString;
  End
   Else

    Result := strCodEmbOrigem;
  FreeAndNil(qryGen);
end;


end.
