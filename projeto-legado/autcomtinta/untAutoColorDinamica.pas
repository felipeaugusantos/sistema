unit untAutoColorDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, SysUtils,
  Controls, Math, untPnlBotoesAcoesNovaConsulta;

Type

  TfrmConsultaCompAutocolor = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaAutoColorDinamica  = class(TFormulaAutomotiva)
    protected
      stlBassesErros: TStringList;
    public
      procedure pCarregarColorantes; Override;
      procedure pCarregaPrecosBases; override;
      procedure pCalcularPrecos; Override;
      Constructor Create(blnDiluente: Boolean; strDadosAdicionais, strTabPre: String); reintroduce; overload;
  End;

  function fConsultaAutocolorGeralDinamica(Sender: TForm): String; stdcall;
  function fConsultaAutoColorVendaDinamica(Sender: TForm; qryTinta: TUniQuery; strTabPre: String): String;

  function fConsultaAutoColorDinamicaInterna(Sender: TForm; qryTinta: TUniQuery; tipoConsulta: TTipoConsulta;
    strTabPre: String): String;

  function fRetornaDescricaoAutocolorDinamica(qryTinta: TUniQuery; strDesCor: String): String;
  function fRetornaPrecoAutocolorDinamica(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;
  function fGTinForAutocolorDinamica(strIteTin: String; strTipPre: String;
            Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
            Var stlItensTraMl: TStringList; fltVolPro: Double; strCatalize: String; strLinTin: String;
            strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double; fltQtdEmb: Double): Boolean; stdcall;

  function fDigDadosTintometricos(qryCadAut: TUniQuery; stlDesEmb, stlProEmbLt,
          stlProEmbGl: TStringList; strProEmbCo, strProEmbSp, strProEmbTb, strProEmbLa: String;
          Var strIteEmb, strTipEmb, strTipPre: String; Var intQtdEmb: Integer;
          Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double;
          Var strLinTin: String; Var strCatalize: String; Var strCodDil: String;
          Var fltPorDil : Double; var strDilCon: String; Var fltPorCat: Double;
          strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProAutocolorDinamica(strTipPre: String; fltPrcTin, fltPrvTin: Double): Double;
  procedure pRecalculaFormula(Var ObjFormula: TFormulaAutomotiva; intModoVenda: Integer; fltPorDil: Double;
    strCodDil: String; strCatalisador: String; strLinha: String; Var fltPorCat: Double; fltQtdEmb: Double);
  procedure pAdicionaFormula(strCodSeq: String; var dicFormulas: TDicionario; objFormulaNova  : TFormulaAutomotiva);
  procedure pRetornaTabelaPrecoAutocolor(dicRetorno: TDicionario; fltFatorAcerto: Double);

implementation

uses untITintaDeMaquinaComponente,untGenericTintaDeMaquinaComponente,untIConsultaTinta,untAutoColorConsulta,
  untDigTintaAutomotivaAutoColor, DB, untIConfTinta,untICalculadorFatVendas,untTintaMaquina,untTintaDeMaquinaComponenteComparerBaseAutomotiva,
  untFuncoes, UniClientDataSet, untClientDataSetFactory, untGravando,untTintaDeMaquinaComponenteTipo;

var
  dicForms: TDicionario;

function fConsultaAutocolorGeralDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaAutoColorDinamicaInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
  FreeAndNil(qryGen);
end;

function fConsultaAutoColorVendaDinamica(Sender: TForm; qryTinta: TUniQuery; strTabPre: String): String;
begin
  Result := fConsultaAutoColorDinamicaInterna(Sender, qryTinta, tpcVenda, strTabPre);
end;

function fRetornaDescricaoAutocolorDinamica(qryTinta: TUniQuery; strDesCor: String): String;
begin
  Result := strDesCor;
end;

function fRetornaPrecoAutocolorDinamica(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;
  Var
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    blnUsaPreCus: Boolean;
    strTipEmb: String;
    intQtdEmb: Integer;

    strIteTin: String;
    strLinTin: String;
    strCatalize: String;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    fltPrcTin: Double;
    fltPrvTin: Double;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;
    strChaFor: String;
    strTipPre     : String;
    fltPreVen     : Double;

    stlDesEmb     : TStringList;
    stlProEmbLt   : TStringList;
    stlProEmbGl   : TStringList;

    strProEmbCo   : String;
    strProEmbSp   : String;
    strProEmbTb   : String;
    strProEmbLa   : String;

    fltVolPro     : Double;

    strCodDil     : String;
    fltPorDil     : Double;
    strDilCon     : String;
    fltPorCat     : Double;
    strTabPre     : String;

    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor : String;
    conf: IConfTinta;
begin
  Result := False;

  conf  := fGetConfTinta('AUT');

  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTipEmb    := dicRetorno['tipemb'];
  intQtdEmb    := dicRetorno['qtdemb'];
  strTabPre    := dicRetorno['tabpre'];
  
  strAuto := fConsultaAutoColorVendaDinamica(Sender, qryTinta, strTabPre);

  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  tinta := TAutoColorConsulta.Create;

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  strIteTin := fGetMd5MySql(qryTinta.FieldByName('AUT_CODIGO').AsString +
    qryTinta.FieldByName('AUT_DESCRI').AsString + qryTinta.FieldByName('AUT_REFERE').AsString +
    qryTinta.FieldByName('AUT_MONTAD').AsString + qryTinta.FieldByName('AUT_VARIAN').AsString +
    qryTinta.FieldByName('AUT_ANOINI').AsString + qryTinta.FieldByName('AUT_ANOFIN').AsString +
    qryTinta.FieldByName('AUT_MIXSCH').AsString + qryTinta.FieldByName('AUT_LINHA_').AsString +
    qryTinta.FieldByName('AUT_CODB01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC01').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC02').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC03').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC04').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC05').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC06').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC07').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC08').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC09').AsFloat), ',', '.') +
    qryTinta.FieldByName('AUT_CODB10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryTinta.FieldByName('AUT_QTDC10').AsFloat), ',', '.'));

  strMontad := qryTinta.FieldByName('AUT_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('AUT_ANOINI').AsString;

  strChaFor := qryTinta.FieldByName('AUT_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('AUT_CODIGO').AsString + ' ' +
               qryTinta.FieldByName('AUT_REFERE').AsString + ' ' +
               qryTinta.FieldByName('AUT_MONTAD').AsString + ' ' +
               qryTinta.FieldByName('AUT_VARIAN').AsString;


  stlDesEmb   :=  TStringList.Create;
  stlProEmbGl :=  TStringList.Create;
  stlProEmbLt :=  TStringList.Create;

  stlDesEmb.Add('Normal');
  stlProEmbGl.Add(conf.fGet('AUTIGL'));
  stlProEmbLt.Add(conf.fGet('AUTIEM'));

  strProEmbCo := conf.fGet('AUTICO');
  strProEmbSp := conf.fGet('AUTISP');

  strProEmbTb := conf.fGet('AUTITB');
  strProEmbLa := conf.fGet('AUTILA'); 

  If Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt, stlProEmbGl,
                                strProEmbCo, strProEmbSp, strProEmbTb, strProEmbLa,
                                strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                fltPreCus, fltPreVen, fltVolPro, strLinTin, strCatalize, strCodDil, fltPorDil,
                                strDilCon, fltPorCat, strTabPre, dicRetorno) Then
    Exit;

  strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPrcTin := fltPreCus;
  If blnUsaPreCus Then
    fltPreVen := fltPreCus;

  fltPrvTin := fltPreVen;
  fltUnitar := fltPreVen;         

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'PROAUT', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['volpro'] := fltVolPro;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := strChaFor + strTipEmb;

  dicRetorno['linha_'] := strLinTin;
  dicRetorno['catali'] := strCatalize;

  dicRetorno['coddil'] := strCodDil;
  dicRetorno['pordil'] := fltPorDil;
  dicRetorno['dilcon'] := strDilCon;
  dicRetorno['porcat'] := fltPorCat;
  dicRetorno['descor'] := strDesCor; 

  Result := True;
end;


function fGTinForAutocolorDinamica(strIteTin: String; strTipPre: String;
            Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
            Var stlItensTraMl: TStringList; fltVolPro: Double; strCatalize: String; strLinTin: String;
            strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double; fltQtdEmb: Double): Boolean; stdcall;
var
  strSQL      : String;
  qryConsulta : TUniQuery;
  intCont     : Integer;
  dicBases    : TDicionario;
  strBases    : String;
  Formula     : TFormulaAutomotiva;
  intModoVenda : Integer;

  strCamFor: String;
  strCamQtd: String;

  qryCadBas: TUniQuery;
  cdsConsulta: TUniClientDataSet;
  cdsCadBas: TUniClientDataSet;
begin
  Result := False;

  qryConsulta := nil;
  dicBases := nil;
  Try
    Try
      qryConsulta := fCriaQuery;
      {********************************}
      {* SELECIONE A TINTA NO CADAUT  *}
      {*****************************PH*}

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '  AUT_CADAUT ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(AUT_CODIGO, ""), IFNULL(AUT_DESCRI, ""), IFNULL(AUT_REFERE, ""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_MONTAD, ""), IFNULL(AUT_VARIAN, ""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_ANOINI, ""), IFNULL(AUT_ANOFIN, ""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_MIXSCH, ""), IFNULL(AUT_LINHA_, ""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_CODB01, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC01, 0.00000),5),",",""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_CODB02, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC02, 0.00000),5),",",""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_CODB03, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC03, 0.00000),5),",",""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_CODB04, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC04, 0.00000),5),",",""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_CODB05, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC05, 0.00000),5),",",""), ';
      strSQL := strSQL + '      IFNULL(AUT_CODB06, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC06, 0.00000),5),",",""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_CODB07, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC07, 0.00000),5),",",""), ';
      strSQL := strSQL + ' 			IFNULL(AUT_CODB08, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC08, 0.00000),5),",",""), ';
      strSQL := strSQL + '      IFNULL(AUT_CODB09, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC09, 0.00000),5),",",""), ';
      strSQL := strSQL + '      IFNULL(AUT_CODB10, ""), REPLACE(FORMAT(IFNULL(AUT_QTDC10, 0.00000),5),",",""))) AS CHAR)) = :ITETIN ';

      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Text := strSQL;
      qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      if cdsConsulta.IsEmpty then
      begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '  * ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '  AUT_CADAUT ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '  AUT_CODSEQ = :ITETIN ';

        qryConsulta.Close;
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Text := strSQL;
        qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
        cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);
      end;

      {**************************************}
      {* SE NAO ACHAR A TINTA RETORNE FALSO *}
      {***********************************PH*}
      If cdsConsulta.IsEmpty Then
      Begin
        Result := False;
        Exit;
      End;


      {*********************************************************}
      {* CRIA UM DICIONARIO PARA ARMAZENAR AS BASES DA FORMULA *}
      {******************************************************PH*}
      dicBases := TDicionario.Create;

      {******************************************}
      {* TABELA FIXA: AQUI NÃO USA O PREÇO, POR-*}
      {* TANTO, PODE SER QUALQUER TABELA.       *}
      {***************************************MV*}
      Formula := TFormulaAutoColorDinamica.Create('1');

      qryCadBas := fCriaQuery(nil);
      qryCadBas.SQL.Text := 'SELECT BAS_CODBAS, BAS_PESPEC, BAS_EMBALA FROM AUT_CADBAS';
      cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

      For intCont := 1 To 10 Do
      Begin
        strCamFor := 'AUT_CODB' + fStrZero(intCont, 2);
        strCamQtd := 'AUT_QTDC' + fStrZero(intCont, 2);

        If fEmptyStr(cdsConsulta.FieldByName(strCamFor).AsString) Then
          Break;

        Formula.Add;
        TBaseAutomotiva(Formula.Items[intCont - 1]).strCodBas := cdsConsulta.FieldByName(strCamFor).AsString;
        TBaseAutomotiva(Formula.Items[intCont - 1]).fltQtdDil := cdsConsulta.FieldByName(strCamQtd).AsFloat;
        TBaseAutomotiva(Formula.Items[intCont - 1]).fltQtdCon := cdsConsulta.FieldByName(strCamQtd).AsFloat;
        TBaseAutomotiva(Formula.Items[intCont - 1]).strTipBas := 'B';

        cdsCadBas.Locate('BAS_CODBAS', cdsConsulta.FieldByName(strCamFor).AsString, []);
        TBaseAutomotiva(Formula.Items[intCont - 1]).fltPesEsp := cdsCadBas.FieldByName('BAS_PESPEC').AsFloat;
        TBaseAutomotiva(Formula.Items[intCont - 1]).fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      End;

      intModoVenda := IfThen(strDilCon = 'D', 1, 0);
      pRecalculaFormula(Formula, intModoVenda, fltPorDil, strCodDil, strCatalize, strLinTin, fltPorCat, fltQtdEmb);
      For intCont := 1 To Formula.Count Do
      Begin
        arrFormul[intCont].strFormul := TBaseAutomotiva(Formula.Items[intCont - 1]).strCodBas;
        If strDilCon = 'C' Then
          arrFormul[intCont].fltQtdbas := TBaseAutomotiva(Formula.Items[intCont - 1]).fltQtdCon
        Else
          arrFormul[intCont].fltQtdbas := TBaseAutomotiva(Formula.Items[intCont - 1]).fltQtdDil;

        arrFormul[intCont].fltQtdbas := arrFormul[intCont].fltQtdbas * fltVolPro / 0.9;

        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        {***************************************************************}
        {* ARMAZENA AS BASES EM UMA STRING PARA FAZER A BUSCA NAS BASES*}
        {************************************************************PH*}
        strBases := strBases + QuotedStr(arrFormul[intCont].strFormul) + ', ';
      End;

      strBases := Trim(strBases);
      strBases := Copy(strBases, 1, Length(strBases) - 1);

      {****************************************}
      {* SELECIONA SOMENTE AS BAES DA FORMULA *}
      {*************************************PH*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_CODBAS, ';
      strSQL := strSQL + '  BAS_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  AUT_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + GetInToOr('BAS_CODBAS', strBases);

      qryConsulta.Close;
      qryConsulta.SQL.Text := strSQL;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      {********************************************************************}
      {* FIXA O TAMANHO DO ARRAY DE BAIXA PARA O TANTO DE BASES DA FORMULA*}
      {*****************************************************************PH*}
      SetLength(arrBaixaPigmentos, cdsConsulta.RecordCount);

      {**************************************************}
      {* CARREGA OS ITENS PARA FAZER A BAIXA DE ESTOQUE *}
      {***********************************************PH*}
      While (Not cdsConsulta.Eof) Do
      Begin
        stlItensTraMl.Add(cdsConsulta.FieldByName('BAS_CODITE').AsString);
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strCodIte := cdsConsulta.FieldByName('BAS_CODITE').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltQtdBaixa := dicBases[cdsConsulta.FieldByName('BAS_CODBAS').AsString];
        cdsConsulta.Next;
      End;
      
      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryConsulta) then FreeAndNil(qryConsulta);
    if Assigned(qryCadBas) then FreeAndNil(qryCadBas);
    if Assigned(dicBases) then FreeAndNil(dicBases);
  End;
end;

function fDigDadosTintometricos(qryCadAut: TUniQuery; stlDesEmb, stlProEmbLt, stlProEmbGl: TStringList;
        strProEmbCo, strProEmbSp, strProEmbTb, strProEmbLa: String;
        Var strIteEmb, strTipEmb, strTipPre: String; Var intQtdEmb: Integer;
        Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double;
        Var strLinTin: String; Var strCatalize: String; Var strCodDil: String;
        Var fltPorDil : Double; var strDilCon: String; Var fltPorCat: Double;
        strTabPre: String; dicRetorno: TDicionario): Boolean;
var
  objBase     : TBaseAutomotiva;
  objFormula  : TFormulaAutoColorDinamica;
  intCont     : Integer;
  blnDiluente : Boolean;
  fltPreCu2: Double;
  fltOutVal: Double;
  fltIcmSai: Double;
  fltImpFed: Double;
  fltDesOpe: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  cdsCadBas: TUniClientDataSet;
begin
  Result := False;
  frmDigTintaAutomotivaAutoColor := nil;
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      blnDiluente := Pos(Trim(LeftStr(qryCadAut.FieldbyName('AUT_LINHA_').AsString, 3)),
                                              '_LAC_SIN_ESI_SMS_PU_CRI_422_420') > 0;

      objFormula := TFormulaAutoColorDinamica.Create(blnDiluente, 'Escolha um Diluente', strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := qryCadAut.FieldbyName('AUT_DESCRI').AsString;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      cdsCadBas := TClientDataSetFactory.GetClientDataSet(objFormula.qryCadBas);

      For intCont := 1 To 10 Do
      Begin
        If fEmptyStr(qryCadAut.FieldbyName('AUT_CODB' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadAut.FieldByName('AUT_CODB' + fStrZero(intCont, 2)).AsString;
        objBase.fltQtdCon := qryCadAut.FieldByName('AUT_QTDC' + fStrZero(intCont, 2)).AsFloat;

        If blnDiluente Then
          objBase.fltQtdDil := qryCadAut.FieldByName('AUT_QTDC' + fStrZero(intCont, 2)).AsFloat;

        cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);
        objBase.fltEmbala := cdsCadBas.FieldbyName('BAS_EMBALA').AsFloat;
        objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESPEC').AsFloat;
        objBase.strTipBas := 'B';
      End;

      objFormula.fltVolumeOri := 900;

      objFormula.blnComCatalisador := Pos(Trim(LeftStr(qryCadAut.FieldbyName('AUT_LINHA_').AsString, 3)),
                                          '_PU_SIN_SMS_420_') > 0;

      objFormula.pCarregaPrecosBases;

      {*********************************************************************************}
      {* CARREGA AS INFORMACOES PARA VENDA NO FRMDIGTINTAAUTOMOTIVA PARA FAZER A VENDA *}
      {******************************************************************************PH*}

      pCriarFormularios(TfrmDigTintaAutomotivaAutoColor, frmDigTintaAutomotivaAutoColor);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotivaAutoColor.edtQtdEmb.Text := '1';
      frmDigTintaAutomotivaAutoColor.objFormula := objFormula; //TFormulaAutoColorDinamica
      frmDigTintaAutomotivaAutoColor.stlDesEmb := stlDesEmb;
      frmDigTintaAutomotivaAutoColor.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaAutoColor.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaAutoColor.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotivaAutoColor.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotivaAutoColor.strProEmbTb := strProEmbTb;
      frmDigTintaAutomotivaAutoColor.strProEmbLa := strProEmbLa;
      frmDigTintaAutomotivaAutoColor.Caption := frmDigTintaAutomotivaAutoColor.Caption + 'AutoColor';

      frmDigTintaAutomotivaAutoColor.strLinha := Trim(LeftStr(qryCadAut.FieldbyName('AUT_LINHA_').AsString, 3));
      frmDigTintaAutomotivaAutocolor.blnCatalisa := (RightStr(qryCadAut.FieldbyName('AUT_LINHA_').AsString, 1) = '1');
      frmDigTintaAutomotivaAutoColor.fltPorCat := 0;

      frmDigTintaAutomotivaAutoColor.strIdePro   := dicRetorno['idepro'];

      Result := (frmDigTintaAutomotivaAutoColor.ShowModal = mrOk);

      If Result Then
      Begin
        strIteEmb := frmDigTintaAutomotivaAutoColor.objFormula.strCodEmb;
        strTipEmb := IIF(frmDigTintaAutomotivaAutoColor.objFormula.tpeTipEmb = teLitro, 'LT', 'GL');
        strTipPre := IIF(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaAutoColor.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoEmbalagem;
        fltEmbala := IIF(frmDigTintaAutomotivaAutoColor.objFormula.tpeTipEmb = teLitro, 0.900, 3.600);
        fltVolPro := frmDigTintaAutomotivaAutoColor.objFormula.fltVolumePro;

        fltPreCus := IfThen(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoCusCon,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoCusDil)  +
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoCustoEmbalagem;

        fltPreCu2 := IfThen(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoCu2Con,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoCu2Dil)  +
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoCusto2Embalagem;

        fltPreVen := IfThen(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoVenCon,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoVenDil) +
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoEmbalagem;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPreMedCon,
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPreMedDil) +
                        frmDigTintaAutomotivaAutoColor.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaAutoColor.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaAutoColor.objFormula.fltImpUltDil) + objFormula.fltUltimoImpostoEmbalagem;
          
        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaAutoColor.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaAutoColor.objFormula.fltPreUltDil) + objFormula.fltPreUltEmbalagem;  

        dicForms := TDicionario.Create;

        strLinTin := frmDigTintaAutomotivaAutoColor.strLinha;

        pAdicionaFormula(fGetMd5MySql(qryCadAut.FieldByName('AUT_CODIGO').AsString +
                                      qryCadAut.FieldByName('AUT_DESCRI').AsString + qryCadAut.FieldByName('AUT_REFERE').AsString +
                                      qryCadAut.FieldByName('AUT_MONTAD').AsString + qryCadAut.FieldByName('AUT_VARIAN').AsString +
                                      qryCadAut.FieldByName('AUT_ANOINI').AsString + qryCadAut.FieldByName('AUT_ANOFIN').AsString +
                                      qryCadAut.FieldByName('AUT_MIXSCH').AsString + qryCadAut.FieldByName('AUT_LINHA_').AsString +
                                      qryCadAut.FieldByName('AUT_CODB01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC01').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC02').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC03').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC04').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC05').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC06').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC07').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC08').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC09').AsFloat), ',', '.') +
                                      qryCadAut.FieldByName('AUT_CODB10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadAut.FieldByName('AUT_QTDC10').AsFloat), ',', '.')), dicForms, frmDigTintaAutomotivaAutoColor.objFormula);

        strCodDil := frmDigTintaAutomotivaAutoColor.cmbListaAdicional.Text;
        fltPorDil := fStrToFloat(frmDigTintaAutomotivaAutoColor.edtDil.Text);
        strDilCon := IIF(frmDigTintaAutomotivaAutoColor.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        fltPorCat := frmDigTintaAutomotivaAutoColor.fltPorCat;
        strCatalize := frmDigTintaAutomotivaAutoColor.qryCadCat.FieldByName('CAT_CODCAT').AsString;

        If strTipPre = 'C' Then
        Begin
          strCodDil   := '';
          fltPorDil   := 0.0;
          fltPorCat   := 0.0;
          strCatalize := '';
        End
        Else If (Not frmDigTintaAutomotivaAutoColor.chkComCat.Checked) Then
        Begin
          fltPorCat   := 0.0;
          strCatalize := '';
        End;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['qtdemb'] := objFormula.intQtdEmb;
        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['obscolorista']   := frmDigTintaAutomotivaAutoColor.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotivaAutoColor.rdgTipoFormula.ItemIndex;


        dicRetorno['saldocols'] := frmDigTintaAutomotivaAutoColor.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaAutoColor.matrizSaldosColorantes);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
      End;

      If (Result) And (Assigned(dicRetorno)) Then
      Begin
        objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmDigTintaAutomotivaAutoColor) then FreeAndNil(frmDigTintaAutomotivaAutoColor);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;

end;

{ TFormulaAutoColorDinamica }



constructor TFormulaAutoColorDinamica.Create(blnDiluente: Boolean; strDadosAdicionais, strTabPre: String);
begin
  inherited Create(strTabPre);
  Self.FDadosAdicionais := blnDiluente;
  Self.FAdicionalDiluido := blnDiluente;
  Self.FCaptionAdicional := strDadosAdicionais;

  stlBassesErros := TStringList.Create;
  stlBassesErros.Clear;
  stlBassesErros.Sorted := True;
  stlBassesErros.Duplicates := dupIgnore;
end;

procedure TFormulaAutoColorDinamica.pCalcularPrecos;
var
  intIndex: Integer;
  intCIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala   : Double;

  fltDesBasCon: Double;
  fltDesCamCon: Double;

  fltCusBasCon: Double;
  fltCu2BasCon: Double;
  fltVenBasCon: Double;

  fltCusBasDil: Double;
  fltCu2BasDil: Double;
  fltVenBasDil: Double;

  rmRoundMode: TFPURoundingMode;
  cdsCadBas: TUniClientDataSet;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    fltDesBasCon := 0.0;
    fltDesCamCon := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoVenDil := 0;

    FOutValCon := 0;
    FIcmsaiCon := 0;
    FImpFedCon := 0;
    FDesOpeCon := 0;
    FPreMedCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;

    FPreUltCon := 0;
    FPreUltDil := 0;
    FImpUltCon := 0;
    FImpUltDil := 0;
  End;
begin
  inherited;

  pZerarPrecos;
  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  If fltVolumePro <= 0.0 Then
    fltVolumePro := 1;

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Not blnComCatalisador) And (objBase.strTipBas = 'C') Then
    Begin
      Continue;
    End;

    If (Not cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Continue;
    End;

    If (fEmptyStr(cdsCadBas.FieldByName('BAS_CODITE').AsString) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Continue;
    End;

    If (cdsCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex)) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Continue;
    End;

    If (cdsCadBas.FieldByName('BAS_PESPEC').AsFloat <= 0) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex)) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
                             'Favor verificar.');
      Continue;
    End;
    
    if not IsItemAtivo(cdsCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

    If stlBassesErros.Find(objBase.strCodBas, intCIndex) Then
      Continue;

    componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvConcentrado]) then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvDiluido]) then
    begin
      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    componente[mvConcentrado].Quantidade := objBase.fltQtdCon;
    componente[mvDiluido].Quantidade := objBase.fltQtdDil;

    fltPreCu2Bas := fCalculaPrecoCusto2(cdsCadBas.FieldByName('ITE_PREVEN').AsFloat,
                                        cdsCadBas.FieldByName('ITE_PRECUS').AsFloat,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltPreCusBas := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
    fltPreVenBas := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    fltEmbala    := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat * objBase.fltPesEsp;

    If fltEmbala = 0 Then
      Exit;

    rmRoundMode := GetRoundMode;
    SetRoundMode(rmTruncate);

    fltCusBasCon := (objBase.fltQtdCon * fltPreCusBas * FVolumePro) / (fltEmbala * FVolumeOri / 1000);
    fltCu2BasCon := (objBase.fltQtdCon * fltPreCu2Bas * FVolumePro) / (fltEmbala * FVolumeOri / 1000);
    fltVenBasCon := (objBase.fltQtdCon * fltPreVenBas * FVolumePro) / (fltEmbala * FVolumeOri / 1000);

    fltCusBasDil := (objBase.fltQtdDil * fltPreCusBas * FVolumePro) / (fltEmbala * FVolumeOri / 1000);
    fltCu2BasDil := (objBase.fltQtdDil * fltPreCu2Bas * FVolumePro) / (fltEmbala * FVolumeOri / 1000);
    fltVenBasDil := (objBase.fltQtdDil * fltPreVenBas * FVolumePro) / (fltEmbala * FVolumeOri / 1000);

    SetRoundMode(rmRoundMode);

    componente[mvConcentrado].OutrosValores := (objBase.fltQtdCon * objBase.fltOutVal * FVolumePro) / (fltEmbala * FVolumeOri / 1000);
    componente[mvDiluido].OutrosValores := (objBase.fltQtdDil * objBase.fltOutVal * FVolumePro) / (fltEmbala * FVolumeOri / 1000);

    componente[mvConcentrado].IcmsSaida := objBase.fltIcmSai * fltVenBasCon / 100;
    componente[mvDiluido].IcmsSaida := objBase.fltIcmSai * fltVenBasDil / 100;

    componente[mvConcentrado].ImpostosFederais := objBase.fltImpFed * fltVenBasCon / 100;
    componente[mvDiluido].ImpostosFederais := objBase.fltImpFed * fltVenBasDil / 100;

    componente[mvConcentrado].DespesasOperacionais := objBase.fltDesOpe * fltVenBasCon / 100;
    componente[mvDiluido].DespesasOperacionais := objBase.fltDesOpe * fltVenBasDil / 100;

    componente[mvConcentrado].PrecoMedio := (objBase.fltQtdCon * objBase.fltPreMed * FVolumePro) / (fltEmbala * FVolumeOri / 1000);
    componente[mvDiluido].PrecoMedio := (objBase.fltQtdDil * objBase.fltPreMed * FVolumePro) / (fltEmbala * FVolumeOri / 1000);

    componente[mvConcentrado].PrecoCusto := fltCusBasCon;
    componente[mvDiluido].PrecoCusto := fltCusBasDil;

    componente[mvConcentrado].PrecoCustoReal := fltCu2BasCon;
    componente[mvDiluido].PrecoCustoReal := fltCu2BasDil;

    componente[mvConcentrado].PrecoVenda := fltVenBasCon;
    componente[mvDiluido].PrecoVenda := fltVenBasDil;
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
  FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;

  pCarregaPrecosBases;
end;

procedure TFormulaAutoColorDinamica.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  fltConc : Double;
  fltDil  : Double;
  cdsGen: TUniClientDataSet;
begin
  fltConc := 0;
  fltDil := 0;

  cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadBas);
  
  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    cdsGen.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := cdsGen.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsGen.FieldByName('BAS_PESPEC').AsFloat;
    objBase.fltPreVen := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
    objBase.strImpDir := cdsGen.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsGen.FieldByName('BAS_CODITE').AsString;    

    objBase.fltOutVal := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := cdsGen.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := cdsGen.FieldByName('ITE_DESOPE').AsFloat;
    objBase.fltPreMed := cdsGen.FieldByName('ITE_PREMED').AsFloat;

    fltConc := fltConc + objBase.fltQtdCon;
    fltDil := fltDil + objBase.fltQtdDil;
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = (Qtde. Gramas * Preço) / (Embalagem * Peso Específico)');
  FCalculo.Add('Preço da Tinta = Soma(Valores de Base) * Volume Produzido');
end;

procedure TFormulaAutoColorDinamica.pCarregarColorantes;
begin
  inherited;
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESPEC                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');
  qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');  

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');  
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                 ');
  qryCadBas.SQL.Add('   AUT_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  TClientDataSetFactory.GetClientDataSet(qryCadBas);
end;

function fRetornaUniTraProAutocolorDinamica(strTipPre: String; fltPrcTin, fltPrvTin: Double): Double;
Var
  conf: IConfTinta;
begin
  conf  := fGetConfTinta('AUT');

  //If fArqIniTinta(0, 'AUTOCOLOR', 'TRAAUT', '0') = 'VEN' Then
  If conf.fGet('TRAAUT') = 'VEN' Then
    Result :=  fltPrvTin * conf.fGetDouble('FATAUT') //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'FATAUT', ''))
  Else
    Result :=  fltPrcTin * conf.fGetDouble('FATAUT'); //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'FATAUT', ''));

  Result := fFormataFloat(Result, 2);
end;


procedure pRecalculaFormula(Var ObjFormula: TFormulaAutomotiva; intModoVenda: Integer;
  fltPorDil: Double; strCodDil: String; strCatalisador: String; strLinha: String;
  Var fltPorCat: Double; fltQtdEmb: Double);
var
  intCont     : Integer;
  fltDilu     : Double;
  fltCata     : Double;
  fltTotBas   : Double;
  fltTaxa     : Double;
  fltVolPro   : Double;
  fltVolProl  : Double;
  fltDiluente : Double;
  objBase     : TBaseAutomotiva;
  qryCadBas   : TUniQuery;
  qryCadCat   : TUniQuery;
  qryCadDil   : TUniQuery;
  cdsCadBas: TUniClientDataSet;
  cdsCadCat: TUniClientDataSet;
  cdsCadDil: TUniClientDataSet;
begin
  qryCadBas := nil;
  qryCadCat := nil;
  qryCadDil := nil;
  Try
    Try
      qryCadCat := fCriaQuery(nil);
      qryCadCat.SQL.Text := 'SELECT * FROM AUT_CADCAT WHERE CAT_CODSIS = "' + strLinha + '"';
      cdsCadCat := TClientDataSetFactory.GetClientDataSet(qryCadCat);

      qryCadDil := fCriaQuery(nil);
      qryCadDil.SQL.Text := 'SELECT * FROM AUT_CADDIL WHERE DIL_CODSIS = "' + strLinha + '" AND DIL_CODDIL = "' + strCodDil + '"';
      cdsCadDil := TClientDataSetFactory.GetClientDataSet(qryCadDil);

      If fltPorCat = -1 Then
      Begin
        If cdsCadCat.FieldByName('CAT_PORMIN').AsFloat = cdsCadCat.FieldByName('CAT_PORMAX').AsFloat Then
        Begin
          fltPorCat := cdsCadCat.FieldByName('CAT_PORMIN').AsFloat;
        End
        Else
        Begin
          fltPorCat := cdsCadCat.FieldByName('CAT_PORMAX').AsFloat;
        End;
      End;

      If intModoVenda = 1 Then
      Begin
        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.fltQtdDil := fltPorDil;
        objBase.strCodBas := strCodDil;
      End;

      fltVolPro := 0;
      fltVolProl := 0;
      fltDiluente := fltPorDil;

      For intCont := 0 To objFormula.Count - 2 Do
      Begin
        fltVolPro := fltVolPro + TBaseAutomotiva(objFormula.Items[intCont]).fltQtdCon;

        If TBaseAutomotiva(objFormula.Items[intCont]).fltPesEsp = 0 Then
          Exit;

        fltVolProl := fltVolProl + TBaseAutomotiva(objFormula.Items[intCont]).fltQtdCon / TBaseAutomotiva(objFormula.Items[intCont]).fltPesEsp;
      End;

      fltDilu := 1000 * fltQtdEmb * (1 - (100 / (100 + fltDiluente)));

      If fEmptyStr(strCatalisador) Then
      Begin
        fltCata := 0;
    //    fltPorCat := 0;
      End
      Else
      Begin
        fltCata := (fltQtdEmb * 1000 / (1 + fltDiluente / 100)) / (1 + fltPorCat / 100);
        fltCata := fltCata * fltPorCat / 100;
      End;

      fltTotBas := (fltQtdEmb * 1000) - fltCata - fltDilu;
      fltDilu := fltDilu * cdsCadDil.FieldbyName('DIL_PESPEC').AsFloat;

      For intCont := 0 To objFormula.Count - 2 Do
      Begin
        fltTaxa := TBaseAutomotiva(objFormula.Items[intCont]).fltQtdCon / fltVolProl;
        If intModoVenda = 1 Then
          TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil := fltTaxa * fltTotBas
        Else
          TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil := TBaseAutomotiva(objFormula.Items[intCont]).fltQtdCon;

      End;


      qryCadBas := fCriaQuery(nil);
      qryCadBas.SQL.Text := 'SELECT * FROM AUT_CADBAS';
      cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

      If intModoVenda = 1 Then
      Begin
        cdsCadBas.Locate('BAS_CODBAS', TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).strCodBas, []);
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltQtdDil := fltDilu;
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltPesEsp := cdsCadBas.FieldbyName('BAS_PESPEC').AsFloat;
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).strTipBas := 'D';
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltPreVen := cdsCadBas.FieldByName('BAS_PREVEN').AsFloat;
      End;

      If (intModoVenda = 1) and (Not fEmptyStr(strCatalisador)) Then
      Begin
        objFormula.Add;
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).strCodBas := cdsCadCat.FieldByName('CAT_CODCAT').AsString;
        cdsCadBas.Locate('BAS_CODBAS', TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).strCodBas, []);
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltQtdDil := fltCata;
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltPesEsp := cdsCadCat.FieldByName('CAT_PESPEC').AsFloat;
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).strTipBas := 'C';
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
        TBaseAutomotiva(objFormula.Items[objFormula.Count - 1]).fltPreVen := cdsCadBas.FieldByName('BAS_PREVEN').AsFloat;
      End;

      For intCont := 0 To objFormula.Count - 1 Do
      Begin
        if (intModoVenda = 1) then
          TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil :=
            0.9 * TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil / fltQtdEmb
        Else
          TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil := 0;

        If TBaseAutomotiva(objFormula.Items[intCont]).fltPesEsp <= 0 Then
        Begin
          fMensagem('', 'A base ' + TBaseAutomotiva(objFormula.Items[intCont]).strCodBas + ' com peso específico errado', ['OK']);
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadBas) then FreeAndNil(qryCadBas);
    if Assigned(qryCadCat) then FreeAndNil(qryCadCat);
    if Assigned(qryCadDil) then FreeAndNil(qryCadDil);
  End;
end;

procedure pAdicionaFormula(strCodSeq: String; var dicFormulas: TDicionario; objFormulaNova  : TFormulaAutomotiva);
begin
  dicFormulas.AdicionarObjeto(strCodSeq, objFormulaNova);
end;

procedure pRetornaTabelaPrecoAutocolor(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TFormulaAutoColorDinamica;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;

  function GetDescri(const strDescri: string): string;
  begin
    Result := strDescri;
    if Length(strDescri) > 20 then
      Result := LeftStr(strDescri, 20) + '...';
  end;  
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaAutoColorDinamica.Create(False, '', '1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 1;
      objFormula.fltVolumePro := dicRetorno['volpro'];
      objFormula.mveModoVenda := mvConcentrado;
      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strCodEmb := dicRetorno['iteemb'];

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3)
          * (objFormula.fltVolumeOri / objFormula.fltVolumePro) / 1000 ;
        objBase.fltQtdDil := 0.0;
        objBase.strTipBas := 'B';
      End;

      strTabelas := fCfgSis('TABPRC');
      If Length(strTabelas) < 7 Then
        strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

      For intContador := 1 To Length(strTabelas) Do
      Begin
        if strTabelas[intContador] = 'S' then
        begin
          objFormula.strTabPre := IntToStr(intContador);

          TfrmGravando.fExecutarModal(objFormula.pCarregarColorantes, Format('Carregando Bases... [%s] - Tabela %d',
            [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCarregarColorantes');

          TfrmGravando.fExecutarModal(objFormula.pCarregaPrecosBases, Format('Carregando Preços... [%s] - Tabela %d',
            [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCarregaPrecosBases');

          TfrmGravando.fExecutarModal(objFormula.pCalcularPrecos, Format('Calculando Preços... [%s] - Tabela %d',
            [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCalcularPrecos');

          If IfNull(dicRetorno['precus'], 0) <= 0 Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem;

          dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
          if intContador = IfNull(dicRetorno['tabpre'], 0) then
          begin
            objFormula.pCalculaImpostosSaida(dicRetorno);
            dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
          end;

          dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
        end;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;

end;

function fConsultaAutoColorDinamicaInterna(Sender: TForm; qryTinta: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String): String;
begin
  Result := (TAutoColorConsulta.Create).fExecutarConsulta(Sender,
    qryTinta, tipoConsulta, strTabPre, TfrmConsultaCompAutocolor);
end;


{ TfrmConsultaCompAutocolor }

procedure TfrmConsultaCompAutocolor.pTarefaFormulacao(Sender: TObject);
  Var
    qryGen: TUniQuery;
    stlDesEmb   :  TStringList;
    stlProEmbGl :  TStringList;
    stlProEmbLt :  TStringList;

    strProEmbCo : String;
    strProEmbSp : String;
    strProEmbTb : String;
    strProEmbLa : String;

    strIteEmb: String;
    strTipEmb: String;
    strTipPre: String;
    intQtdEmb: Integer;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    fltVolPro: Double;
    strLinTin: String;
    strCatalize: String;
    strCodDil: String;
    fltPorDil: Double;
    strDilCon: String;
    fltPorCat: Double;
    
    dicParams: TDicionario;
    conf: IConfTinta;
begin
  inherited;
  stlDesEmb := nil;
  stlProEmbGl := nil;
  stlProEmbLt := nil;
  qryGen := nil;
  dicParams := nil;
  Try
    Try
      conf  := fGetConfTinta('AUT');
      stlDesEmb   :=  TStringList.Create;
      stlProEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;

      stlDesEmb.Add('Normal');
      stlProEmbGl.Add(conf.fGet('AUTIGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'AUTOCOLOR', 'AUTIGL', ''));
      stlProEmbLt.Add(conf.fGet('AUTIEM')); //stlProEmbLt.Add(fArqIniTinta(0, 'AUTOCOLOR', 'AUTIEM', ''));

      strProEmbCo := conf.fGet('AUTICO'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTICO', '');
      strProEmbSp := conf.fGet('AUTISP'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTISP', '');

      strProEmbTb := conf.fGet('AUTITB'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTITB', '');
      strProEmbLa := conf.fGet('AUTILA'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTILA', '');

      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM AUT_CADAUT WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'AUT';

      If Not fDigDadosTintometricos(qryGen, stlDesEmb, stlProEmbLt, stlProEmbGl,
                                  strProEmbCo, strProEmbSp, strProEmbTb, strProEmbLa,
                                  strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                  fltPreCus, fltPreVen, fltVolPro, strLinTin, strCatalize, strCodDil, fltPorDil,
                                  strDilCon, fltPorCat, strTabPre, dicParams) Then
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(dicParams) then FreeAndNil(dicParams);
  End;
end;

procedure TfrmConsultaCompAutocolor.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompAutocolor.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadAutNfm', False);
end;

end.

