unit untFdoIte;

interface

uses untFuncFatTypes, untFuncFat, Classes, SysUtils, Uni, System.Variants, Data.DB,
  UniClientDataSet, Core.Funcoes, untIFdoIte;

type
  TFdoIte = class(TInterfacedObject, IFdoIte)
  private
    FfatVenda: TFatVenda;
    FClientFdoIte: TUniClientDataSet;

    procedure pGravaFdoIteInterna( strAutInc,
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
                                   fltPerDesEmbFec: Double;
                                   blnAtualizarPrecos: Boolean);

      function fCarregaPromocao( strIdePro, strCodIte, strTabPre, strPromoc: String; fltQtdIte: Double;
                             Var fltPreCus, fltPreVen: Double ): Boolean;

      procedure pPreparaProdutoAcabado(Var qrySelect: TUniQuery; strTabPre, strAutInc,
                                           strCodIte, strCodAca, strEmpAca, strCodEmp,
                                           strImpDir: String; fltQtdIte: Double; fltPerDesEmbFec: Double);

      procedure pPreparaProdutoNormal(Var qrySelect: TUniQuery; strTabPre, strAutInc, strCodIte, strCodEmp,
                                          strBasCol, strPesGra, strImpDir, strIdePro, strPromoc: String;
                                          fltQtdIte, fltEmbala: Double; fltDopTin: Double;
                                          fltQtdAdt: Double; fltPerDesEmbFec: Double; 
                                          blnAtualizarPrecos: Boolean);

      function fRetornaPrecoClienteFilial(strCodIte, strCodEmp: String; strIdePro: String = 'NOR'; strEmpEst: String = ''): Double;

      function fMensagemFormulacao(strBasCol: String): String;

      procedure pCriarClientFdoIte;

      function fGetSQLPedido: String;
  public
    procedure pGravaFdoIte(strAutInc: String; item: TDadosFechamento; objVenda: TObject);
    procedure pPreencherDataSetFdoIte(strAutIncFatGor: String);
    function fRetornarPercentualDescontoEmbalagemFechada(const strAutIncFatDor: String): Double;
    function fRetornarPrecoVendaItemPedido(const strAutIncFatDor, strCodIte: String): Double;

    constructor Create;
    destructor Destroy; override;

    class function New(): IFdoIte;
  end;

implementation

uses untFuncoesSimples, untTMatrizSaldosColorantes, untCadPro;

{ TFdoIte }

constructor TFdoIte.Create;
begin
  inherited Create;
  pCriarClientFdoIte;
end;

destructor TFdoIte.Destroy;
begin
  FreeAndNil(FClientFdoIte);
  inherited;
end;

function TFdoIte.fCarregaPromocao(strIdePro, strCodIte, strTabPre,
  strPromoc: String; fltQtdIte: Double; var fltPreCus,
  fltPreVen: Double): Boolean;
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
    strTabPre := FfatVenda.strTabPre;

  blnParticiona := False;
  blnPromo      := False;

  Result := Not FfatVenda.blnCliFil And
               (FfatVenda.fItemPassivelDeVerificacaoPromo(strCodIte, VS_strCodEmp)) And
                fRetornaPrecosPromocao(strCodIte, FfatVenda.strCodCli, VS_Date,
                                       fltQtdIte, 0, 0,
                                       FfatVenda.intPrzMed, fltPreCus, fltPreVen,
                                       fltComVar, fltComAta, fltComDis, fltQtdDis, fltDesF07, strComPro,
                                       strCodPro, blnParticiona,
                                       blnPromo, strTabPre, FfatVenda.strCodCnd,
                                       '', '', (strIdePro = 'NOR'), False, '-1',
                                       False, False, '', '',
                                       FfatVenda.strNumOrc,
                                       FfatVenda.strEspOrc);
  If blnParticiona Then
    Result := False;
end;

function TFdoIte.fGetSQLPedido: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  ITE_SEQGER, ';
  Result := Result + '  ITE_CODITE, ';
  Result := Result + '  ITE_PREVEN, ';
  Result := Result + '  ITE_PREVE1, ';
  Result := Result + '  ITE_PREVE2, ';
  Result := Result + '  ITE_PREVE3, ';
  Result := Result + '  ITE_PREVE4, ';
  Result := Result + '  ITE_PREVE5, ';
  Result := Result + '  ITE_PREVE6, ';
  Result := Result + '  ITE_PREVE7, ';
  Result := Result + '  ITE_SALDOS, ';
  Result := Result + '  ITE_SAL_ML, ';
  Result := Result + '  ITE_PERDES_EMBFEC ';
  Result := Result + 'FROM ';
  Result := Result + '  FATDOR ';
  Result := Result + '  JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ';
  Result := Result + '  JOIN FDOITE ON FDOITE.ITE_SEQGER = FATDOR.AUTOINCREM ';
  Result := Result + 'WHERE ';
  Result := Result + '  FATGOR.AUTOINCREM = :AUTOINCREM ';
end;

function TFdoIte.fMensagemFormulacao(strBasCol: String): String;
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

function TFdoIte.fRetornaPrecoClienteFilial(strCodIte, strCodEmp, strIdePro,
  strEmpEst: String): Double;
var
  qryIteGer: TUniQuery;
begin
  Try
    qryIteGer := fCriaQuery;

    With qryIteGer, SQL Do
    Begin
      Close;
      Clear;

      If strIdePro = 'ACA' Then
      Begin
        Add(' SELECT  ');
        Add('  ACA_PREVE1 AS ITE_PREVE1, ');
        Add('  ACA_PREVE2 AS ITE_PREVE2, ');
        Add('  ACA_PREVE3 AS ITE_PREVE3, ');
        Add('  ACA_PREVE4 AS ITE_PREVE4, ');
        Add('  ACA_PREVE5 AS ITE_PREVE5, ');
        Add('  ACA_PREVE6 AS ITE_PREVE6, ');
        Add('  ACA_PREVE7 AS ITE_PREVE7, ');
        Add('  ACA_PRECUS AS ITE_PRECUS, ');
        Add('  ACA_PREULT AS ITE_PREULT, ');
        Add('  ACA_IMPULT AS ITE_IMPULT, ');
        Add('  ACA_PREMED AS ITE_MEDSIC, ');
        Add('  ACA_PREMED AS ITE_PREMED  ');
        Add('FROM                        ');
        Add('  ACAGER                    ');
        Add('WHERE                       ');
        Add('  ACA_CODACA = :CODACA AND  ');
        Add('  ACA_CODEMP = :EMPACA AND  ');
        Add('  ACA_EMPEST = :CODEMP      ');

        ParamByName('CODACA').AsString := strCodIte;
        ParamByName('EMPACA').AsString := strCodEmp;
        ParamByName('CODEMP').AsString := strEmpEst;
      End
      Else
      Begin
        Add(' SELECT  ');
        Add('   I.ITE_PREVE1, ');
        Add('   I.ITE_PREVE2, ');
        Add('   I.ITE_PREVE3, ');
        Add('   I.ITE_PREVE4, ');
        Add('   I.ITE_PREVE5, ');
        Add('   I.ITE_PREVE6, ');
        Add('   I.ITE_PREVE7, ');
        Add('   I.ITE_PRECUS, ');
        Add('   I.ITE_PREMED, ');
        Add('   I.ITE_IMPULT, ');
        Add('   I.ITE_MEDSIC, ');
        Add('   I.ITE_PREULT ');
        Add(' FROM ');
        Add('   ITEGER I ');
        Add(' WHERE ');
        Add('   I.ITE_CODITE = :CODITE AND ');
        Add('   I.ITE_CODEMP = :CODEMP     ');

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;
      End;
      Open;

      Result := fFormataFloat(FfatVenda.fPegaPrecoSugeridoTE(qryIteGer, strCodEmp, ''), fCfgSis('DECUNI'));
    End;

  Finally
    FreeAndNil(qryIteGer);
  End;
end;

function TFdoIte.fRetornarPercentualDescontoEmbalagemFechada(
  const strAutIncFatDor: String): Double;
begin
  Result := 0;

  If Not FClientFdoIte.Locate('ITE_SEQGER', strAutIncFatDor, []) Then
    Exit;

  Result := FClientFdoIte.FieldByName('ITE_PERDES_EMBFEC').AsFloat;
end;

function TFdoIte.fRetornarPrecoVendaItemPedido(const strAutIncFatDor,
  strCodIte: String): Double;
begin
  Result := 0;

  If fEmptyStr(strAutIncFatDor) Then
    Exit;

  FClientFdoIte.Filtered := False;
  FClientFdoIte.Filter := 'ITE_SEQGER = ' + QuotedStr(strAutIncFatDor) + ' AND ' + 'ITE_CODITE = ' + QuotedStr(strCodIte);
  FClientFdoIte.Filtered := True;

  Result := FClientFdoIte.FieldByName('ITE_PREVEN').AsFloat;
end;

class function TFdoIte.New: IFdoIte;
begin
  Result := Self.Create;
end;

procedure TFdoIte.pCriarClientFdoIte;
begin
  FClientFdoIte := TUniClientDataSet.Create(Nil);

  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_SEQGER', ftString, 20);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_CODITE', ftString, 5);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVEN', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVE1', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVE2', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVE3', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVE4', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVE5', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVE6', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PREVE7', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_SALDOS', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_SAL_ML', ftFloat);
  TCoreFuncoes.pAddFieldDefs(FClientFdoIte, 'ITE_PERDES_EMBFEC', ftFloat);

  FClientFdoIte.CreateDataSet;
  FClientFdoIte.LogChanges := False;
end;

procedure TFdoIte.pGravaFdoIte(strAutInc: String; item: TDadosFechamento; objVenda: TObject);
  Var
    intFormulacao: Integer;
    matrizFormulacao: TClassMatrizSaldosColorantes;
    blnGravouFdoIte : Boolean;
begin
  FfatVenda := objVenda as TFatVenda;

  matrizFormulacao := nil;
  With FfatVenda.dicFormulas Do
  Begin
    If Assigned(RetornaObjeto(IntToStr(item.intAutInc))) Then
      matrizFormulacao := TClassMatrizSaldosColorantes(RetornaObjeto(IntToStr(item.intAutInc)));
  End;

  If (item.strIdePro = 'NOR') Or (Not Assigned(matrizFormulacao)) Then
  Begin
    //Posicionando no registro da FDOITE
    FClientFdoIte.Filtered := False;
    FClientFdoIte.Filter := 'ITE_SEQGER = ' + QuotedStr(item.strSeqDet);
    FClientFdoIte.Filtered := True;

    pGravaFdoIteInterna( strAutInc, item.strIdePro, item.strCodIte, VS_strCodEmp,
      item.strTabPre, 'N', item.strCodAca, item.strEmpAca, item.strImpDir, item.strPromoc, item.fltQtdIte,
      'N', 0.0, item.fltDopTin, 0.0, item.fltPerDesEmbFec, item.strFdoIteRecalcPrecos = 'S')
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

    blnGravouFdoIte := False;
    Try
      For intFormulacao := 0 To matrizFormulacao.Count -1 Do
        If fEmptyStr(matrizFormulacao[intFormulacao].strCodIte) Then // TESTE SÓ PRA FORÇAR A CHAMADA DA MATRIZ!
          Sleep(10);
    Except
      //Posicionando no registro da FDOITE
      FClientFdoIte.Filtered := False;
      FClientFdoIte.Filter := 'ITE_SEQGER = ' + QuotedStr(item.strSeqDet);
      FClientFdoIte.Filtered := True;

      pGravaFdoIteInterna( strAutInc, item.strIdePro, item.strCodIte, VS_strCodEmp,
        item.strTabPre, 'N', item.strCodAca, item.strEmpAca, item.strImpDir, item.strPromoc,item.fltQtdIte,
        'N', 0.0, item.fltDopTin, 0.0, item.fltPerDesEmbFec, item.strFdoIteRecalcPrecos = 'S');

      blnGravouFdoIte := True;
    End;

    If (Not blnGravouFdoIte) Then
    Begin
      For intFormulacao := 0 To matrizFormulacao.Count -1 Do
      Begin
        FClientFdoIte.Filtered := False;
        FClientFdoIte.Filter := 'ITE_SEQGER = ' + QuotedStr(item.strSeqDet) + ' AND ' + 'ITE_CODITE = ' + QuotedStr(matrizFormulacao[intFormulacao].strCodIte);
        FClientFdoIte.Filtered := True;

        pGravaFdoIteInterna( strAutInc, item.strIdePro, matrizFormulacao[intFormulacao].strCodIte,
          VS_strCodEmp, item.strTabPre, matrizFormulacao[intFormulacao].strBasCol, item.strCodAca, item.strEmpAca,
          item.strImpDir, item.strPromoc, matrizFormulacao[intFormulacao].fltQtdFormula,
          matrizFormulacao[intFormulacao].strPesGra, matrizFormulacao[intFormulacao].fltEmbala, item.fltDopTin,
          item.fltQtdIte, item.fltPerDesEmbFec, item.strFdoIteRecalcPrecos = 'S');
      End;
    End;
  End;
end;

procedure TFdoIte.pGravaFdoIteInterna( strAutInc,
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
                                   fltPerDesEmbFec: Double;
//                                   fltPreVen: Double;
//                                   fltPreVe1: Double;
//                                   fltPreVe2: Double;
//                                   fltPreVe3: Double;
//                                   fltPreVe4: Double;
//                                   fltPreVe5: Double;
//                                   fltPreVe6: Double;
//                                   fltPreVe7: Double;
                                   blnAtualizarPrecos: Boolean);
Var
  qryFdoIte: TUniQuery;
  qrySelect: TUniQuery;
begin
  If fEmptyStr(strTabPre) Then
    strTabPre := FfatVenda.strTabPre;

  Try
    qryFdoIte := fCriaQuery;
    qrySelect := fCriaQuery;

    With qryFdoIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FDOITE WHERE FALSE');
      Open;

      If (strIdePro = 'NOR') And (Not fEmptyStr(strCodAca)) Then
        pPreparaProdutoAcabado(qrySelect, strTabPre, strAutInc, strCodIte, strCodAca,
                               strEmpAca, strCodEmp, strImpDir, fltQtdIte, fltPerDesEmbFec)
      Else
      begin
        pPreparaProdutoNormal(qrySelect, strTabPre, strAutInc, strCodIte, strCodEmp,
                              strBasCol, strPesGra, strImpDir, strIdePro, strPromoc,
                              fltQtdIte, fltEmbala, fltDopTin, fltQtdAdt, fltPerDesEmbFec, //fltPreVen,
//                              fltPreVe1, fltPreVe2, fltPreVe3, fltPreVe4, fltPreVe5, fltPreVe6, fltPreVe7,
                              blnAtualizarPrecos);

        If (qrySelect.IsEmpty )Then
        begin

          if (Not fEmptyStr(strBasCol)) Then
          begin
            If (Not FfatVenda.Fulfillment.EhOperacaoFulfillment) Then
            Begin
              fMensagem('ATENÇÃO!', fMensagemFormulacao(strBasCol) + #13 +
                ' Favor, verifique!', ['&O k']);
              Abort;
            End
            Else
            Begin
              FreeAndNil(qryFdoIte);
              FreeAndNil(qrySelect);
              Raise Exception.Create(fMensagemFormulacao(strBasCol) + #13 + ' Favor, verifique!');
            End;
          end;

        end;

      end;

      Insert;
      FieldByName('ITE_SEQGER').AsString := qrySelect.FieldByName('SEQGER').AsString;
      FieldByName('ITE_CODITE').AsString := qrySelect.FieldByName('CODITE').AsString;
      FieldByName('ITE_PREVEN').AsFloat  := qrySelect.FieldByName('PREVEN').AsFloat;
      FieldByName('ITE_PREVE1').AsFloat  := qrySelect.FieldByName('PREVE1').AsFloat;
      FieldByName('ITE_PREVE2').AsFloat  := qrySelect.FieldByName('PREVE2').AsFloat;
      FieldByName('ITE_PREVE3').AsFloat  := qrySelect.FieldByName('PREVE3').AsFloat;
      FieldByName('ITE_PREVE4').AsFloat  := qrySelect.FieldByName('PREVE4').AsFloat;
      FieldByName('ITE_PREVE5').AsFloat  := qrySelect.FieldByName('PREVE5').AsFloat;
      FieldByName('ITE_PREVE6').AsFloat  := qrySelect.FieldByName('PREVE6').AsFloat;
      FieldByName('ITE_PREVE7').AsFloat  := qrySelect.FieldByName('PREVE7').AsFloat;
      FieldByName('ITE_SALDOS').AsFloat  := qrySelect.FieldByName('SALDOS').AsFloat;
      FieldByName('ITE_SAL_ML').AsFloat  := qrySelect.FieldByName('SAL_ML').AsFloat;
      FieldByName('ITE_PERDES_EMBFEC').AsFloat := qrySelect.FieldByName('PERDES_EMBFEC').AsFloat;
      FieldByName('ITE_QTPD_V').AsFloat  := qrySelect.FieldByName('QTPD_V').AsFloat;
      FieldByName('ITE_QTPD_F').AsFloat  := qrySelect.FieldByName('QTPD_F').AsFloat;
      FieldByName('ITE_QTPD_E').AsFloat  := qrySelect.FieldByName('QTPD_E').AsFloat;
      FieldByName('ITE_QTEF_A').AsFloat  := qrySelect.FieldByName('QTEF_A').AsFloat;
      FieldByName('ITE_QTEF_F').AsFloat  := qrySelect.FieldByName('QTEF_F').AsFloat;
      FieldByName('ITE_QTEF_P').AsFloat  := qrySelect.FieldByName('QTEF_P').AsFloat;
      FieldByName('ITE_QTPD_P').AsFloat  := qrySelect.FieldByName('QTPD_P').AsFloat;
      FieldByName('ITE_REPAUD').AsString := qrySelect.FieldByName('REPAUD').AsString;
      FieldByName('ITE_SALREG').AsFloat  := qrySelect.FieldByName('SALREG').AsFloat;

      Post;
    End;
  Finally
    FreeAndNil(qryFdoIte);
    FreeAndNil(qrySelect);
  End;
end;

procedure TFdoIte.pPreencherDataSetFdoIte(strAutIncFatGor: String);
var
  qryFatDor: TUniQuery;
begin
  Try
    qryFatDor := fCriaQuery;
    qryFatDor.Close;
    qryFatDor.SQL.Clear;
    qryFatDor.SQL.Add(fGetSQLPedido);
    qryFatDor.ParamByName('AUTOINCREM').AsString := strAutIncFatGor;
    qryFatDor.Open;

    If qryFatDor.IsEmpty Then
      Exit;

    qryFatDor.First;
    While Not qryFatDor.Eof Do
    Begin
      FClientFdoIte.Append;
      FClientFdoIte.FieldByName('ITE_SEQGER').AsString := qryFatDor.FieldByName('ITE_SEQGER').AsString;
      FClientFdoIte.FieldByName('ITE_CODITE').AsString := qryFatDor.FieldByName('ITE_CODITE').AsString;
      FClientFdoIte.FieldByName('ITE_PREVEN').AsFloat  := qryFatDor.FieldByName('ITE_PREVEN').AsFloat;
      FClientFdoIte.FieldByName('ITE_PREVE1').AsFloat  := qryFatDor.FieldByName('ITE_PREVE1').AsFloat;
      FClientFdoIte.FieldByName('ITE_PREVE2').AsFloat  := qryFatDor.FieldByName('ITE_PREVE2').AsFloat;
      FClientFdoIte.FieldByName('ITE_PREVE3').AsFloat  := qryFatDor.FieldByName('ITE_PREVE3').AsFloat;
      FClientFdoIte.FieldByName('ITE_PREVE4').AsFloat  := qryFatDor.FieldByName('ITE_PREVE4').AsFloat;
      FClientFdoIte.FieldByName('ITE_PREVE5').AsFloat  := qryFatDor.FieldByName('ITE_PREVE5').AsFloat;
      FClientFdoIte.FieldByName('ITE_PREVE6').AsFloat  := qryFatDor.FieldByName('ITE_PREVE6').AsFloat;
      FClientFdoIte.FieldByName('ITE_PREVE7').AsFloat  := qryFatDor.FieldByName('ITE_PREVE7').AsFloat;
      FClientFdoIte.FieldByName('ITE_SALDOS').AsFloat  := qryFatDor.FieldByName('ITE_SALDOS').AsFloat;
      FClientFdoIte.FieldByName('ITE_SAL_ML').AsFloat  := qryFatDor.FieldByName('ITE_SAL_ML').AsFloat;
      FClientFdoIte.FieldByName('ITE_PERDES_EMBFEC').AsFloat := qryFatDor.FieldByName('ITE_PERDES_EMBFEC').AsFloat;
      FClientFdoIte.Post;

      qryFatDor.Next;
    End;

  Finally
    FreeAndNil(qryFatDor);
  End;
end;

procedure TFdoIte.pPreparaProdutoAcabado(var qrySelect: TUniQuery; strTabPre,
  strAutInc, strCodIte, strCodAca, strEmpAca, strCodEmp, strImpDir: String;
  fltQtdIte: Double; fltPerDesEmbFec: Double);
begin
  With qrySelect, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT        ');
    Add('  :AUTINC    AS SEQGER, ');
    Add('  :CODITE    AS CODITE, ');

    If FfatVenda.blnCliFil Then
      Add('  :PREVEN AS PREVEN, ')
    Else
      Add('  ACA_PREVE' + strTabPre + ' AS PREVEN, ');

    Add('  ACA_PREVE1 AS PREVE1, ');
    Add('  ACA_PREVE2 AS PREVE2, ');
    Add('  ACA_PREVE3 AS PREVE3, ');
    Add('  ACA_PREVE4 AS PREVE4, ');
    Add('  ACA_PREVE5 AS PREVE5, ');
    Add('  ACA_PREVE6 AS PREVE6, ');
    Add('  ACA_PREVE7 AS PREVE7, ');
    Add('  ACA_SALDOS AS SALDOS, ');
    Add('  0.0 AS SAL_ML, ');

    Add('  :PERDES_EMBFEC AS PERDES_EMBFEC,  ');

    Add('  0.0 AS QTPD_V, ');
    Add('  0.0 AS QTPD_F, ');
    Add('  0.0 AS QTPD_E, ');
    Add('  0.0 AS QTEF_A, ');
    Add('  0.0 AS QTEF_F, ');
    Add('  0.0 AS QTEF_P, ');
    Add('  0.0 AS QTPD_P, ');
    Add('  "N" AS REPAUD, ');
    Add('  0.0 AS SALREG  ');

    Add('FROM          ');
    Add('  ACAGER      ');
    Add('WHERE         ');
    Add('  ACA_CODACA = :CODACA AND ');
    Add('  ACA_CODEMP = :EMPACA AND ');
    Add('  ACA_EMPEST = :CODEMP     ');

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODACA').AsString := strCodAca;
    ParamByName('EMPACA').AsString := strEmpAca;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PERDES_EMBFEC').AsFloat := fltPerDesEmbFec;

    If FfatVenda.blnCliFil Then
    Begin
      ParamByName('PREVEN').AsFloat := fRetornaPrecoClienteFilial(strCodAca, strEmpAca, 'ACA', strCodEmp);
    End;

    Open;
  End;

end;

procedure TFdoIte.pPreparaProdutoNormal(Var qrySelect: TUniQuery; strTabPre, strAutInc, strCodIte, strCodEmp,
                                          strBasCol, strPesGra, strImpDir, strIdePro, strPromoc: String;
                                          fltQtdIte, fltEmbala: Double; fltDopTin: Double;
                                          fltQtdAdt: Double; fltPerDesEmbFec: Double; 
                                          blnAtualizarPrecos: Boolean);

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

  function fParametroPrecoVenda: String;
  begin
    Result := 'I.ITE_PREVE' + strTabPre;

    If blnAtualizarPrecos Then
      Exit;

    Result := ':PREVEN';
  end;

Var
  fltPreCusPro, fltPreVenPro: Double;
  intCont: Integer;
begin
  fltPreCusPro := 0;
  fltPreVenPro := 0;

  With qrySelect, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT          ');
    Add('  :AUTINC AS SEQGER,      ');
    Add('  :CODITE AS CODITE,      ');

    If (FfatVenda.blnCliFil) And (Pos(FfatVenda.strOpcDoc,'UC_BR_') = 0)  Then
      Add('  :PREVEN AS PREVEN, ')
    Else If (FfatVenda.strOpcDoc = 'BR') Then
    Begin
      case fCfgSis('SUG_BR', varInteger) of
        1:Add('  IF(:CUSPRO = 0, I.ITE_PRECUS, :CUSPRO) AS PREVEN, ');
        2:Add('  IF(:PREPRO = 0, ' + fParametroPrecoVenda + ', :PREPRO) AS PREVEN, ');
        3:Add('  I.ITE_PREULT AS PREVEN, ');
        4:Add('  I.ITE_IMPULT AS PREVEN, ');
      else
        Add('  IF(:CUSPRO = 0, I.ITE_PRECUS, :CUSPRO) AS PREVEN, ');
      end;
    End
    Else
      Add('  IF(:PREPRO = 0, ' + fParametroPrecoVenda + ', :PREPRO) AS PREVEN, ');

    If blnAtualizarPrecos Then
    Begin
      If strIdePro = 'NOR' Then
      Begin
        Add('  I.ITE_PREVE1 AS PREVE1, ');
        Add('  I.ITE_PREVE2 AS PREVE2, ');
        Add('  I.ITE_PREVE3 AS PREVE3, ');
        Add('  I.ITE_PREVE4 AS PREVE4, ');
        Add('  I.ITE_PREVE5 AS PREVE5, ');
        Add('  I.ITE_PREVE6 AS PREVE6, ');
        Add('  I.ITE_PREVE7 AS PREVE7, ');
      End
      Else
      Begin
        //Quando tinta gravar desse forma por causa do acager que faz a mesma verificacao
        //Utilizado no registro 000020 da auditoria
        For intCont := 1 To Length(VS_strTabVen) Do
        Begin
          If VS_strTabVen[intCont] = 'S' then
            Add('  I.ITE_PREVE' + IntToStr(intCont) + ' AS ' + fAlias(intCont) + ', ')
          Else
            Add('  I.ITE_PREVE' + strTabPre + ' AS ' + fAlias(intCont) + ', ');
        End;
      End;
    End
    Else
    Begin
      Add('  :PREVE1 AS PREVE1, ');
      Add('  :PREVE2 AS PREVE2, ');
      Add('  :PREVE3 AS PREVE3, ');
      Add('  :PREVE4 AS PREVE4, ');
      Add('  :PREVE5 AS PREVE5, ');
      Add('  :PREVE6 AS PREVE6, ');
      Add('  :PREVE7 AS PREVE7, ');
    End;

    Add('  I.ITE_SALDOS AS SALDOS, ');
    Add('  I.ITE_SAL_ML AS SAL_ML,  ');

    Add('  :PERDES_EMBFEC AS PERDES_EMBFEC,  ');

    Add('  I.ITE_QTPD_V AS QTPD_V, ');
    Add('  I.ITE_QTPD_F AS QTPD_F, ');
    Add('  I.ITE_QTPD_E AS QTPD_E, ');
    Add('  I.ITE_QTEF_A AS QTEF_A, ');
    Add('  I.ITE_QTEF_F AS QTEF_F, ');
    Add('  I.ITE_QTEF_P AS QTEF_P, ');
    Add('  I.ITE_QTPD_P AS QTPD_P, ');
    Add('  I.ITE_REPAUD AS REPAUD, ');
    Add('  I.ITE_SALREG AS SALREG  ');

    Add('FROM ');
    Add('  CADITE C ');
    Add('  INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ');
    Add('WHERE ');
    Add('  I.ITE_CODITE = :CODITE AND ');
    Add('  I.ITE_CODEMP = :CODEMP     ');

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PERDES_EMBFEC').AsFloat  := fltPerDesEmbFec;

    If (FfatVenda.blnCliFil) And (Pos(FfatVenda.strOpcDoc,'UC_BR_') = 0) Then
    Begin
      ParamByName('PREVEN').AsFloat  := fRetornaPrecoClienteFilial(strCodIte, strCodEmp);
//      ParamByName('CUSPRO').AsFloat  := 0;
    End
    Else
    Begin
      If fCarregaPromocao(strIdePro, strCodIte, strTabPre, strPromoc, fltQtdIte, fltPreCusPro, fltPreVenPro) Then
      Begin
        If (FfatVenda.strOpcDoc = 'BR') Then
          case fCfgSis('SUG_BR', varInteger) of
            1:ParamByName('CUSPRO').AsFloat  := IIF(fltPreCusPro > 0, fltPreCusPro, 0);
            2:Begin
                ParamByName('PREPRO').AsFloat  := fltPreVenPro;
      //          ParamByName('CUSPRO').AsFloat  := IIF(fltPreCusPro > 0, fltPreCusPro, 0);
              End;
          else
            ParamByName('CUSPRO').AsFloat  := IIF(fltPreCusPro > 0, fltPreCusPro, 0);
          end
         Else
         Begin
           ParamByName('PREPRO').AsFloat  := fltPreVenPro;
         end;
      End
      Else
      Begin
        If (FfatVenda.strOpcDoc = 'BR') Then
          case fCfgSis('SUG_BR', varInteger) of
            1:ParamByName('CUSPRO').AsFloat  := 0;
            2:Begin
                ParamByName('PREPRO').AsFloat  := 0;
      //          ParamByName('CUSPRO').AsFloat  := 0;
	            End;
          else
            ParamByName('CUSPRO').AsFloat  := 0;
	        end
	      Else
			  Begin
			    ParamByName('PREPRO').AsFloat  := 0;
        End;
      End;
    End;

    If Not blnAtualizarPrecos Then
    Begin
      ParamByName('PREVEN').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVEN').AsFloat;
      ParamByName('PREVE1').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVE1').AsFloat;
      ParamByName('PREVE2').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVE2').AsFloat;
      ParamByName('PREVE3').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVE3').AsFloat;
      ParamByName('PREVE4').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVE4').AsFloat;
      ParamByName('PREVE5').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVE5').AsFloat;
      ParamByName('PREVE6').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVE6').AsFloat;
      ParamByName('PREVE7').AsFloat  := FClientFdoIte.FieldByName('ITE_PREVE7').AsFloat;
    End;

    Open;
  End;
end;

end.
