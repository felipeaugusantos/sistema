unit untMovIte;

interface

uses Classes, untFuncFat, untFuncFatTypes, Uni, SysUtils, Data.DB,
  Faturamento.Auditoria.Interfaces.Cat17, System.Variants, untFuncoesSimples,
  untIFdoIte, untModulo;

Type
  TMovIte = class
    private
      fatVenda: TFatVenda;
      FAuditoriaCat17: IAuditoriaCat17;
      FobjCriarConexao: TCriarConexao;
      FFdoIte: IFdoIte;


      procedure pGravaMovIteInterna( strAutInc,
                                     strIdePro,
                                     strCodIte,
                                     strCodEmp,
                                     strTabPre,
                                     strBasCol,
                                     strCodAca,
                                     strEmpAca,
                                     strImpDir,
                                     strPromoc: String;
                                     fltQtdIte: Double;
                                     strPesGra: String;
                                     fltEmbala: Double;
                                     fltDopTin: Double;
                                     fltQtdAdt: Double;
                                     strCodAbf: String;
                                     strTipAbf: String;
                                     strEstAbf: String;
                                     fltPerDesEmbFec: Double;
                                     fltFdoItePreVen: Double);

      function fCarregaPromocao( strIdePro, strCodIte, strTabPre, strPromoc: String; fltQtdIte: Double;
                             Var fltPreCus, fltPreVen: Double ): Boolean;

      procedure pPreparaProdutoAcabado(Var qrySelect: TUniQuery; strTabPre, strAutInc,
                                           strCodIte, strCodAca, strEmpAca, strCodEmp,
                                           strImpDir: String; fltQtdIte: Double;
                                           strCodAbf, strTipAbf, strEstAbf : String;
                                           fltPerDesEmbFec: Double; fltFdoItePreVen: Double);

      procedure pPreparaProdutoNormal(Var qrySelect: TUniQuery; strTabPre, strAutInc, strCodIte, strCodEmp,
                                          strBasCol, strPesGra, strImpDir, strIdePro, strPromoc: String;
                                          fltQtdIte, fltEmbala: Double; fltDopTin: Double;
                                          fltQtdAdt: Double; strCodAbf, strTipAbf, strEstAbf : String;
                                          fltPerDesEmbFec: Double; fltFdoItePreVen: Double);

      function fRetornaPrecoClienteFilial(strCodIte, strCodEmp: String; strIdePro: String = 'NOR'; strEmpEst: String = ''): Double;

      function fMensagemFormulacao(strBasCol: String): String;

      function fExistirReducaoRessarcimentoCAT(strCodIte: String; strIdePro: String): Boolean;

      function fRetornarPrecoDeVendaDoPedido(const strAutIncFatDor, strCodIte: String): Double;

    public
      constructor Create(objVenda: TFatVenda; objAuditoriaCat17: IAuditoriaCat17; objFdoIte: IFdoIte);
      destructor Destroy; override;

      procedure pGravaMovIte( strAutInc : String;
                              item      : TDadosFechamento;
                              strTipAbf : String;
                              strEstAbf : String );

      class procedure pParticionaMovIteEntregaFutura(strAutIncAtu, strAutIncNov: String; fltQtdPar: Double);
  end;

  Const
    BASE_AUTOMOTIVA: String = 'BA';
    EMBALAGEM: String = 'E';
    BASE_IMOBILIARIA: String = 'B';
    COLORANTE: String = 'C';
    CATALISADOR: String = 'CT';

implementation

uses untTMatrizSaldosColorantes, untCadPro;
                         
{ TMovIte }

procedure TMovIte.pGravaMovIte(strAutInc : String;
                               item      : TDadosFechamento;
                               strTipAbf : String;
                               strEstAbf : String);
  Var
    intFormulacao: Integer;
    matrizFormulacao: TClassMatrizSaldosColorantes;
    blnGravouMovIte : Boolean;
    fltFdoItePreVen : Double;
begin
  matrizFormulacao := nil;
  With fatVenda.dicFormulas Do
  Begin
    If Assigned(RetornaObjeto(IntToStr(item.intAutInc))) Then
      matrizFormulacao := TClassMatrizSaldosColorantes(RetornaObjeto(IntToStr(item.intAutInc)));
  End;

  If (item.strIdePro = 'NOR') Or (Not Assigned(matrizFormulacao)) Then
  Begin
    fltFdoItePreVen := fRetornarPrecoDeVendaDoPedido(item.strSeqDet, item.strCodIte);

    pGravaMovIteInterna( strAutInc, item.strIdePro, item.strCodIte, VS_strCodEmp,
      item.strTabPre, 'N', item.strCodAca, item.strEmpAca, item.strImpDir, item.strPromoc,item.fltQtdIte,
      'N', 0.0, item.fltDopTin, 0.0, item.strCodAbf, strTipAbf, strEstAbf, item.fltPerDesEmbFec, fltFdoItePreVen)
  End
  Else
  Begin
    {
    * ERRO ESPORÁDICO QUE ACONTECE AO IMPORTAR ITENS COM TINTA DE MÁQUINA NO PDV! *

    exception class    : EAccessViolation
    exception message  : Access violation at address 500355BB in module 'borlndmm.dll'. Read of address 00000000.

    main thread ($2428):
    500355bb +0017 borlndmm.dll Borlndmm                               SysFreeMem
    00407078 +0004 autcom.exe   System                        54    +0 @FreeMem
    0040c83f +003f autcom.exe   System                        54    +0 @UStrAsg
    0040e3b1 +0099 autcom.exe   System                        54    +0 @CopyRecord
    01809eeb +0027 autcom.exe   untTMatrizSaldosColorantes   431    +1 TClassMatrizSaldosColorantes.GetMatrizSaldosColorantes
    02b2a55a +01ee autcom.exe   untMovIte                     75   +13 TMovIte.pGravaMovIte
    02baea25 +5101 autcom.exe   untFuncFat                 18799 +1103 TFatVenda.fGDadMovDet
    02ba5bcd +03b5 autcom.exe   untFuncFat                 16697   +65 TFatVenda.fGMovDet
    02c0532f +89e7 autcom.exe   untFuncFat                 37033 +2985 TFatVenda.fGravaArquivos
    03ad0eae +0846 autcom.exe   untImportaPAFECF             707  +136 TImportaPAFECF.pImportarDocumento
    03ad871b +012b autcom.exe   untImportaPAFECF            1408   +19 TImportaPAFECF.pImportarPrincipal
    03ad05da +0012 autcom.exe   untImportaPAFECF             549    +3 TImportaPAFECF.pImportar
    03ae2b82 +0102 autcom.exe   untImportaMovimentoPAFECF     71   +25 pImportarAutomatico
    }

    blnGravouMovIte := False;
    Try
      For intFormulacao := 0 To matrizFormulacao.Count -1 Do
        If fEmptyStr(matrizFormulacao[intFormulacao].strCodIte) Then // TESTE SÓ PRA FORÇAR A CHAMADA DA MATRIZ!
          Sleep(10);
    Except
      fltFdoItePreVen := fRetornarPrecoDeVendaDoPedido(item.strSeqDet, item.strCodIte);

      pGravaMovIteInterna( strAutInc, item.strIdePro, item.strCodIte, VS_strCodEmp,
        item.strTabPre, 'N', item.strCodAca, item.strEmpAca, item.strImpDir, item.strPromoc,item.fltQtdIte,
        'N', 0.0, item.fltDopTin, 0.0, item.strCodAbf,strTipAbf, strEstAbf, item.fltPerDesEmbFec, fltFdoItePreVen);

      blnGravouMovIte := True;
    End;

    If (Not blnGravouMovIte) Then
    Begin
      For intFormulacao := 0 To matrizFormulacao.Count -1 Do
      Begin
        fltFdoItePreVen := fRetornarPrecoDeVendaDoPedido(item.strSeqDet, matrizFormulacao[intFormulacao].strCodIte);

        pGravaMovIteInterna( strAutInc, item.strIdePro, matrizFormulacao[intFormulacao].strCodIte,
          VS_strCodEmp, item.strTabPre, matrizFormulacao[intFormulacao].strBasCol, item.strCodAca, item.strEmpAca,
          item.strImpDir, item.strPromoc, matrizFormulacao[intFormulacao].fltQtdFormula,
          matrizFormulacao[intFormulacao].strPesGra, matrizFormulacao[intFormulacao].fltEmbala, item.fltDopTin,
          item.fltQtdIte,item.strCodAbf,strTipAbf, strEstAbf, item.fltPerDesEmbFec, fltFdoItePreVen);
      End;
    End;
  End;
end;

procedure TMovIte.pGravaMovIteInterna( strAutInc,
                                       strIdePro,
                                       strCodIte,
                                       strCodEmp,
                                       strTabPre,
                                       strBasCol,
                                       strCodAca,
                                       strEmpAca,
                                       strImpDir,
                                       strPromoc: String;
                                       fltQtdIte: Double;
                                       strPesGra: String;
                                       fltEmbala: Double;
                                       fltDopTin: Double;
                                       fltQtdAdt: Double;
                                       strCodAbf: String;
                                       strTipAbf: String;
                                       strEstAbf : String;
                                       fltPerDesEmbFec: Double;
                                       fltFdoItePreVen: Double);
  Var
    qryMovIte: TUniQuery;
    qrySelect: TUniQuery;
begin
  If fEmptyStr(strTabPre) Then
    strTabPre := fatVenda.strTabPre;

  Try
    qryMovIte := fCriaQuery;
    qrySelect := fCriaQuery;

    With qryMovIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM MOVITE WHERE FALSE';
      Open;

      If (strIdePro = 'NOR') And (Not fEmptyStr(strCodAca)) Then
        pPreparaProdutoAcabado(qrySelect, strTabPre, strAutInc, strCodIte, strCodAca,
                               strEmpAca, strCodEmp, strImpDir, fltQtdIte, strCodAbf, strTipAbf, strEstAbf, fltPerDesEmbFec,
                               fltFdoItePreVen)
      Else
      begin
        pPreparaProdutoNormal(qrySelect, strTabPre, strAutInc, strCodIte, strCodEmp,
                              strBasCol, strPesGra, strImpDir, strIdePro, strPromoc,
                              fltQtdIte, fltEmbala, fltDopTin, fltQtdAdt, strCodAbf, strTipAbf, strEstAbf, fltPerDesEmbFec,
                              fltFdoItePreVen);

        If (qrySelect.IsEmpty )Then
        begin

          if (Not fEmptyStr(strBasCol)) Then
          begin
            If (Not fatVenda.Fulfillment.EhOperacaoFulfillment) Then
            Begin
              fMensagem('ATENÇÃO!', fMensagemFormulacao(strBasCol) + #13 +
                ' Favor, verifique!', ['&O k']);
              Abort;
            End
            Else
            Begin
              FreeAndNil(qryMovIte);
              FreeAndNil(qrySelect);
              Raise Exception.Create(fMensagemFormulacao(strBasCol) + #13 + ' Favor, verifique!');
            End;
          end;

        end;

      end;

      Insert;
      FieldByName('ITE_SEQGER').AsString := qrySelect.FieldByName('SEQGER').AsString;
      FieldByName('ITE_CODITE').AsString := qrySelect.FieldByName('CODITE').AsString;
      FieldByName('ITE_QTDITE').AsFloat  := qrySelect.FieldByName('QTDITE').AsFloat;
      FieldByName('ITE_PREVEN').AsFloat  := qrySelect.FieldByName('PREVEN').AsFloat;
      FieldByName('ITE_COMLIQ').AsFloat  := qrySelect.FieldByName('COMLIQ').AsFloat;
      FieldByName('ITE_PRECUS').AsFloat  := qrySelect.FieldByName('PRECUS').AsFloat;
      FieldByName('ITE_PREULT').AsFloat  := qrySelect.FieldByName('PREULT').AsFloat;
      FieldByName('ITE_IMPULT').AsFloat  := qrySelect.FieldByName('IMPULT').AsFloat;
      FieldByName('ITE_PREMED').AsFloat  := qrySelect.FieldByName('PREMED').AsFloat;
      FieldByName('ITE_OUTVAL').AsFloat  := qrySelect.FieldByName('OUTVAL').AsFloat;
      FieldByName('ITE_IMPFED').AsFloat  := qrySelect.FieldByName('IMPFED').AsFloat;
      FieldByName('ITE_DESOPE').AsFloat  := qrySelect.FieldByName('DESOPE').AsFloat;
      FieldByName('ITE_ICMSAI').AsFloat  := qrySelect.FieldByName('ICMSAI').AsFloat;
      FieldByName('ITE_BASCOL').AsString := qrySelect.FieldByName('BASCOL').AsString;
      FieldByName('ITE_CNV_ML').AsFloat  := qrySelect.FieldByName('CNV_ML').AsFloat;
      FieldByName('ITE_PREVE1').AsFloat  := qrySelect.FieldByName('PREVE1').AsFloat;
      FieldByName('ITE_PREVE2').AsFloat  := qrySelect.FieldByName('PREVE2').AsFloat;
      FieldByName('ITE_PREVE3').AsFloat  := qrySelect.FieldByName('PREVE3').AsFloat;
      FieldByName('ITE_PREVE4').AsFloat  := qrySelect.FieldByName('PREVE4').AsFloat;
      FieldByName('ITE_PREVE5').AsFloat  := qrySelect.FieldByName('PREVE5').AsFloat;
      FieldByName('ITE_PREVE6').AsFloat  := qrySelect.FieldByName('PREVE6').AsFloat;
      FieldByName('ITE_PREVE7').AsFloat  := qrySelect.FieldByName('PREVE7').AsFloat;
      FieldByName('ITE_PESGRA').AsString := qrySelect.FieldByName('PESGRA').AsString;
      FieldByName('ITE_EMBALA').AsFloat  := qrySelect.FieldByName('EMBALA').AsFloat;
      FieldByName('ITE_SALDOS').AsFloat  := qrySelect.FieldByName('SALDOS').AsFloat;
      FieldByName('ITE_SAL_ML').AsFloat  := qrySelect.FieldByName('SAL_ML').AsFloat;
      FieldByName('ITE_ESTABF').AsString := qrySelect.FieldByName('ESTABF').AsString;
      FieldByName('ITE_CODABF').AsString := qrySelect.FieldByName('CODABF').AsString;
      FieldByName('ITE_TIPABF').AsString := qrySelect.FieldByName('TIPABF').AsString;

      FieldByName('ITE_PERDES_EMBFEC').AsString := qrySelect.FieldByName('PERDES_EMBFEC').AsString;
      FieldByName('ITE_PREFDO').AsFloat := qrySelect.FieldByName('PREFDO').AsFloat;


      FieldByName('ITE_CAT17_C17MOD').AsInteger   := qrySelect.FieldByName('CAT17_C17MOD').AsInteger;

      If Not fEmptyStr(qrySelect.FieldByName('CAT17_CODSIT').AsString) Then
        FieldByName('ITE_CAT17_CODSIT').AsString := qrySelect.FieldByName('CAT17_CODSIT').AsString
      Else
        FieldByName('ITE_CAT17_CODSIT').Value := Null;

      FieldByName('ITE_CAT17_ALQRET').AsFloat     := qrySelect.FieldByName('CAT17_ALQRET').AsFloat;
      FieldByName('ITE_CAT17_VALIVA').AsFloat     := qrySelect.FieldByName('CAT17_VALIVA').AsFloat;

      If Not fEmptyStr(qrySelect.FieldByName('CAT17_MCAT17').AsString) Then
        FieldByName('ITE_CAT17_MCAT17').AsString    := qrySelect.FieldByName('CAT17_MCAT17').AsString
      Else
        FieldByName('ITE_CAT17_MCAT17').Value    := Null;

      FieldByName('ITE_CAT17_RESTOT').AsFloat     := qrySelect.FieldByName('CAT17_RESTOT').AsFloat;

      If Not fEmptyStr(qrySelect.FieldByName('CAT17_DOCULTCOM').AsString) Then
        FieldByName('ITE_CAT17_DOCULTCOM').AsString := qrySelect.FieldByName('CAT17_DOCULTCOM').AsString
      Else
        FieldByName('ITE_CAT17_DOCULTCOM').Value := Null;

      If Not fEmptyStr(qrySelect.FieldByName('CAT17_FORULTCOM').AsString) Then
        FieldByName('ITE_CAT17_FORULTCOM').AsString := qrySelect.FieldByName('CAT17_FORULTCOM').AsString
      Else
        FieldByName('ITE_CAT17_FORULTCOM').Value := Null;

      FieldByName('ITE_QTPD_V').AsFloat  := qrySelect.FieldByName('QTPD_V').AsFloat;
      FieldByName('ITE_QTPD_F').AsFloat  := qrySelect.FieldByName('QTPD_F').AsFloat;
      FieldByName('ITE_QTPD_E').AsFloat  := qrySelect.FieldByName('QTPD_E').AsFloat;
      FieldByName('ITE_QTEF_A').AsFloat  := qrySelect.FieldByName('QTEF_A').AsFloat;
      FieldByName('ITE_QTEF_F').AsFloat  := qrySelect.FieldByName('QTEF_F').AsFloat;
      FieldByName('ITE_QTEF_P').AsFloat  := qrySelect.FieldByName('QTEF_P').AsFloat;
      FieldByName('ITE_QTPD_P').AsFloat  := qrySelect.FieldByName('QTPD_P').AsFloat;
      FieldByName('ITE_REPAUD').AsString := qrySelect.FieldByName('REPAUD').AsString;
      FieldByName('ITE_SALREG').AsFloat  := qrySelect.FieldByName('SALREG').AsFloat;

      If Assigned(qrySelect.FindField('ITE_MARBR1')) Then
      Begin
        FieldByName('ITE_MARBR1').AsFloat  := qrySelect.FieldByName('ITE_MARBR1').AsFloat;
        FieldByName('ITE_MARBR2').AsFloat  := qrySelect.FieldByName('ITE_MARBR2').AsFloat;
        FieldByName('ITE_MARBR3').AsFloat  := qrySelect.FieldByName('ITE_MARBR3').AsFloat;
        FieldByName('ITE_MARBR4').AsFloat  := qrySelect.FieldByName('ITE_MARBR4').AsFloat;
        FieldByName('ITE_MARBR5').AsFloat  := qrySelect.FieldByName('ITE_MARBR5').AsFloat;
        FieldByName('ITE_MARBR6').AsFloat  := qrySelect.FieldByName('ITE_MARBR6').AsFloat;
        FieldByName('ITE_MARBR7').AsFloat  := qrySelect.FieldByName('ITE_MARBR7').AsFloat;
      End;

      Post;
    End;
  Finally
    FreeAndNil(qryMovIte);
    FreeAndNil(qrySelect);
  End;
end;

class procedure TMovIte.pParticionaMovIteEntregaFutura(strAutIncAtu, strAutIncNov: String; fltQtdPar: Double);
  Var
    intIndice   : Integer;
    qryMovIteAnt: TUniQuery;
    qryMovIteNov: TUniQuery;
begin

  qryMovIteAnt := fCriaQuery;
  qryMovIteNov := fCriaQuery;

  qryMovIteAnt.Sql.Clear;
  qryMovIteAnt.Sql.Text := 'SELECT * FROM MOVITE WHERE ITE_SEQGER = :AUTINC';
  qryMovIteAnt.ParamByName('AUTINC').AsString := strAutIncAtu;
  qryMovIteAnt.Open;

  If (qryMovIteAnt.RecordCount = 1) Then
  Begin
    qryMovIteNov.Sql.Clear;
    qryMovIteNov.Sql.Text := 'SELECT * FROM MOVITE WHERE FALSE';
    qryMovIteNov.Open;

    qryMovIteNov.Insert;

    For intIndice := 0 To qryMovIteAnt.Fields.Count - 1 Do
      qryMovIteNov.Fields[intIndice].Value := qryMovIteAnt.Fields[intIndice].Value;

    qryMovIteNov.FieldByName('ITE_SEQGER').AsString := strAutIncNov;
    qryMovIteNov.FieldByName('ITE_QTDITE').AsFloat  := fltQtdPar;

    qryMovIteNov.Post;

    qryMovIteAnt.Edit;    
    qryMovIteAnt.FieldByName('ITE_QTDITE').AsFloat  := qryMovIteAnt.FieldByName('ITE_QTDITE').AsFloat - fltQtdPar;
    qryMovIteAnt.Post;    
  End;

  FreeAndNil(qryMovIteAnt);
  FreeAndNil(qryMovIteNov);
end;

procedure TMovIte.pPreparaProdutoAcabado(var qrySelect: TUniQuery; strTabPre,
  strAutInc, strCodIte, strCodAca, strEmpAca, strCodEmp, strImpDir: String;
  fltQtdIte: Double; strCodAbf, strTipAbf, strEstAbf : String; fltPerDesEmbFec: Double;
  fltFdoItePreVen: Double);
Var
  qryQtd: TUniQuery;
  fltSaldos: Double;
  strSQL: String;
begin
  qryQtd := fCriaQuery(nil, FobjCriarConexao.objConexao);
  try
    qryQtd.SQL.Text :=
      ' SELECT ' +
      ' ACA_SALDOS ' +
      ' FROM       ' +
      '   ACAGER   ' +
      ' WHERE      ' +
      '   ACA_CODACA = :CODACA AND ' +
      '   ACA_CODEMP = :EMPACA AND ' +
      '   ACA_EMPEST = :CODEMP     ' ;
    qryQtd.ParamByName('CODACA').AsString := strCodAca;
    qryQtd.ParamByName('EMPACA').AsString := strEmpAca;
    qryQtd.ParamByName('CODEMP').AsString := strCodEmp;
    qryQtd.Open;
    fltSaldos := qryQtd.FieldByName('ACA_SALDOS').AsFloat;
  finally
    qryQtd.Free;
  end;

  With qrySelect Do
  Begin
    Close;

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  :AUTINC    AS SEQGER, ';
    strSQL := strSQL + '  :CODITE    AS CODITE, ';
    strSQL := strSQL + '  :QTDITE    AS QTDITE, ';

    If fatVenda.blnCliFil Then
      strSQL := strSQL + '  :PREVEN AS PREVEN, '
    Else
      strSQL := strSQL + '  ACA_PREVE' + strTabPre + ' AS PREVEN, ';

    strSQL := strSQL + '  ACA_COMLIQ AS COMLIQ, ';
    strSQL := strSQL + '  ACA_PRECUS AS PRECUS, ';
    strSQL := strSQL + '  ACA_PREULT AS PREULT, ';
    strSQL := strSQL + '  ACA_IMPULT AS IMPULT, ';
    strSQL := strSQL + '  ACA_PREMED AS PREMED, ';
    strSQL := strSQL + '  ACA_OUTVAL AS OUTVAL, ';
    strSQL := strSQL + '  ACA_IMPFED / ACA_PREVEN * 100 AS IMPFED, ';
    strSQL := strSQL + '  ACA_DESOPE / ACA_PREVEN * 100 AS DESOPE, ';
    If fCfgSis('IMPCF4') = 'S' Then
      strSQL := strSQL + '  :ICMSAI AS ICMSAI, '
    Else
      strSQL := strSQL + '  (ACA_ICMSAI / ACA_PREVEN * 100) AS ICMSAI, ';
    strSQL := strSQL + '  "A"        AS BASCOL, ';
    strSQL := strSQL + '  0.0        AS CNV_ML, ';
    strSQL := strSQL + '  ACA_PREVE1 AS PREVE1, ';
    strSQL := strSQL + '  ACA_PREVE2 AS PREVE2, ';
    strSQL := strSQL + '  ACA_PREVE3 AS PREVE3, ';
    strSQL := strSQL + '  ACA_PREVE4 AS PREVE4, ';
    strSQL := strSQL + '  ACA_PREVE5 AS PREVE5, ';
    strSQL := strSQL + '  ACA_PREVE6 AS PREVE6, ';
    strSQL := strSQL + '  ACA_PREVE7 AS PREVE7, ';
    strSQL := strSQL + '  :SALDOS    AS SALDOS, ';
    strSQL := strSQL + '  0.0 AS SAL_ML, ';
    strSQL := strSQL + '  "N"        AS PESGRA, ';
    strSQL := strSQL + '  0.0        AS EMBALA, ';

    strSQL := strSQL + '  0          AS CAT17_C17MOD, ';
    strSQL := strSQL + '  ""         AS CAT17_CODSIT, ';
    strSQL := strSQL + '  0.0        AS CAT17_ALQRET, ';
    strSQL := strSQL + '  0.0        AS CAT17_VALIVA, ';
    strSQL := strSQL + '  ""         AS CAT17_MCAT17, ';
    strSQL := strSQL + '  0.0        AS CAT17_RESTOT, ';
    strSQL := strSQL + '  ""         AS CAT17_DOCULTCOM, ';
    strSQL := strSQL + '  ""         AS CAT17_FORULTCOM, ';

    strSQL := strSQL + '  0.0        AS EMBALA, ';

    strSQL := strSQL + '  :CODABF AS CODABF,  ';
    strSQL := strSQL + '  :TIPABF AS TIPABF,  ';
    strSQL := strSQL + '  :ESTABF AS ESTABF,  ';
    strSQL := strSQL + '  :PERDES_EMBFEC AS PERDES_EMBFEC,  ';
    strSQL := strSQL + '  :PREFDO AS PREFDO, ';

    strSQL := strSQL + '  0.0 AS QTPD_V, ';
    strSQL := strSQL + '  0.0 AS QTPD_F, ';
    strSQL := strSQL + '  0.0 AS QTPD_E, ';
    strSQL := strSQL + '  0.0 AS QTEF_A, ';
    strSQL := strSQL + '  0.0 AS QTEF_F, ';
    strSQL := strSQL + '  0.0 AS QTEF_P, ';
    strSQL := strSQL + '  0.0 AS QTPD_P, ';
    strSQL := strSQL + '  "N" AS REPAUD, ';
    strSQL := strSQL + '  0.0 AS SALREG  ';

    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  ACAGER      ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  ACA_CODACA = :CODACA AND ';
    strSQL := strSQL + '  ACA_CODEMP = :EMPACA AND ';
    strSQL := strSQL + '  ACA_EMPEST = :CODEMP     ';

    SQL.Text := strSQL;

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODACA').AsString := strCodAca;
    ParamByName('EMPACA').AsString := strEmpAca;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('QTDITE').AsFloat  := fltQtdIte;
    ParamByName('CODABF').AsString := strCodAbf;
    ParamByName('TIPABF').AsString := strTipAbf;
    ParamByName('ESTABF').AsString := strEstAbf;
    ParamByName('PERDES_EMBFEC').AsFloat  := fltPerDesEmbFec;
    ParamByName('SALDOS').AsFloat  := fltSaldos;
    ParamByName('PREFDO').AsFloat  := fltFdoItePreVen;

    If fCfgSis('IMPCF4') = 'S' Then
      ParamByName('ICMSAI').AsFloat := fatVenda.fCalculaAliquota(strCodIte, strCodEmp, strImpDir);

    If fatVenda.blnCliFil Then
    Begin
      ParamByName('PREVEN').AsFloat := fRetornaPrecoClienteFilial(strCodAca, strEmpAca, 'ACA', strCodEmp);
    End;

    Open;
  End;
end;

//Obs: CT = Catalisador Advance Tintosystems;
//fltQtdAdt = Quantidade do Catalisador(Mesma quandidade da Base)
procedure TMovIte.pPreparaProdutoNormal(var qrySelect: TUniQuery; strTabPre,
  strAutInc, strCodIte, strCodEmp, strBasCol, strPesGra, strImpDir, strIdePro,
  strPromoc: String; fltQtdIte, fltEmbala: Double; fltDopTin: Double;
  fltQtdAdt: Double; strCodAbf, strTipAbf, strEstAbf : String; fltPerDesEmbFec: Double;
  fltFdoItePreVen: Double);

  function fComLiq: String;
  Begin
    Result := '';

    Result := Result + '  I.ITE_PRECOM * ';
    Result := Result + '            (1 - I.ITE_DESF01 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF02 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF03 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF04 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF05 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF06 / 100)   ';
  End;

  function fAlias(intPosicao: Integer): String;
  Begin
    Case intPosicao Of
      1 : Result := 'PREVE1';
      2 : Result := 'PREVE2';
      3 : Result := 'PREVE3';
      4 : Result := 'PREVE4';
      5 : Result := 'PREVE5';
      6 : Result := 'PREVE6';
      7 : Result := 'PREVE7';
    End;
  End;

Var
  fltPreCusPro, fltPreVenPro: Double;
  intCont: Integer;
  qryQtd: TUniQuery;
  strSQL: String;
  fltSaldos, fltSalMl: Double;
begin
  fltPreCusPro := 0;
  fltPreVenPro := 0;

  qryQtd := fCriaQuery(nil, FobjCriarConexao.objConexao);
  try
    qryQtd.SQL.Text :=
      'SELECT ' +
      '  I.ITE_SALDOS AS SALDOS, ' +
      '  I.ITE_SAL_ML AS SAL_ML  ' +
      'FROM  ' +
      '  CADITE C  ' +
      '  INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE  ' +
      'WHERE  ' +
      '  I.ITE_CODITE = :CODITE AND ' +
      '  I.ITE_CODEMP = :CODEMP     ';
    qryQtd.ParamByName('CODITE').AsString := strCodIte;
    qryQtd.ParamByName('CODEMP').AsString := strCodEmp;
    qryQtd.Open;
    fltSaldos := qryQtd.FieldByName('SALDOS').AsFloat;
    fltSalMl  := qryQtd.FieldByName('SAL_ML').AsFloat;
  finally
    qryQtd.Free;
  end;

  With qrySelect Do
  Begin
    Close;

    strSQL := '';
    strSQL := strSQL + 'SELECT          ';
    strSQL := strSQL + '  :AUTINC AS SEQGER,      ';
    strSQL := strSQL + '  :CODITE AS CODITE,      ';
    strSQL := strSQL + '  :QTDITE AS QTDITE,      ';

    If (fatVenda.blnCliFil) And (Pos(fatVenda.strOpcDoc,'UC_BR_') = 0)  Then
      strSQL := strSQL + '  :PREVEN AS PREVEN, '
    Else If (fatVenda.strOpcDoc = 'BR') Then
      case fCfgSis('SUG_BR', varInteger) of
        1:strSQL := strSQL + '  IF(:CUSPRO = 0, I.ITE_PRECUS, :CUSPRO) AS PREVEN, ';
        2:strSQL := strSQL + '  IF(:PREPRO = 0, I.ITE_PREVE' + strTabPre + ', :PREPRO) AS PREVEN, ';
        3:strSQL := strSQL + '  I.ITE_PREULT AS PREVEN, ';
        4:strSQL := strSQL + '  I.ITE_IMPULT AS PREVEN, ';
      else
        strSQL := strSQL + '  IF(:CUSPRO = 0, I.ITE_PRECUS, :CUSPRO) AS PREVEN, ';
      end
    Else
      strSQL := strSQL + '  IF(:PREPRO = 0, I.ITE_PREVE' + strTabPre + ', :PREPRO) AS PREVEN, ';

    //Foi feito dessa forma por causa do arredondamento do MySQL (tem um bug)
    strSQL := strSQL + fRoundSql(fComLiq, fCfgSis('DECUNI')) + ' AS COMLIQ, ';

    strSQL := strSQL + '  IF(:CUSPRO = 0, I.ITE_PRECUS, :CUSPRO) AS PRECUS, ';

    strSQL := strSQL + '  I.ITE_PREULT AS PREULT, ';
    strSQL := strSQL + '  I.ITE_IMPULT AS IMPULT, ';
    strSQL := strSQL + '  I.ITE_PREMED AS PREMED, ';
    strSQL := strSQL + '  I.ITE_OUTVAL AS OUTVAL, ';
    strSQL := strSQL + '  I.ITE_IMPFED AS IMPFED, ';
    strSQL := strSQL + '  :SALDOS      AS SALDOS, ';
    strSQL := strSQL + '  :SAL_ML      AS SAL_ML, ';

    //Despesa operacional será somada desesp do cliente e da tinta se for o caso;
    If strIdePro <> 'NOR' Then
      strSQL := strSQL + '  (I.ITE_DESOPE + :DOPCLI + :DOPTIN) AS DESOPE, '
    Else
      strSQL := strSQL + '  (I.ITE_DESOPE + :DOPCLI) AS DESOPE, ';

    If fCfgSis('IMPCF4') = 'S' Then
      strSQL := strSQL + '  :ICMSAI AS ICMSAI, '
    Else
      strSQL := strSQL + '  I.ITE_ICMSAI AS ICMSAI, ';

    strSQL := strSQL + '  :BASCOL      AS BASCOL, ';
    strSQL := strSQL + '  C.ITE_CNV_ML AS CNV_ML, ';

    If strIdePro = 'NOR' Then
    Begin
      strSQL := strSQL + '  I.ITE_PREVE1 AS PREVE1, ';
      strSQL := strSQL + '  I.ITE_PREVE2 AS PREVE2, ';
      strSQL := strSQL + '  I.ITE_PREVE3 AS PREVE3, ';
      strSQL := strSQL + '  I.ITE_PREVE4 AS PREVE4, ';
      strSQL := strSQL + '  I.ITE_PREVE5 AS PREVE5, ';
      strSQL := strSQL + '  I.ITE_PREVE6 AS PREVE6, ';
      strSQL := strSQL + '  I.ITE_PREVE7 AS PREVE7, ';
    End
    Else
    Begin
      //Quando tinta gravar desse forma por causa do acager que faz a mesma verificacao
      //Utilizado no registro 000020 da auditoria
      For intCont := 1 To Length(VS_strTabVen) Do
      Begin
        If VS_strTabVen[intCont] = 'S' then
          strSQL := strSQL + '  I.ITE_PREVE' + IntToStr(intCont) + ' AS ' + fAlias(intCont) + ', '
        Else
          strSQL := strSQL + '  I.ITE_PREVE' + strTabPre + ' AS ' + fAlias(intCont) + ', ';
      End;
    End;

    strSQL := strSQL + '  :PESGRA AS PESGRA,      ';
    strSQL := strSQL + '  :EMBALA AS EMBALA,      ';

    strSQL := strSQL + '  :CAT17_C17MOD AS CAT17_C17MOD, ';
    strSQL := strSQL + '  :CAT17_CODSIT AS CAT17_CODSIT, ';
    strSQL := strSQL + '  :CAT17_ALQRET AS CAT17_ALQRET, ';
    strSQL := strSQL + '  :CAT17_VALIVA AS CAT17_VALIVA, ';
    strSQL := strSQL + '  :CAT17_MCAT17 AS CAT17_MCAT17, ';
    strSQL := strSQL + '  :CAT17_RESTOT AS CAT17_RESTOT, ';
    strSQL := strSQL + '  :CAT17_DOCULTCOM AS CAT17_DOCULTCOM, ';
    strSQL := strSQL + '  :CAT17_FORULTCOM AS CAT17_FORULTCOM, ';

    strSQL := strSQL + '  :EMBALA AS EMBALA,      ';
    strSQL := strSQL + '  :CODABF AS CODABF,  ';
    strSQL := strSQL + '  :TIPABF AS TIPABF,  ';
    strSQL := strSQL + '  :ESTABF AS ESTABF,  ';
    strSQL := strSQL + '  :PERDES_EMBFEC AS PERDES_EMBFEC,   ';
    strSQL := strSQL + '  :PREFDO AS PREFDO,   ';

    strSQL := strSQL + '  I.ITE_QTPD_V AS QTPD_V, ';
    strSQL := strSQL + '  I.ITE_QTPD_F AS QTPD_F, ';
    strSQL := strSQL + '  I.ITE_QTPD_E AS QTPD_E, ';
    strSQL := strSQL + '  I.ITE_QTEF_A AS QTEF_A, ';
    strSQL := strSQL + '  I.ITE_QTEF_F AS QTEF_F, ';
    strSQL := strSQL + '  I.ITE_QTEF_P AS QTEF_P, ';
    strSQL := strSQL + '  I.ITE_QTPD_P AS QTPD_P, ';
    strSQL := strSQL + '  I.ITE_REPAUD AS REPAUD, ';
    strSQL := strSQL + '  I.ITE_SALREG AS SALREG, ';
    strSQL := strSQL + '  I.ITE_MARBR1 AS ITE_MARBR1,  ';
    strSQL := strSQL + '  I.ITE_MARBR2 AS ITE_MARBR2, ';
    strSQL := strSQL + '  I.ITE_MARBR3 AS ITE_MARBR3, ';
    strSQL := strSQL + '  I.ITE_MARBR4 AS ITE_MARBR4, ';
    strSQL := strSQL + '  I.ITE_MARBR5 AS ITE_MARBR5, ';
    strSQL := strSQL + '  I.ITE_MARBR6 AS ITE_MARBR6, ';
    strSQL := strSQL + '  I.ITE_MARBR7 AS ITE_MARBR7  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE C ';
    strSQL := strSQL + '  INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  I.ITE_CODEMP = :CODEMP     ';

    SQL.Text := strSQL;

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('BASCOL').AsString := strBasCol;
    ParamByName('QTDITE').AsFloat  := IIF(strBasCol = 'CT',fltQtdAdt,fltQtdIte);
    ParamByName('PESGRA').AsString := strPesGra; //Campo utilizado pela Axalta
    ParamByName('EMBALA').AsFloat  := fltEmbala; //Campo utilizado pela Axalta

    ParamByName('CODABF').AsString := strCodAbf;
    ParamByName('TIPABF').AsString := strTipAbf;
    ParamByName('ESTABF').AsString := strEstAbf;
    ParamByName('PERDES_EMBFEC').AsFloat  := fltPerDesEmbFec;
    ParamByName('SALDOS').AsFloat  := fltSaldos;
    ParamByName('SAL_ML').AsFloat  := fltSalMl;
    ParamByName('PREFDO').AsFloat  := fltFdoItePreVen;


    ParamByName('DOPCLI').AsFloat  := fatVenda.fltDesOpeCli;
    If strIdePro <> 'NOR' Then
      ParamByName('DOPTIN').AsFloat := fltDopTin;

    If fCfgSis('IMPCF4') = 'S' Then
      ParamByName('ICMSAI').AsFloat := fatVenda.fCalculaAliquota(strCodIte, strCodEmp, strImpDir);

    If (fatVenda.blnCliFil) And (Pos(fatVenda.strOpcDoc,'UC_BR_') = 0) Then
    Begin
      ParamByName('PREVEN').AsFloat  := fRetornaPrecoClienteFilial(strCodIte, strCodEmp);
      ParamByName('CUSPRO').AsFloat  := 0;
    End
    Else
    Begin
      If fCarregaPromocao(strIdePro, strCodIte, strTabPre, strPromoc, fltQtdIte, fltPreCusPro, fltPreVenPro) Then
      Begin
        If (fatVenda.strOpcDoc = 'BR') Then
          case fCfgSis('SUG_BR', varInteger) of
            1:ParamByName('CUSPRO').AsFloat  := IIF(fltPreCusPro > 0, fltPreCusPro, 0);
            2:Begin
                ParamByName('PREPRO').AsFloat  := fltPreVenPro;
                ParamByName('CUSPRO').AsFloat  := IIF(fltPreCusPro > 0, fltPreCusPro, 0);
              End;
          else
            ParamByName('CUSPRO').AsFloat  := IIF(fltPreCusPro > 0, fltPreCusPro, 0);
          end
        Else
        Begin
          ParamByName('PREPRO').AsFloat  := fltPreVenPro;
          ParamByName('CUSPRO').AsFloat  := IIF(fltPreCusPro > 0, fltPreCusPro, 0);
        End;
      End
      Else
      Begin
        If (fatVenda.strOpcDoc = 'BR') Then
          case fCfgSis('SUG_BR', varInteger) of
            1:ParamByName('CUSPRO').AsFloat  := 0;
            2:Begin
                ParamByName('PREPRO').AsFloat  := 0;
                ParamByName('CUSPRO').AsFloat  := 0;
              End;
          else
            ParamByName('CUSPRO').AsFloat  := 0;
          end
        Else
        Begin
          ParamByName('PREPRO').AsFloat  := 0;
          ParamByName('CUSPRO').AsFloat  := 0;
        End;
      End;
    End;

    If fExistirReducaoRessarcimentoCAT(strCodIte, strIdePro) Then
    Begin
      ParamByName('CAT17_C17MOD').AsInteger   := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_C17MOD').AsInteger;
      ParamByName('CAT17_CODSIT').AsString    := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_CODSIT').AsString;
      ParamByName('CAT17_ALQRET').AsFloat     := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_ALQRET').AsFloat;
      ParamByName('CAT17_VALIVA').AsFloat     := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_VALIVA').AsFloat;
      ParamByName('CAT17_MCAT17').AsString    := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_MCAT17').AsString;
      ParamByName('CAT17_RESTOT').AsFloat     := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_RESTOT').AsFloat;
      ParamByName('CAT17_DOCULTCOM').AsString := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_DOCULTCOM').AsString;
      ParamByName('CAT17_FORULTCOM').AsString := FAuditoriaCat17.GetCdsAuditoriaCat17.FieldByName('ITE_CAT17_FORULTCOM').AsString;
    End
    Else
    Begin
      ParamByName('CAT17_C17MOD').AsInteger   := 0;
      ParamByName('CAT17_CODSIT').AsString    := '';
      ParamByName('CAT17_ALQRET').AsFloat     := 0;
      ParamByName('CAT17_VALIVA').AsFloat     := 0;
      ParamByName('CAT17_MCAT17').AsString    := '';
      ParamByName('CAT17_RESTOT').AsFloat     := 0;
      ParamByName('CAT17_DOCULTCOM').AsString := '';
      ParamByName('CAT17_FORULTCOM').AsString := '';
    End;

    Open;
  End;
end;

constructor TMovIte.Create(objVenda: TFatVenda; objAuditoriaCat17: IAuditoriaCat17; objFdoIte: IFdoIte);
begin
  inherited Create;
  fatVenda := objVenda;
  FAuditoriaCat17 := objAuditoriaCat17;
  FobjCriarConexao := TCriarConexao.Create('TMovIte.Create');
  FFdoIte := objFdoIte;
end;

destructor TMovIte.Destroy;
begin
  FobjCriarConexao.Free;
  inherited;
end;

function TMovIte.fCarregaPromocao( strIdePro, strCodIte, strTabPre, strPromoc: String; fltQtdIte: Double;
  Var fltPreCus, fltPreVen: Double ): Boolean;
  Var
    fltComVar,
    fltComAta,
    fltComDis,
    fltQtdDis,
    fltDesF07: Double;
    blnParticiona,
    blnPromo: Boolean;
    strComPro,
    strCodPro: String;
begin
  Result := False;
  
  If (strIdePro = 'NOR') And (strPromoc <> 'S') Then
    Exit;
    
  If fEmptyStr(strTabPre) Then
    strTabPre := fatVenda.strTabPre;

  blnParticiona := False;
  blnPromo      := False;

  Result := Not fatVenda.blnCliFil And
               (fatVenda.fItemPassivelDeVerificacaoPromo(strCodIte, VS_strCodEmp)) And
                fRetornaPrecosPromocao(strCodIte, fatVenda.strCodCli, VS_Date,
                                       fltQtdIte, 0, 0,
                                       fatVenda.intPrzMed, fltPreCus, fltPreVen,
                                       fltComVar, fltComAta, fltComDis, fltQtdDis, fltDesF07, strComPro,
                                       strCodPro, blnParticiona,
                                       blnPromo, strTabPre, fatVenda.strCodCnd,
                                       '', '', (strIdePro = 'NOR'), False, '-1',
                                       False, False, '', '',
                                       fatVenda.strNumOrc,
                                       fatVenda.strEspOrc);
  If blnParticiona Then
    Result := False;
end;

function TMovIte.fExistirReducaoRessarcimentoCAT(strCodIte,
  strIdePro: String): Boolean;
begin
  Result := False;

  If Not Assigned(FAuditoriaCat17) Then
    Exit;

  If (strIdePro <> 'NOR') Then
    Exit;

  If (Pos(fCfgSis('MCAT17'),'D_A_C_M_') <= 0) Then
    Exit;

  If Not FAuditoriaCat17.GetCdsAuditoriaCat17.Locate('ITE_CAT17_CODITE', strCodIte, []) Then
    Exit;

  Result := True;
end;

function TMovIte.fMensagemFormulacao(strBasCol: String): String;
var
  strMens: String;
begin
  strMens := 'não possui item vinculado ou está em duplicidade.' ;
  Result  := 'A Base ou Colorante não possui item vinculado ou está em duplicidade.';

  If strBasCol = BASE_AUTOMOTIVA  Then Result := 'A Base Automotiva ' + strMens;
  If strBasCol = EMBALAGEM        Then Result := 'A Embalagem ' + strMens;
  If strBasCol = BASE_IMOBILIARIA Then Result := 'A Base Imobiliária ' + strMens;
  If strBasCol = COLORANTE        Then Result := 'O Colorante ' + strMens;
  If strBasCol = CATALISADOR      Then Result := 'O Catalisador ' + strMens;
end;

function TMovIte.fRetornaPrecoClienteFilial(strCodIte,
  strCodEmp: String; strIdePro: String = 'NOR'; strEmpEst: String = ''): Double;
var
  qryIteGer: TUniQuery;
  strSQL: string;
begin
  Try
    qryIteGer := fCriaQuery;

    With qryIteGer Do
    Begin
      Close;

      If strIdePro = 'ACA' Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT  ';
        strSQL := strSQL + '  ACA_PREVE1 AS ITE_PREVE1, ';
        strSQL := strSQL + '  ACA_PREVE2 AS ITE_PREVE2, ';
        strSQL := strSQL + '  ACA_PREVE3 AS ITE_PREVE3, ';
        strSQL := strSQL + '  ACA_PREVE4 AS ITE_PREVE4, ';
        strSQL := strSQL + '  ACA_PREVE5 AS ITE_PREVE5, ';
        strSQL := strSQL + '  ACA_PREVE6 AS ITE_PREVE6, ';
        strSQL := strSQL + '  ACA_PREVE7 AS ITE_PREVE7, ';
        strSQL := strSQL + '  ACA_PRECUS AS ITE_PRECUS, ';
        strSQL := strSQL + '  ACA_PREULT AS ITE_PREULT, ';
        strSQL := strSQL + '  ACA_IMPULT AS ITE_IMPULT, ';
        strSQL := strSQL + '  ACA_PREMED AS ITE_MEDSIC, ';
        strSQL := strSQL + '  ACA_PREMED AS ITE_PREMED  ';
        strSQL := strSQL + 'FROM                        ';
        strSQL := strSQL + '  ACAGER                    ';
        strSQL := strSQL + 'WHERE                       ';
        strSQL := strSQL + '  ACA_CODACA = :CODACA AND  ';
        strSQL := strSQL + '  ACA_CODEMP = :EMPACA AND  ';
        strSQL := strSQL + '  ACA_EMPEST = :CODEMP      ';

        SQL.Text := strSQL;

        ParamByName('CODACA').AsString := strCodIte;
        ParamByName('EMPACA').AsString := strCodEmp;
        ParamByName('CODEMP').AsString := strEmpEst;
      End
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT  ';
        strSQL := strSQL + '   I.ITE_PREVE1, ';
        strSQL := strSQL + '   I.ITE_PREVE2, ';
        strSQL := strSQL + '   I.ITE_PREVE3, ';
        strSQL := strSQL + '   I.ITE_PREVE4, ';
        strSQL := strSQL + '   I.ITE_PREVE5, ';
        strSQL := strSQL + '   I.ITE_PREVE6, ';
        strSQL := strSQL + '   I.ITE_PREVE7, ';
        strSQL := strSQL + '   I.ITE_PRECUS, ';
        strSQL := strSQL + '   I.ITE_PREMED, ';
        strSQL := strSQL + '   I.ITE_IMPULT, ';
        strSQL := strSQL + '   I.ITE_MEDSIC, ';
        strSQL := strSQL + '   I.ITE_PREULT ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   ITEGER I ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   I.ITE_CODITE = :CODITE AND ';
        strSQL := strSQL + '   I.ITE_CODEMP = :CODEMP     ';

        SQL.Text := strSQL;

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;
      End;
      Open;

      Result := fFormataFloat(fatVenda.fPegaPrecoSugeridoTE(qryIteGer, strCodEmp, ''), fCfgSis('DECUNI'));
    End;

  Finally
    FreeAndNil(qryIteGer);
  End;
end;

function TMovIte.fRetornarPrecoDeVendaDoPedido(const strAutIncFatDor,
  strCodIte: String): Double;
begin
  Result := 0;

  If Not Assigned(FFdoIte) Then
    Exit;

  Result := FFdoIte.fRetornarPrecoVendaItemPedido(strAutIncFatDor, strCodIte);
end;

end.
