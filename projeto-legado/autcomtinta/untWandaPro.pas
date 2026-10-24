unit untWandaPro;

interface

uses SysUtils, Forms, Uni, Classes,  StrUtils, Dialogs, Math,
  untFuncEspecificas, Controls, untFuncoesSimples,
  untTMatrizSaldosColorantes, Variants, untPnlBotoesAcoesNovaConsulta,
  untIConfTinta;

{***************************************************}
{* CRIA A CLASSE QUE REPRESENTA UMA FORMULA DA     *}
{* COLOR PRO                                       *}
{** 04/06/2008 - 17:09 **************************MV*}
Type

  TConsultaColorPro = class(TfrmPnlBotoesAcoesNovaConsulta)
  protected
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
  End;

  TFormulaColorPro = class(TFormulaAutomotiva)
  private
    fltPerAcr: Double;
    fltAcrMob: Double;
  protected
    procedure pAdicionarEmbalagem(matSaldosBases: TClassMatrizSaldosColorantes); override;
  public
    procedure pCarregarColorantes; override;
    procedure pCalcularPrecos; override;
    procedure pCarregaPrecosBases; override;
    Constructor Create(strTabPre: String); override;
    function fRetMatrizSaldosColorantes: TClassMatrizSaldosColorantes; override;
  End;

  function fConsultaWandaPro(Sender: TForm): String; stdcall;
  function fConsultaWandaProGeral(Sender: TForm): String; stdcall;
  function fConsultaWandaProVenda(Sender: TForm; qryCadWan: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaWandaProInterna(Sender: TForm; Var qryCadWan: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  function fDigEmbalagem(blnMosCat: Boolean; strLinha: String; Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double; Var strCatalize: String): Boolean;

  function fRetornaDescricaoWandaPro(qryTinta: TUniQuery; strDesCor: string): String;

  function fRetornaUniTraProWandaPro(qryTinta: TUniQuery; strIteTin, strTipPre,
    strCatalise: String; fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaUniTraEmbWandaPro(strTipEmb: String): Double;

  function fRetornaPrecoWandaPro(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil; strLinhaWandaPro: String = ''): Boolean;

  function fDigDadosTintometricos(qryCadPro: TUniQuery; stlDesEmb, stlProEmbLt,
    stlProEmbGl, stlProEmbLa: TStringList; strProEmbCo, strProEmbSp: String; Var strIteEmb, strTipEmb, strTipPre: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro: Double; Var strCatalise: String; strTabPre: String; dicRetorno: TDicionario;
    strProEmbSs: String): Boolean;

  function fGTinForWandaPro(strIteTin, strTipPre, strLinha, strCatalize: String; fltQtdIte, fltVolPro: Double;
    Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
    Var stlItensTraMl: TStringList): Boolean;

  function fRetFatVen(strLinha, strCatalize: String): Double;

  procedure pRetornaDadosWandaProDinamica(strIteTin: String; dicRetorno: TDicionario);

  procedure pRetornaTabelaPrecoColorPro(dicRetorno: TDicionario; fltFatorAcerto: Double);

  function fVerificaQuantidadeCamadas(strIteTin: String): Integer;

  function fRetornaNomeLinha(const strLinha: String): String;
  function fLinhaEhWanda(const strLinha: String): Boolean;

  function fCalculoA(objFormula: TFormulaAutomotiva;
    strConDil: String; idxBase: Integer; strLinha: String): Double;
  function fCalculoB(objFormula: TFormulaAutomotiva;
    strConDil: String; idxBase: Integer; strLinha: String): Double;
  function fCalculoBLinha08(objFormula: TFormulaAutomotiva; strConDil: String; idxBase: Integer): Double;
  function fCalculoC(objFormula: TFormulaAutomotiva; idxBase: Integer): Double;
  function fRetornaPorcento(strItetin: String; intIndexBase: Integer): Double;
  function fRetornaCodAkzo(strItetin: String): String;

  function fRetornaAcrescimoMaoObra(strIteTin, strLinha: String): Double;

  function fRetIndiceAdicional(const strLinha: String; const strCatali: String): Integer;
  function fRet4Por1(const strLinha: String; const strCatali: String): Boolean;
  function fArredondaColorPro(fltValor: Double): Double;

  procedure pPreencheProdutoEmbalagem(Var stlProEmbLt, stlProEmbGl,
    stlProEmbLa: TStringList; qryTinta: TUniQuery; conf: IConfTinta);

implementation

uses
   untFatDigEmbalagem, StdCtrls, DB,
  untDigTintaAutomotiva, untDigTintaAutomotivaColorPro, untWandaProConsulta,untFuncoes,
untICalculadorFatVendas,
untIConsultaTinta,
untTintaMaquina,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteComparerBaseAutomotiva;

function fConsultaWandaPro(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaWandaProInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
  FreeAndNil(qryGen)
end;

function fConsultaWandaProGeral(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaWandaProInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
  FreeAndNil(qryGen)
end;

function fConsultaWandaProVenda(Sender: TForm; qryCadWan: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaWandaProInterna(Sender, qryCadWan, tpcVenda, strTabPre, blnFaturamento, dicRetorno, sltItems);
end;

function fDigEmbalagem(blnMosCat: Boolean; strLinha: String; Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double; Var strCatalize: String): Boolean;
begin
  Try
    pCriarFormularios(TfrmFatDigEmbalagem, frmFatDigEmbalagem);
    frmFatDigEmbalagem.strTipEmb      := strTipEmb;
    frmFatDigEmbalagem.edtQtdEmb.Text := IntToStr(intQtdEmb);
    frmFatDigEmbalagem.cmbCatalize.ItemIndex := IIF(strCatalize = '4:1', 1, 0);
    If (Not blnMosCat) Then
    Begin
      frmFatDigEmbalagem.cmbCatalize.Visible := False;
      frmFatDigEmbalagem.lblCatalize.Visible := False;
      //frmFatDigEmbalagem.Width := frmFatDigEmbalagem.Width - (frmFatDigEmbalagem.cmbCatalize.Width * 2);
    End
    Else
    Begin
      If (Pos(fStrZero(strLinha,3), '008_013_') > 0) Then
        frmFatDigEmbalagem.cmbCatalize.AddItem('2:1', Nil);

      frmFatDigEmbalagem.cmbCatalize.AddItem('4:1', Nil);
      frmFatDigEmbalagem.cmbCatalize.ItemIndex := 0;
    End;
    frmFatDigEmbalagem.showModal;
  Finally
    Result := frmFatDigEmbalagem.blnConfirma;
    {*****************************************}
    {* CASO TENHA CANCELADO, SAI, SENAO      *}
    {* ATUALIZA AS VARIAVEIS                 *}
    {**************************************MV*}
    If (Result) Then
    Begin
      strTipEmb   := frmFatDigEmbalagem.strTipEmb;
      intQtdEmb   := StrToInt(frmFatDigEmbalagem.edtQtdEmb.Text);
      strCatalize := frmFatDigEmbalagem.cmbCatalize.Text;
    End;
    FreeAndNil(frmFatDigEmbalagem);
  End;

  If (Not blnMosCat) Then
  Begin
    strCatalize := '';
  End;

  If (Not Result) Then
    Exit;

  {*****************************************}
  {* LITRO                                 *}
  {**************************************MV*}
  If (strTipEmb = 'LT') Then
  Begin
    fltPreEmb := fGetConfTinta('WCP').fGetDouble('EMBWAN') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'EMBWAN', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fGetConfTinta('WCP').fGetDouble('GALWAN') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'GALWAN', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;
end;

function fRetornaDescricaoWandaPro(qryTinta: TUniQuery; strDesCor: string): String;
  Var
    intCamadas: Integer;
begin
  Result := strDesCor;
{  intCamadas := fVerificaQuantidadeCamadas(fGetMd5MySql(qryTinta.FieldByName('WAN_LINHA_').AsString +
                                                        qryTinta.FieldByName('WAN_CODAKZ').AsString +
                                                        qryTinta.FieldByName('WAN_ALTERN').AsString +
                                                        qryTinta.FieldByName('WAN_MONTAD').AsString +
                                                        qryTinta.FieldByName('WAN_CAMADA').AsString));}

  intCamadas := fVerificaQuantidadeCamadas(qryTinta.FieldByName('WAN_MD5KEY').AsString);

  If intCamadas > 1 Then
    Result := Result + ' ' + qryTinta.FieldByName('WAN_CAMADA').AsString + 'ª CAMADA';
end;

function fRetornaUniTraProWandaPro(qryTinta: TUniQuery; strIteTin, strTipPre,
  strCatalise: String; fltPrcTin, fltPrvTin: Double): Double;
  Var
    strTraColorPro: String;
    fltFatColorPro: Double;
//    strSQL: String;
begin
{
  strSQL := '';
  strSQL := strSQL + ' SELECT                     ';
  strSQL := strSQL + '   *                        ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   WANPRO_CADWAN            ';
  strSQL := strSQL + ' WHERE WAN_MD5KEY = :ITETIN ';

  qryTinta.Close;
  qryTinta.SQL.Clear;
  qryTinta.SQL.Add(strSQL);
  qryTinta.ParamByName('ITETIN').AsString := strIteTin;
  qryTinta.Open;

  If qryTinta.IsEmpty Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT * ';
    strSQL := strSQL + '  FROM WANPRO_CADWAN ';
    strSQL := strSQL + ' WHERE  ';
    strSQL := strSQL + ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ';
    strSQL := strSQL + ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ';
    strSQL := strSQL + ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';

    qryTinta.Close;
    qryTinta.SQL.Clear;
    qryTinta.SQL.Add(strSQL);
    qryTinta.ParamByName('ITETIN').AsString := strIteTin;
    qryTinta.Open;

    If qryTinta.IsEmpty Then
    Begin
      qryTinta.Close;
      qryTinta.SQL.Clear;
      qryTinta.SQL.Add('SELECT * FROM WANPRO_CADWAN WHERE WAN_CODSEQ = :ITETIN');
      qryTinta.ParamByName('ITETIN').AsString := strIteTin;
      qryTinta.Open;
    End;
  End;
}
  If (strTipPre = 'C') Then
  Begin
    strTraColorPro := fGetConfTinta('WCP').fGet('TRAWAN'); //fArqIniTinta(0, 'COLOR PRO', 'TRAWAN', '');
    fltFatColorPro := fGetConfTinta('WCP').fGetDouble('FATWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FATWAN', '0'));
  End
  Else
  Begin
    strTraColorPro := fGetConfTinta('WCP').fGet('TRDWAN'); //fArqIniTinta(0, 'COLOR PRO', 'TRDWAN', '');
    fltFatColorPro := fGetConfTinta('WCP').fGetDouble('FADWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FADWAN', '0'));
  End;

  If strTraColorPro = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

//  Result := Result / fRetFatVen(qryTinta.FieldByName('WAN_LINHA_').AsString, strCatalise);
  Result := Result * fltFatColorPro;

  Result := fFormataFloat(Result, 2);
end;

function fRetornaUniTraEmbWandaPro(strTipEmb: String): Double;
  Var
    fltFatTra: Double;
    fltPreEmb: Double;
begin
  If (strTipEmb = 'LT') Then
  Begin
    fltPreEmb := fGetConfTinta('WCP').fGetDouble('EMBWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'EMBWAN', ''));
//    fltFatTra := fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FATWAN', ''));
  End
  Else
  Begin
    fltPreEmb := fGetConfTinta('WCP').fGetDouble('GALWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'GALWAN', ''));
//    fltFatTra := fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FADWAN', ''));
  End;

  fltFatTra := fGetConfTinta('WCP').fGetDouble('FATWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FATWAN', ''));
//  If (fArqIniTinta(0, 'COLOR PRO', 'TRAWAN', '') = 'CUS') Then
  if (fGetConfTinta('WCP').fGet('TRAWAN') = 'CUS') then
  Begin
    fltFatTra := 1 - Frac(fltFatTra);
  End;


  Result := fltPreEmb * fltFatTra;
end;

function fRetornaPrecoWandaPro(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
  strAutoTab: String = ''; sltItems: TStringList = Nil; strLinhaWandaPro: String = ''): Boolean;
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
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
//    fltPrcTin: Double;
    fltPrvTin: Double;
    strTipPre: String;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;

    strCatalize: String;

    fltVolPro: Double;

    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbLa: TStringList;

    strProEmbCo: String;
    strProEmbSp: String;

    strChaFor: String;
    strTabPre: String;
    strProEmbSs: String;

    intCamadas: Integer;

    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor: String;
    conf: IConfTinta;

begin

  Result := False;

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;

  stlProEmbGl := TStringList.Create;
  stlProEmbLa := TStringList.Create;


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

{
  If (fConsultaWandaProVenda(Sender, qryTinta, strTabPre) = '-1') Then
  Begin
    Exit;
  End;
}

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaWandaProVenda(Sender, qryTinta, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := (TWandaProConsulta.Create);
  conf  := fGetConfTinta('WCP');
  If strTab = 'N' Then
    tinta.SetstrLinhaWandaPro(qryTinta.FieldByName('WAN_LINHA_').AsString)
  Else
    tinta.SetstrLinhaWandaPro(strLinhaWandaPro);

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

//  strIteTin := qryTinta.FieldByName('WAN_CODSEQ').AsString;
{  strIteTin := fGetMd5MySql(qryTinta.FieldByName('WAN_LINHA_').AsString +
                            qryTinta.FieldByName('WAN_CODAKZ').AsString +
                            qryTinta.FieldByName('WAN_ALTERN').AsString +
                            qryTinta.FieldByName('WAN_MONTAD').AsString +
                            qryTinta.FieldByName('WAN_CAMADA').AsString);}

  strIteTin := qryTinta.FieldByName('WAN_MD5KEY').AsString;

  strMontad := qryTinta.FieldByName('WAN_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('WAN_ANOINI').AsString;

  strChaFor := qryTinta.FieldByName('WAN_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('WAN_CODAKZ').AsString + ' ' +
               qryTinta.FieldByName('WAN_LINHA_').AsString + ' ' +
               qryTinta.FieldByName('WAN_MONTAD').AsString + ' ' ;

  fltPreCus := 0.0;
  fltUnitar := 0.0;

  stlDesEmb.Add('NORMAL');

  pPreencheProdutoEmbalagem(stlProEmbLt, stlProEmbGl, stlProEmbLa, qryTinta, conf);

{  If (qryTinta.FieldByName('WAN_LINHA_').AsString = '1') Then
  Begin
    stlProEmbLt.Add(conf.fGet('PLSILT'));
    stlProEmbGl.Add(conf.fGet('PLSIGL'));
    stlProEmbLa.Add(conf.fGet('PLSILA'));
  End
  else
  If (qryTinta.FieldByName('WAN_LINHA_').AsString = '13') Then
  Begin
    stlProEmbLt.Add(conf.fGet('BTSILT'));
    stlProEmbGl.Add(conf.fGet('BTSIGL'));
    stlProEmbLa.Add(conf.fGet('BTSILA'));
  End
  Else
  If (qryTinta.FieldByName('WAN_LINHA_').AsString = '27') Then
  Begin
    stlProEmbLt.Add(conf.fGet('MMSILT'));
    stlProEmbGl.Add(conf.fGet('MMSIGL'));
    stlProEmbLa.Add(conf.fGet('MMSILA'));
  End
  Else
  Begin
    stlProEmbLt.Add(conf.fGet('WANIEM'));
    stlProEmbGl.Add(conf.fGet('WANIGL'));
    stlProEmbLa.Add(conf.fGet('WANILA'));
  End;}

  strProEmbCo := conf.fGet('WANICO');
  strProEmbSp := conf.fGet('WANISP');
  strProEmbSs := conf.fGet('WANISS');

  If (Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt,
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
        strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb,
        fltEmbala, fltPreCus, fltUnitar, fltVolPro, strCatalize, strTabPre, dicRetorno, strProEmbSs)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));
  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

//  fltPrcTin := fltPreCus;

  If blnUsaPreCus Then
    fltPrvTin := fltPreCus
  Else
    fltPrvTin := fltUnitar;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
//  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROWAN'); //fArqIniTinta(0, 'COLOR PRO', 'PROWAN', '');
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['linha_'] := qryTinta.FieldByName('WAN_LINHA_').AsString;
  dicRetorno['catali'] := strCatalize;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['tippre'] := strTipPre;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['volpro'] := fltVolPro;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  {*******************************************************************}
  {* CASO HAJA MAIS DE UMA CAMADA IDENTIFICAR A COR E AVISAR USUARIO *}
  {****************************************************************PH*}

  intCamadas := fVerificaQuantidadeCamadas(strIteTin);
  If intCamadas > 1 Then
    strChaFor := strChaFor + qryTinta.FieldByName('WAN_CAMADA').AsString + 'ª CAMADA ';

  dicRetorno['chafor'] := strDesCor + strChaFor + strTipEmb;

  If intCamadas > 1 Then
    fMensagem('ATENÇÃO', Format('Esta fórmula possui %d camadas, após consultar a primeira, selecione a próxima.', [intCamadas]), ['OK']);

  pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));    

  Result := True;

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmbLt);

  FreeAndNil(stlProEmbGl);
  FreeAndNil(stlProEmbLa);

end;

function fGTinForWandaPro(strIteTin, strTipPre, strLinha, strCatalize: String; fltQtdIte, fltVolPro: Double;
  Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
  Var stlItensTraMl: TStringList): Boolean;
  Var
    objBase: TBaseAutomotiva;
    objFormula: TFormulaColorPro;

    strSQL: String;
    strLinFor: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strBases: String;
    dicBases: TDicionario;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  dicBases := TDicionario.Create;
  strBases := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT                     ';
  strSQL := strSQL + '   *                        ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   WANPRO_CADWAN            ';
  strSQL := strSQL + ' WHERE WAN_MD5KEY = :ITETIN ';
  strSQL := strSQL + '   AND WAN_LINHA_ = :LINHA_ ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    ParamByName('LINHA_').AsString := strLinha;
    Open;

    If qryConsulta01.IsEmpty Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  WANPRO_CADWAN ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ';
      strSQL := strSQL + ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ';
      strSQL := strSQL + ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';
      strSQL := strSQL + '  AND WAN_LINHA_ = :LINHA_ ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      ParamByName('LINHA_').AsString := strLinha;
      Open;

      If qryConsulta01.IsEmpty Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  * ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  WANPRO_CADWAN ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  WAN_CODSEQ = :ITETIN AND ';
        strSQL := strSQL + '  WAN_LINHA_ = :LINHA_ ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('ITETIN').AsString := strIteTin;
        ParamByName('LINHA_').AsString := strLinha;
        Open;
      End;
    End;

    If (IsEmpty) Then
    Begin
      Close;
      Result := False;
      Exit;
    End;

    Try
      objFormula := TFormulaColorPro.Create('1');
      objFormula.strDescri := FieldByName('WAN_DESCRI').AsString + ' ' +
                              FieldByName('WAN_CODAKZ').AsString + ' ' +
                              FieldByName('WAN_LINHA_').AsString;
      objFormula.fltVolumePro := fltVolPro;

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        If (strTipPre = 'C') And (FieldByName('WAN_QCON' + fStrZero(intContador, 2)).AsFloat <= 0) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strLinBas := FieldByName('WAN_LINC' + fStrZero(intContador, 2)).AsString;
        objBase.strCodBas := FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := FieldByName('WAN_QCON' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltQtdDil := FieldByName('WAN_QD21' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltQtdDi2 := FieldByName('WAN_QD41' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltPorcen := FieldByName('WAN_PORC' + fStrZero(intContador, 2)).AsFloat;
        objBase.strTipBas := 'B';

      End;

      objFormula.pCarregaPrecosBases;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;

    For intContador := 1 To 20 Do
    Begin
      strLinFor := 'WAN_LINC' + fStrZero(IntToStr(intContador), 2);
      strCamFor := 'WAN_CODC' + fStrZero(IntToStr(intContador), 2);

      If (fEmptyStr(FieldByName(strCamFor).AsString)) Then
        Continue;

      If (Copy(FieldByName('WAN_CODAKZ').AsString,1,3) = 'ESP') Or Not (Pos(fStrZero(strLinha, 3), '004_001_014_013_011_027_008_058_009_006_') > 0) Then
      Begin
        If (strTipPre = 'C') Then
          strCamBas := 'WAN_QCON' + fStrZero(IntToStr(intContador), 2)
        Else If (Pos(fStrZero(strLinha,3), '008_013_058_059_') > 0) And ((strCatalize = '4:1')) Then
          strCamBas := 'WAN_QD41' + fStrZero(IntToStr(intContador), 2)
        Else
          strCamBas := 'WAN_QD21' + fStrZero(IntToStr(intContador), 2);

        arrFormul[intContador].fltQtdBas :=
          fArredondaColorPro(fFormataFloat(((FieldByName(strCamBas).AsFloat / fRetFatVen(strLinha, strCatalize)) * fltVolPro), 1));
      End
      else
      Begin
        If (strTipPre = 'C') Then
        Begin
          If (Pos(fStrZero(strLinha, 3), '004_001_014_006_009_027') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoA(objFormula,'CON', intContador -1, strlinha)
          Else If (Pos(fStrZero(strLinha, 3), '008_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoBLinha08(objFormula,'CON', intContador -1)
          Else If (Pos(fStrZero(strLinha, 3), '058_013_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoB(objFormula,'CON', intContador -1, strLinha)
          Else If (Pos(fStrZero(strLinha, 3), '011_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoC(objFormula, intContador -1);
        End
        Else If strCatalize = '2:1' Then
        Begin
          If (Pos(fStrZero(strLinha, 3), '004_001_014_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoA(objFormula,'DIL', intContador -1, strlinha)
          Else If (Pos(fStrZero(strLinha, 3), '008_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoBLinha08(objFormula,'DIL', intContador -1)
          Else If (Pos(fStrZero(strLinha, 3), '058_013_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoB(objFormula,'DIL', intContador -1, strLinha)
          Else
            arrFormul[intContador].fltQtdBas := 0;
        End
        Else
        Begin
          If (Pos(fStrZero(strLinha, 3), '008_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoBLinha08(objFormula,'DI2', intContador -1)
          Else If (Pos(fStrZero(strLinha, 3), '058_013_') > 0) Then
            arrFormul[intContador].fltQtdBas := fCalculoB(objFormula,'DI2', intContador -1, strLinha)
          Else
            arrFormul[intContador].fltQtdBas := 0;
        End;
      end;

      If (strTipPre = 'C') And (arrFormul[intContador].fltQtdBas <= 0) Then
        Continue;

      arrFormul[intContador].strFormul := FieldByName(strLinFor).AsString + '_' +FieldByName(strCamFor).AsString;

      dicBases[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

      {*******************************************}
      {* GUARDA BASES PARA POSTERIOR BUSCA       *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strBases := strBases + QuotedStr(arrFormul[intContador].strFormul);
      If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
        strBases := strBases + ', ';

    End;

    strBases := Trim(strBases);
    If (RightStr(strBases, 1) = ',') Then
      strBases := Copy(strBases, 1, Length(strBases)-1);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_LINHA_, ';
  strSQL := strSQL + '  BAS_CODBAS, ';
  strSQL := strSQL + '  BAS_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WANPRO_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(BAS_LINHA_, "_", BAS_CODBAS) IN (' + strBases + ') ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    intPos := 0;
    SetLength(arrBaixaPigmentos, RecordCount);

    While (Not Eof) Do
    Begin

      {*******************************************}
      {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
      {* DE SALDO EM ML                          *}
      {****************************************MV*}
      stlItensTraMl.Add(FieldByName('BAS_CODITE').AsString);

      arrBaixaPigmentos[intPos].strCodIte   := FieldByName('BAS_CODITE').AsString;
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[FieldByName('BAS_LINHA_').AsString + '_' + FieldByName('BAS_CODBAS').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicBases);
  FreeAndNil(qryConsulta01);

  if Assigned(objFormula) then
    FreeAndNil(objFormula);

end;

function fRetFatVen(strLinha, strCatalize: String): Double;
begin
  Result := 0.900;
  If (Pos(fStrZero(strLinha,3), '008_058_059_') > 0) Then
  Begin
    If (strCatalize = '4:1') Then
      Result := 0.750
    Else If (strCatalize = '2:1') Then
      Result := 0.640
  End
  Else If (Pos(fStrZero(strLinha,3), '013_') > 0) Then
  Begin
    If (strCatalize = '4:1') Then
      Result := 0.750
    Else If (strCatalize = '2:1') Then
      Result := 0.618
  End;
end;

function fDigDadosTintometricos(qryCadPro: TUniQuery; stlDesEmb, stlProEmbLt,
    stlProEmbGl, stlProEmbLa: TStringList; strProEmbCo, strProEmbSp: String; Var strIteEmb, strTipEmb, strTipPre: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro: Double; Var strCatalise: String; strTabPre: String; dicRetorno: TDicionario;
    strProEmbSs: String): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TFormulaColorPro;
  intContador: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := False;
  frmDigTintaAutomotivaColorPro := nil;
  conf := fGetConfTinta('WCP');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TFormulaColorPro.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.blnProPre := IfNull(dicRetorno['propre'], False);

      objFormula.strDescri := qryCadPro.FieldByName('WAN_DESCRI').AsString + ' ' +
                              qryCadPro.FieldByName('WAN_CODAKZ').AsString + ' ' +
                              qryCadPro.FieldByName('WAN_LINHA_').AsString;

      objFormula.strCodFormul := qryCadPro.FieldByName('WAN_CODAKZ').AsString;

      objFormula.fltAcrMob := qryCadPro.FieldByName('WAN_ACRMOB').AsFloat;

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(qryCadPro.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strLinBas := qryCadPro.FieldByName('WAN_LINC' + fStrZero(intContador, 2)).AsString;
        objBase.strCodBas := qryCadPro.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := qryCadPro.FieldByName('WAN_QCON' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltQtdDil := qryCadPro.FieldByName('WAN_QD21' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltQtdDi2 := qryCadPro.FieldByName('WAN_QD41' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltPorcen := qryCadPro.FieldByName('WAN_PORC' + fStrZero(intContador, 2)).AsFloat;
        objBase.strTipBas := 'B';

      End;

      objFormula.pCarregaPrecosBases;

      pCriarFormularios(TfrmDigTintaAutomotivaColorPro, frmDigTintaAutomotivaColorPro);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotivaColorPro.objFormula  := objFormula;
      frmDigTintaAutomotivaColorPro.stlDesEmb   := stlDesEmb;
      frmDigTintaAutomotivaColorPro.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaColorPro.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaColorPro.stlProEmbLa := stlProEmbLa;
      frmDigTintaAutomotivaColorPro.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotivaColorPro.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotivaColorPro.strProEmbSs := strProEmbSs;
      frmDigTintaAutomotivaColorPro.blnMosDil2  := True;
      frmDigTintaAutomotivaColorPro.chkComCat.Visible := False;
      frmDigTintaAutomotivaColorPro.blnConsLinhaDesBas := True;
      frmDigTintaAutomotivaColorPro.strIdePro   := dicRetorno['idepro'];
      frmDigTintaAutomotivaColorPro.Caption     := frmDigTintaAutomotivaColorPro.Caption + 'ColorPro';
      Result := (frmDigTintaAutomotivaColorPro.ShowModal = mrOk);

      objFormula.blnProPre := False;

      If (Result) Then
      Begin
        strIteEmb := frmDigTintaAutomotivaColorPro.objFormula.strCodEmb;



        Case frmDigTintaAutomotivaColorPro.objFormula.tpeTipEmb of
          teLitro  : begin
                       strTipEmb := 'LT';
                       fltEmbala := 0.900;
                     end;
          teCopo   : begin
                       strTipEmb := 'CP';
                       fltEmbala := 0.500;
                     end;
          teGalao  : begin
                       strTipEmb := 'GL';
                       fltEmbala := 3.600;
                     end;
          teSpray  : begin
                       strTipEmb := 'SP';
                       fltEmbala := 0.400;
                     end;
          teLata   : begin
                       strTipEmb := 'LA';
                       fltEmbala := 18.000;
                     end;
        end;

        strTipPre := IIF(frmDigTintaAutomotivaColorPro.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaColorPro.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaColorPro.objFormula.fltPrecoEmbalagem;

        strCatalise := '';
        If (strTipPre = 'D')  Then
        Begin
          strCatalise := frmDigTintaAutomotivaColorPro.cmbListaAdicional.Text;
          If fEmptyStr(strCatalise)  Then
            strCatalise := '2:1';
          //If (objFormula.intIndiceAdicional = 0) Then
          //  strCatalise := '2:1'
          //Else If (objFormula.intIndiceAdicional = 1) Then
          //  strCatalise := '4:1';
        End;

        If (frmDigTintaAutomotivaColorPro.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotivaColorPro.objFormula.fltPrecoCusCon;
          fltPreCu2 := frmDigTintaAutomotivaColorPro.objFormula.fltPrecoCu2Con;
          fltPreVen := frmDigTintaAutomotivaColorPro.objFormula.fltPrecoVenCon;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotivaColorPro.objFormula.fltPrecoCusDil;
          fltPreCu2 := frmDigTintaAutomotivaColorPro.objFormula.fltPrecoCu2Dil;
          fltPreVen := frmDigTintaAutomotivaColorPro.objFormula.fltPrecoVenDil;
        End;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaColorPro.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaColorPro.objFormula.fltPreMedCon,
          frmDigTintaAutomotivaColorPro.objFormula.fltPreMedDil) +
          frmDigTintaAutomotivaColorPro.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaColorPro.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaColorPro.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaColorPro.objFormula.fltImpUltDil) +
          frmDigTintaAutomotivaColorPro.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaColorPro.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaColorPro.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaColorPro.objFormula.fltPreUltDil) +
          frmDigTintaAutomotivaColorPro.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotivaColorPro.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaColorPro.objFormula.fltComLiqCon,
          frmDigTintaAutomotivaColorPro.objFormula.fltComLiqDil) +
          frmDigTintaAutomotivaColorPro.objFormula.fltPrecoCompraLiquidoEmbalagem;

        fltPreCus := fltPreCus + frmDigTintaAutomotivaColorPro.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := fltPreCu2 + frmDigTintaAutomotivaColorPro.objFormula.fltPrecoCusto2Embalagem;
        fltPreVen := fltPreVen + fltPreEmb;

        fltVolPro := frmDigTintaAutomotivaColorPro.objFormula.fltVolumePro;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['promoc'] := frmDigTintaAutomotivaColorPro.objFormula.StrPromoc;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['obscolorista']   := frmDigTintaAutomotivaColorPro.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotivaColorPro.rdgTipoFormula.ItemIndex;

        dicRetorno['saldocols'] := frmDigTintaAutomotivaColorPro.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaColorPro.matrizSaldosColorantes);
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
    if Assigned(frmDigTintaAutomotivaColorPro) then FreeAndNil(frmDigTintaAutomotivaColorPro);
    if Assigned(frmDigTintaAutomotivaColorPro) then FreeAndNil(frmDigTintaAutomotivaColorPro);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
End;

{ TFormulaColorPro }

constructor TFormulaColorPro.Create(strTabPre: String);
  Var
    conf: IConfTinta;
begin
  inherited Create(strTabPre);
  FDadosAdicionais  := True;
  FCaptionAdicional := 'Catálise';
  FAdicionalDiluido := True;
  conf := fGetConfTinta('WCP');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  fltAcrMob := 0;
end;

function TFormulaColorPro.fRetMatrizSaldosColorantes: TClassMatrizSaldosColorantes;
  Var
    intCont: Integer;
    objBase: TBaseAutomotiva;
//    fltSaldo: Double;
    fltQtdFormul: Double;
    bln4Por1: Boolean;
    qryGen : TUniQuery;
    saldosColorantes: TSaldosColorantes;
begin
  Result := TClassMatrizSaldosColorantes.Create;

  For intCont := 0 To Self.Count - 1 Do
  Begin
    objBase := TBaseAutomotiva(Items[intCont]);
    qryCadBas.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([objBase.strCodBas, objBase.strLinBas]), []);

    bln4Por1 := False;
    If (Pos(fStrZero(objBase.strLinBas,3), '008_058_059_013_') > 0) And (mveModoVenda = mvDiluido) Then
    Begin
      {***************************************************}
      {* CASO ESCOLHEU 4 POR 1 NO DILUIDO                *}
      {** 15/07/2008 - 08:46 **************************MV*}
      {*******************************************}
      {* QUANDO LINHA 8 PODE ESCOLHER 2:1 OU 4:1 *}
      {****************************************PH*}
      If Pos(fStrZero(objBase.strLinBas,3),  '008_013') > 0 Then
      Begin
        bln4Por1 := (Self.intIndiceAdicional = 1);
      End
      Else
      Begin
        {*******************************************************}
        {* QUANDO LINHA 58 SOMENTE 4:1 (UNICO ITEM NA COMBOBOX)*}
        {****************************************************PH*}
        bln4Por1 := (Self.intIndiceAdicional = 0);
      End;
    End;

    fltQtdFormul := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, IfThen(bln4Por1, objBase.fltQtdDi2, objBase.fltQtdDil) ) * (Self.fltVolumePro / Self.fltVolumeOri);

    If (Copy(Self.strCodFormul,1,3) = 'ESP') Then
    Begin
      fltQtdFormul := fArredondaColorPro(fltQtdFormul);
    End
    Else
    Begin
      If ((mveModoVenda = mvConcentrado)) Then
      Begin
        If (Pos(fStrZero(objBase.strLinBas, 3), '004_001_014_006_009_027') > 0) Then
          fltQtdFormul := fCalculoA(Self ,'CON', intCont, objBase.strLinBas)
        Else If (Pos(fStrZero(objBase.strLinBas, 3), '008_') > 0) Then
          fltQtdFormul := fCalculoBLinha08(Self ,'CON', intCont)
        Else If (Pos(fStrZero(objBase.strLinBas, 3), '058_013_') > 0) Then
          fltQtdFormul := fCalculoB(Self ,'CON', intCont, objBase.strLinBas)
        Else If (Pos(fStrZero(objBase.strLinBas, 3), '011_') > 0) Then
          fltQtdFormul := fCalculoC(Self , intCont);
      End
      Else If (Not bln4Por1) Then
      Begin
        If (Pos(fStrZero(objBase.strLinBas, 3), '004_001_014_') > 0) Then
          fltQtdFormul := fCalculoA(Self ,'DIL', intCont, objBase.strLinBas)
        Else If (Pos(fStrZero(objBase.strLinBas, 3), '008_') > 0) Then
          fltQtdFormul := fCalculoBLinha08(Self ,'DIL', intCont)
        Else If (Pos(fStrZero(objBase.strLinBas, 3), '058_013_') > 0) Then
          fltQtdFormul := fCalculoB(Self ,'DIL', intCont, objBase.strLinBas);
      End
      Else
      Begin
        If (Pos(fStrZero(objBase.strLinBas, 3), '008_') > 0) Then
          fltQtdFormul := fCalculoBLinha08(Self ,'DI2', intCont)
        Else If (Pos(fStrZero(objBase.strLinBas, 3), '058_013_') > 0) Then
          fltQtdFormul := fCalculoB(Self ,'DI2', intCont, objBase.strLinBas);
      End;
    End;

    If fltQtdFormul > 0 Then
    Begin

      saldosColorantes.fltQtdFormula := fltQtdFormul;
      saldosColorantes.fltQtdFormOri := fltQtdFormul;
      saldosColorantes.strCodCol := objBase.strCodBas;
      saldosColorantes.intIDTinta := 1;
      saldosColorantes.strDescTinta := Self.strDescri;
      saldosColorantes.strCodIte := qryCadBas.FieldByName('BAS_CODITE').AsString;
      saldosColorantes.strDesIte := fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', qryCadBas.FieldByName('BAS_CODITE').AsString);
      saldosColorantes.strBasCol := BASE_AUTOMOTIVA;
      Result.fAdicionar(saldosColorantes);
    End;
    
  End;

  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT IFNULL(ITE_SALDOS,0.000) ITE_SALDOS FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
  qryGen.ParamByName('CODITE').AsString := Self.strCodEmb;
  qryGen.ParamByName('CODEMP').AsString := strCodEmpEst;
  qryGen.Open;

  FreeAndNil(qryGen);
end;


procedure TFormulaColorPro.pAdicionarEmbalagem(
  matSaldosBases: TClassMatrizSaldosColorantes);
  Var
    saldosColorantes: TSaldosColorantes;
begin
  saldosColorantes.fltQtdFormula := Self.intQtdEmb;
  saldosColorantes.fltQtdFormOri := Self.intQtdEmb;
  saldosColorantes.strCodCol := Self.strCodEmb;
  saldosColorantes.intIDTinta := 2;
  saldosColorantes.strDescTinta := 'EMBALAGEM';
  saldosColorantes.strCodIte := Self.strCodEmb;
  saldosColorantes.strDesIte := fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', Self.strCodEmb);
  saldosColorantes.strBasCol := EMBALAGEM;
  matSaldosBases.fAdicionar(saldosColorantes);

end;

procedure TFormulaColorPro.pCalcularPrecos;
var
  intIndex     : Integer;
  objBase      : TBaseAutomotiva;
  fltPreCusBas : Double;
  fltPreCu2Bas : Double;
  fltPreVenBas : Double;
  fltPesoBase  : Double;
  fltQtdCon    : Double;
  fltQtdDil    : Double;
  bln4Por1     : Boolean;
  fltPreCusPro : Double;
  fltPreVenPro : Double;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    FPrecoCusCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoVenDil := 0.0;

    FOutValCon := 0;
    FIcmsaiCon := 0;
    FImpFedCon := 0;
    FDesOpeCon := 0;
    FPreMedCon := 0;
    FPreUltCon := 0;
    FImpUltCon := 0;
    FComLiqCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;
    FPreUltDil := 0;
    FImpUltDil := 0;
    FComLiqDil := 0;
  End;
begin
  inherited;

  pZerarPrecos;

  objBase := TBaseAutomotiva(Items[0]);

  bln4Por1 := False;
  fltVolumeOri := 0.900;
  If (Pos(fStrZero(objBase.strLinBas,3), '008_058_059_013_') > 0) And (mveModoVenda = mvDiluido) Then
  Begin
    {***************************************************}
    {* CASO ESCOLHEU 4 POR 1 NO DILUIDO                *}
    {** 15/07/2008 - 08:46 **************************MV*}
    {********************************************}
    {* QUANDO LINHA 8 OPODE ESCOLHER 2:1 OU 4:1 *}
    {*****************************************PH*}
    If objBase.strLinBas = '8' Then
    Begin
      bln4Por1 := (Self.intIndiceAdicional = 1);
      If bln4Por1 Then
        fltVolumeOri := 0.750
      Else
        fltVolumeOri := 0.640;
    End
    Else If objBase.strLinBas = '13' Then
    Begin
      bln4Por1 := (Self.intIndiceAdicional = 1);
      If bln4Por1 Then
        fltVolumeOri := 0.750
      Else
        fltVolumeOri := 0.618;
    End
    Else
    Begin
      {*******************************************************}
      {* QUANDO LINHA 58 SOMENTE 4:1 (UNICO ITEM NA COMBOBOX)*}
      {****************************************************PH*}
      bln4Por1 := (Self.intIndiceAdicional = 0);
      fltVolumeOri := 0.750;
    End;
  End;

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    //Diluente
    If (objBase.fltQtdCon = 0) And (Self.blnTemConcentrado) And (Self.FModoVenda = mvConcentrado) Then
      Continue;

    If (Not qryCadBas.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([objBase.strCodBas, objBase.strLinBas]), [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (qryCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + qryCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    //if not IsItemAtivo(qryCadBas.FieldByName('BAS_CODITE').AsString) then
    If qryCadBas.FieldByName('ITE_ITEATI').AsString <> 'S' Then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

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

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) And (Not Self.blnProPre) Then
    Begin
      fltPreCusBas := fltPreCusPro;
      fltPreVenBas := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusBas = 0 Then
        fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenBas := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenBas,
                                        fltPreCusBas,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltPesoBase  := objBase.fltEmbala * objBase.fltPesEsp;

    If (Copy(strCodFormul,1,3) = 'ESP') Or Not(Pos(fStrZero(objBase.strLinBas, 3), '004_001_014_013_011_027_008_058_009_006_') > 0) Then
    Begin
      fltQtdCon := objBase.fltQtdCon;

      If bln4Por1 Then
        fltQtdDil := objBase.fltQtdDi2
      Else
        fltQtdDil := objBase.fltQtdDil;

      fltQtdCon := RoundTo(fltQtdCon / fltVolumeOri * fltVolumePro,-1);
      fltQtdDil := RoundTo(fltQtdDil / fltVolumeOri * fltVolumePro,-1);
    end
    else
    Begin
      If (Pos(fStrZero(objBase.strLinBas, 3), '004_001_014_') > 0) Then
      begin
        fltQtdCon := fCalculoA(Self,'CON', intIndex, objBase.strLinBas);
        fltQtdDil := fCalculoA(Self,'DIL', intIndex, objBase.strLinBas);
      end
      Else If (Pos(fStrZero(objBase.strLinBas, 3), '008_') > 0) Then
      begin
        fltQtdCon := fCalculoBLinha08(Self,'CON', intIndex);
        If bln4Por1 Then
          fltQtdDil := fCalculoBLinha08(Self,'DI2', intIndex)
        Else
          fltQtdDil := fCalculoBLinha08(Self,'DIL', intIndex);
      end
      Else If (Pos(fStrZero(objBase.strLinBas, 3), '058_013_') > 0) Then
      begin
        fltQtdCon := fCalculoB(Self,'CON', intIndex, objBase.strLinBas);
        if bln4Por1 then
          fltQtdDil := fCalculoB(Self,'DI2', intIndex, objBase.strLinBas)
        else
          fltQtdDil := fCalculoB(Self,'DIL', intIndex, objBase.strLinBas);
      end
      Else If (Pos(fStrZero(objBase.strLinBas, 3), '011_') > 0) Then
      begin
        fltQtdCon := fCalculoC(Self, intIndex);
        fltQtdDil := 0;
      end
      Else
      begin
        fltQtdCon := fCalculoA(Self,'CON', intIndex, objBase.strLinBas);
        fltQtdDil := 0;
      end;
    end;

    componente[mvConcentrado].Quantidade                := fltQtdCon;
    componente[mvDiluido].Quantidade                    := fltQtdDil;

    componente[mvConcentrado].OutrosValores             := (fltQtdCon * objBase.fltOutVal) / fltPesoBase;
    componente[mvConcentrado].PrecoMedio                := (fltQtdCon * objBase.fltPreMed) / fltPesoBase;
    componente[mvConcentrado].UltimoPrecoCompra         := (fltQtdCon * objBase.fltPreUlt) / fltPesoBase;
    componente[mvConcentrado].UltimoPrecoCompraImpostos := (fltQtdCon * objBase.fltImpUlt) / fltPesoBase;
    componente[mvConcentrado].PrecoCompraLiquido        := (fltQtdCon * objBase.fltComLiq) / fltPesoBase;
    componente[mvConcentrado].IcmsSaida                 := ((fltQtdCon * fltPreVenBas) / fltPesoBase) * objBase.fltIcmSai / 100;
    componente[mvConcentrado].ImpostosFederais          := ((fltQtdCon * fltPreVenBas) / fltPesoBase) * objBase.fltImpFed / 100;
    componente[mvConcentrado].DespesasOperacionais      := ((fltQtdCon * fltPreVenBas) / fltPesoBase) * objBase.fltDesOpe / 100;
    componente[mvConcentrado].PrecoCusto                := (fltQtdCon * fltPreCusBas) / fltPesoBase;
    componente[mvConcentrado].PrecoCustoReal            := (fltQtdCon * fltPreCu2Bas) / fltPesoBase;
    componente[mvConcentrado].PrecoVenda                := (fltQtdCon * fltPreVenBas) / fltPesoBase;

    componente[mvDiluido].OutrosValores                 := (fltQtdDil * objBase.fltOutVal) / fltPesoBase;
    componente[mvDiluido].PrecoMedio                    := (fltQtdDil * objBase.fltPreMed) / fltPesoBase;
    componente[mvDiluido].UltimoPrecoCompra             := (fltQtdDil * objBase.fltPreUlt) / fltPesoBase;
    componente[mvDiluido].UltimoPrecoCompraImpostos     := (fltQtdDil * objBase.fltImpUlt) / fltPesoBase;
    componente[mvDiluido].PrecoCompraLiquido            := (fltQtdDil * objBase.fltComLiq) / fltPesoBase;
    componente[mvDiluido].IcmsSaida                     := ((fltQtdDil * fltPreVenBas) / fltPesoBase) * objBase.fltIcmSai / 100;
    componente[mvDiluido].ImpostosFederais              := ((fltQtdDil * fltPreVenBas) / fltPesoBase) * objBase.fltImpFed / 100;
    componente[mvDiluido].DespesasOperacionais          := ((fltQtdDil * fltPreVenBas) / fltPesoBase) * objBase.fltDesOpe / 100;
    componente[mvDiluido].PrecoCusto                    := (fltQtdDil * fltPreCusBas) / fltPesoBase;
    componente[mvDiluido].PrecoCustoReal                := (fltQtdDil * fltPreCu2Bas) / fltPesoBase;
    componente[mvDiluido].PrecoVenda                    := (fltQtdDil * fltPreVenBas) / fltPesoBase;

{
    fltPesoBase  := objBase.fltEmbala * objBase.fltPesEsp;

    If (Copy(strCodFormul,1,3) = 'ESP') Or Not(Pos(fStrZero(objBase.strLinBas, 3), '004_001_014_013_011_027_008_058_009_006_') > 0) Then
    Begin
      fltQtdCon := objBase.fltQtdCon;

      If bln4Por1 Then
        fltQtdDil := objBase.fltQtdDi2
      Else
        fltQtdDil := objBase.fltQtdDil;

      fltQtdCon := RoundTo(fltQtdCon / fltVolumeOri * fltVolumePro,-1);
      fltQtdDil := RoundTo(fltQtdDil / fltVolumeOri * fltVolumePro,-1);
    end
    else
    Begin
      If (Pos(fStrZero(objBase.strLinBas, 3), '004_001_014_') > 0) Then
      begin
        fltQtdCon := fCalculoA(Self,'CON', intIndex, objBase.strLinBas);
        fltQtdDil := fCalculoA(Self,'DIL', intIndex, objBase.strLinBas);
      end
      Else If (Pos(fStrZero(objBase.strLinBas, 3), '008_') > 0) Then
      begin
        fltQtdCon := fCalculoBLinha08(Self,'CON', intIndex);
        If bln4Por1 Then
          fltQtdDil := fCalculoBLinha08(Self,'DI2', intIndex)
        Else
          fltQtdDil := fCalculoBLinha08(Self,'DIL', intIndex);
      end
      Else If (Pos(fStrZero(objBase.strLinBas, 3), '058_013_') > 0) Then
      begin
        fltQtdCon := fCalculoB(Self,'CON', intIndex, objBase.strLinBas);
        if bln4Por1 then
          fltQtdDil := fCalculoB(Self,'DI2', intIndex, objBase.strLinBas)
        else
          fltQtdDil := fCalculoB(Self,'DIL', intIndex, objBase.strLinBas);
      end
      Else If (Pos(fStrZero(objBase.strLinBas, 3), '011_') > 0) Then
      begin
        fltQtdCon := fCalculoC(Self, intIndex);
        fltQtdDil := 0;
      end
      Else
      begin
        fltQtdCon := fCalculoA(Self,'CON', intIndex, objBase.strLinBas);
        fltQtdDil := 0;
      end;
    end;

    FOutValCon := FOutValCon + (fltQtdCon * objBase.fltOutVal) / fltPesoBase;
    FOutValDil := FOutValDil + (fltQtdDil * objBase.fltOutVal) / fltPesoBase;

    FIcmsaiCon := FIcmsaiCon + ((fltQtdCon * fltPreVenBas) / fltPesoBase) * objBase.fltIcmSai / 100;
    FIcmsaiDil := FIcmsaiDil + ((fltQtdDil * fltPreVenBas) / fltPesoBase) * objBase.fltIcmSai / 100;

    FImpFedCon := FImpFedCon + ((fltQtdCon * fltPreVenBas) / fltPesoBase) * objBase.fltImpFed / 100;
    FImpFedDil := FImpFedDil + ((fltQtdDil * fltPreVenBas) / fltPesoBase) * objBase.fltImpFed / 100;

    FDesOpeCon := FDesOpeCon + ((fltQtdCon * fltPreVenBas) / fltPesoBase) * objBase.fltDesOpe / 100;
    FDesOpeDil := FDesOpeDil + ((fltQtdDil * fltPreVenBas) / fltPesoBase) * objBase.fltDesOpe / 100;

    FPreMedCon := FPreMedCon + (fltQtdCon * objBase.fltPreMed) / fltPesoBase;
    FPreMedDil := FPreMedDil + (fltQtdDil * objBase.fltPreMed) / fltPesoBase;

    FPrecoCusCon := FPrecoCusCon + (fltQtdCon * fltPreCusBas) / fltPesoBase;
    FPrecoCusDil := FPrecoCusDil + (fltQtdDil * fltPreCusBas) / fltPesoBase;

    FPrecoCu2Con := FPrecoCu2Con + (fltQtdCon * fltPreCu2Bas) / fltPesoBase;
    FPrecoCu2Dil := FPrecoCu2Dil + (fltQtdDil * fltPreCu2Bas) / fltPesoBase;

    FPrecoVenCon := FPrecoVenCon + (fltQtdCon * fltPreVenBas) / fltPesoBase;
    FPrecoVenDil := FPrecoVenDil + (fltQtdDil * fltPreVenBas) / fltPesoBase;

    FPreUltCon := FPreUltCon + (fltQtdCon * objBase.fltPreUlt) / fltPesoBase;
    FPreUltDil := FPreUltDil + (fltQtdDil * objBase.fltPreUlt) / fltPesoBase;

    FImpUltCon := FImpUltCon + (fltQtdCon * objBase.fltImpUlt) / fltPesoBase;
    FImpUltDil := FImpUltDil + (fltQtdDil * objBase.fltImpUlt) / fltPesoBase;

    FComLiqCon := FComLiqCon + (fltQtdCon * objBase.fltComLiq) / fltPesoBase;
    FComLiqDil := FComLiqDil + (fltQtdDil * objBase.fltComLiq) / fltPesoBase;
}
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

  FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;

  FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;

  FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;

  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
  FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;

  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
  FPrecoVenDil := FPrecoVenDil + (fltPerAcr * FPrecoVenDil);

{
  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
  FPrecoVenDil := FPrecoVenDil + (fltPerAcr * FPrecoVenDil);
}

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMob;

  If FPrecoVenDil > 0 Then
    FPrecoVenDil := FPrecoVenDil + fltAcrMob;
end;

procedure TFormulaColorPro.pCarregaPrecosBases;
  Var
    intContador    : Integer;
    objBase        : TBaseAutomotiva;
    conf           : IConfTinta;
    fltDesOpeTinta : Double;
    fltPreCusPro   : Double;
    fltPreVenPro   : Double;
begin
  conf := fGetConfTinta('WCP');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  objBase := TBaseAutomotiva(Self.Items[0]);

  If Pos(fStrZero(objBase.strLinBas, 2), '08_13_') > 0 Then
  Begin
    FListaAdicional.Add('2:1');
    If Pos(fStrZero(objBase.strLinBas,3),  '008_013_') > 0 Then
      FListaAdicional.Add('4:1');
  End
  Else If Pos(fStrZero(objBase.strLinBas, 2), '58_59_') > 0 Then
  Begin
    FListaAdicional.Add('4:1');
  End
  Else
    FAdicionalDiluido := False;

  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    qryCadBas.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([objBase.strCodBas,objBase.strLinBas]) , []);

    objBase.fltEmbala := qryCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := qryCadBas.FieldByName('BAS_PESESP').AsFloat;

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) And (Not Self.blnProPre) Then
    Begin
      objBase.fltPreVen := fltPreVenPro;
      FPromoc := 'S';
    End
    else
    begin
      objBase.fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    end;

    objBase.strImpDir := qryCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := qryCadBas.FieldByName('BAS_CODITE').AsString;

    objBase.fltOutVal := qryCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := qryCadBas.FieldByName('ITE_ICMSAI').AsFloat;

    objBase.fltImpFed := qryCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := qryCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := qryCadBas.FieldByName('ITE_PREMED').AsFloat;
    objBase.fltPreUlt := qryCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltImpUlt := qryCadBas.FieldByName('ITE_IMPULT').AsFloat;
    objBase.fltComLiq := fCalculaPrecoCompraLiq(qryCadBas.Fieldbyname('ITE_PRECOM').AsFloat, qryCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF02').AsFloat, qryCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF04').AsFloat, qryCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Add('PesoBase = Embalagem * PesoEspecifico');
  FCalculo.Add('Valor da Base = Quantidade * Preço / PesoBase');
  FCalculo.Add('Preço da Tinta = Soma do Valor da Base de todas as bases.');

end;

procedure TFormulaColorPro.pCarregarColorantes;
  Var
    fltFcuWan: Double;
    strFcuWan: String;
begin
  inherited;

  {***************************************************}
  {* ATENÇÃO: ESSE FATOR É DE PREÇO DE CUSTO         *}
  {** 17/07/2008 - 13:17 **************************MV*}
  fltFcuWan := fGetConfTinta('WCP').fGetDouble('FVEWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FVEWAN', '1'));
  strFcuWan := AnsiReplaceStr(FloatToStr(fltFcuWan), ',', '.');

  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_LINHA_                         ');
  qryCadBas.SQL.Add('   , BAS_CODBAS                       ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');
  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');
  qryCadBas.SQL.Add('   , ITE_ITEATI                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
    qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_PREMED                  ');
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PREVEN * ' + strFcuWan + ' AS ITE_PRECUS         ');
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
  qryCadBas.SQL.Add('   WANPRO_CADBAS                      ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');
  qryCadBas.SQL.Add(' ORDER BY BAS_CODBAS,BAS_LINHA_       ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;
end;

procedure pRetornaDadosWandaProDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadWan: TUniQuery;
    strSQL: String;
begin
  qryCadWan := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT                     ';
  strSQL := strSQL + '   *                        ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   WANPRO_CADWAN            ';
  strSQL := strSQL + ' WHERE WAN_MD5KEY = :ITETIN ';

  With qryCadWan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If IsEmpty Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  WANPRO_CADWAN ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ';
      strSQL := strSQL + ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ';
      strSQL := strSQL + ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      Open;

      If IsEmpty Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM WANPRO_CADWAN WHERE WAN_CODSEQ = :ITETIN');
        ParamByName('ITETIN').AsString := strIteTin;
        Open;
      End;
    End;

    dicRetorno['codtin'] := FieldByName('WAN_CODAKZ').AsString;
    dicRetorno['montad'] := FieldByName('WAN_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('WAN_LINHA_').AsString;
    Close;
  End;

  FreeAndNil(qryCadWan);
end;

procedure pRetornaTabelaPrecoColorPro(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TFormulaColorPro;
  objBase: TBaseAutomotiva;
  intContador: Integer;

  strBasTmp: String;
  strCodBas: String;
  strLinBas: String;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;

  strTabelaUnica: String;
  bln4Por1: Boolean;
begin
  conf := fGetConfTinta('WCP');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaColorPro.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltAcrMob := fRetornaAcrescimoMaoObra(dicRetorno['itetin'], dicRetorno['linha_']);

      objFormula.fltVolumeOri := fRetFatVen(IfNull(dicRetorno['linha_'], ''), IfNull(dicRetorno['catali'], '')); //0.9;
      objFormula.fltVolumePro := dicRetorno['volpro'];

      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;
      objFormula.strCodEmb := dicRetorno['iteemb'];
      objFormula.strCodFormul := fRetornaCodAkzo(dicRetorno['itetin']);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.intIndiceAdicional := fRetIndiceAdicional(IfNull(dicRetorno['linha_'], ''), IfNull(dicRetorno['catali'], ''));

      bln4Por1 := fRet4Por1(IfNull(dicRetorno['linha_'], ''), IfNull(dicRetorno['catali'], ''));

      For intContador := 1 To 15 Do
      Begin

        strBasTmp := IfNull(dicRetorno['base' + fStrZero(intContador, 2)], '');

        If (fEmptyStr(strBasTmp)) Then
          Break;

        If (strBasTmp = '_') Then
          Break;

        strCodBas := Copy(strBasTmp, Pos('_', strBasTmp)+1, Length(strBasTmp));
        strLinBas := Copy(strBasTmp, 1, Pos('_', strBasTmp)-1);

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strLinBas := strLinBas;
        objBase.strCodBas := strCodBas;
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro
        Else
        Begin
          If bln4Por1 Then
            objBase.fltQtdDi2 := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro
          Else
            objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro;
        End;
        objBase.strTipBas := 'B';
        objBase.fltPorcen := fRetornaPorcento(dicRetorno['itetin'],intContador);
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');

      If Not fEmptyStr(strTabelaUnica) Then
      Begin
        objFormula.strTabPre := strTabelaUnica;
        objFormula.pCarregarColorantes;
        objFormula.pCarregaPrecosBases;
        objFormula.pCalcularPrecos;

        If IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
          Else
            dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
        End;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
        End;

        objFormula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
        dicRetorno['promoc'] := objFormula.StrPromoc;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End
        Else
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End;
      End
      Else
      Begin
        strTabelas := fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

        For intContador := 1 To Length(strTabelas) Do
        Begin
          if strTabelas[intContador] = 'S' then
          begin
            objFormula.strTabPre := IntToStr(intContador);
            objFormula.pCarregarColorantes;
            objFormula.pCarregaPrecosBases;
            objFormula.pCalcularPrecos;
            If IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If dicRetorno['tippre'] = 'C' Then
                dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
              Else
                dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
            End
            Else
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
            End;

            If intContador = IfNull(dicRetorno['tabpre'], 0) Then
            Begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
              dicRetorno['promoc'] := objFormula.StrPromoc;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End
            Else
            Begin
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End;
          end;
        End;
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

procedure TConsultaColorPro.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;

  strProEmbCo: String;
  strProEmbSp: String;

  strIteEmb: String;
  strTipEmb: String;
  strTipPre: String;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  fltVolPro: Double;
  strCatalize: String;

  strProEmbSs: String;
  dicParams  : TDicionario;
  conf       : IConfTinta;
begin
  dicParams := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbLa := nil;

  qryGen := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('WCP');  

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM WANPRO_CADWAN WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;

      stlDesEmb.Add('NORMAL');

{      If (fLinhaEhWanda(qryGen.FieldByName('WAN_LINHA_').AsString)) Or (fEmptyStr(conf.fGet('SIKIEM'))) Then
      Begin
        stlProEmbLt.Add(conf.fGet('WANIEM'));
        stlProEmbGl.Add(conf.fGet('WANIGL'));
        stlProEmbLa.Add(conf.fGet('WANILA'));
      End
      Else
      Begin
        stlProEmbLt.Add(conf.fGet('SIKIEM'));
        stlProEmbGl.Add(conf.fGet('SIKIGL'));
        stlProEmbLa.Add(conf.fGet('SIKILA'));
      End;}

      pPreencheProdutoEmbalagem(stlProEmbLt, stlProEmbGl, stlProEmbLa, qryGen, conf);

      strProEmbCo := conf.fGet('WANICO');
      strProEmbSp := conf.fGet('WANISP');
      strProEmbSs := conf.fGet('WANISS');

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'WCP';

      fDigDadosTintometricos(qryGen, stlDesEmb, stlProEmbLt,
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
        strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
        fltPreCus, fltUnitar, fltVolPro, strCatalize, strTabPre, dicParams,  strProEmbSs);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicParams) then FreeAndNil(dicParams);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TConsultaColorPro.pTarefaPrecos(Sender: TObject);
begin
  pTarefaFormulacao(Sender);
end;

procedure TConsultaColorPro.pTarefaVenda(Sender: TObject);
begin
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadWanProNovasFormulas', False);
end;

function fConsultaWandaProInterna(Sender: TForm; Var qryCadWan: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
  Var
    //strSQL: String;
    strLinWan: String;
    //stlCamIndWan: TStringList;
    //stlDesIndWan: TStringList;

    strLinhaWandaPro: String;
    arrOpcoes: Array Of String;
    intOpcao: Integer;

    //frmConsulta : TConsultaColorPro;
begin
  Result := '-1';

  If Not Assigned(qryCadWan) Then
    Exit;

//  strLinWan := fArqIniTinta(0, 'COLOR PRO', 'LINWAN', '');
  strLinWan := fGetConfTinta('WCP').fGet('LINWAN');

  If Pos('001', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 1 Autobase Plus 100:50';
  End;

  If Pos('004', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 4 Wandabase HS';
  End;

  If Pos('006', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 6 Wandalac';
  End;

  If Pos('008', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 8 Wanda PU HS';
  End;

  If Pos('009', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 9 Wandacar';
  End;

  If Pos('011', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '11 Single Stage Converter';
  End;

  If Pos('012', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '12 Autobase Plus Baseline 100:80';
  End;

  If Pos('014', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '14 Autobase Plus 100:80';
  End;

  If Pos('016', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '16 Autocoat BT120';
  End;

  If Pos('019', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '19 Autobase Plus Baseline 100:50';
  End;

  If Pos('058', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '58 Wanda PU MS';
  End;

  If Pos('059', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '59 Autocoat BT90';
  End;

  If Pos('013', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '13 Autocoat BT100';
  End;

  If Pos('15', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '15 Autocoat BT110';
  End;

  If Pos('17', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '17 Autocoat BT130';
  End;

  If Pos('27', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '27 Autowave MM';
  End;

  If Pos('72', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '72 Tech Fleet PU';
  End;

  If Pos('74', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '74 Tech Fleet Epoxy';
  End;

  If Pos('75', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '75 Tech Fleet Sintetico';
  End;

  If Pos('76', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '76 Tech Fleet Laca';
  End;

  strLinhaWandaPro := '';
  If Length(arrOpcoes) >= 2 Then
  Begin
    intOpcao := fGetMenu('Linha', arrOpcoes, 1);
    strLinhaWandaPro := Trim(LeftStr(arrOpcoes[intOpcao-1], 2));
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    strLinhaWandaPro := Trim(LeftStr(arrOpcoes[intOpcao-1], 2));
  End;

{
  stlCamIndWan := TStringList.Create;
  stlDesIndWan := TStringList.Create;

  stlCamIndWan.Add('WAN_DESCRI');
  stlCamIndWan.Add('WAN_CODAKZ');
  stlCamIndWan.Add('WANPRO_CODUNI');

  stlDesIndWan.Add('Descricao');
  stlDesIndWan.Add('Codigo');
  stlDesIndWan.Add('Cód. Universal');

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  WAN_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  WAN_CODAKZ AS "Codigo", ';
  strSQL := strSQL + '  WAN_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  WAN_ALTERN AS "Variação", ';
  strSQL := strSQL + '  WAN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  WAN_CAMADA AS "Camada", ';
  strSQL := strSQL + '  WAN_ANOINI AS "Ano Inicial", ';
  strSQL := strSQL + '  WAN_ANOFIN AS "Ano Final", ';
  strSQL := strSQL + '  CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS "Cód. Universal", ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WANPRO_CADWAN ';
  strSQL := strSQL + '  LEFT JOIN WANPRO_CODUNI ON WANPRO_CODAKZ = WAN_CODAKZ AND ';
  strSQL := strSQL + '                             WANPRO_ALTERN = WAN_ALTERN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  WAN_LINHA_ = ' + QuotedStr(strLinhaWandaPro) + ' ';

  frmConsulta := TConsultaColorPro.Create(Sender, tipoConsulta, strTabPre);
  frmConsulta.Caption := 'Consulta Color Pro';

  If (pConsultaEspecifica(Sender, frmConsulta, qryCadWan, 'WANPRO_CADWAN',
        strSQL, stlCamIndWan, stlDesIndWan, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadWan.IsEmpty) Then
      Result := qryCadWan.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsulta);
  FreeAndNil(stlCamIndWan);
  FreeAndNil(stlDesIndWan);
}

//  (TWandaProConsulta.Create).strLinhaWandaPro := strLinhaWandaPro;

  Result := (TWandaProConsulta.Create).fExecutarConsulta(Sender,
    qryCadWan, tipoConsulta, strTabPre, TConsultaColorPro, strLinhaWandaPro, blnFaturamento, dicRetorno, sltItems);

end;

function fVerificaQuantidadeCamadas(strIteTin: String): Integer;
  Var
    qryGen: TUniQuery;
    qryGen2: TUniQuery;
    strSQL: String;
begin
  Try
    qryGen := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + ' SELECT                     ';
    strSQL := strSQL + '   *                        ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   WANPRO_CADWAN            ';
    strSQL := strSQL + ' WHERE WAN_MD5KEY = :ITETIN ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('ITETIN').AsString := strIteTin;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  WANPRO_CADWAN ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ';
      strSQL := strSQL + ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ';
      strSQL := strSQL + ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add('SELECT * FROM WANPRO_CADWAN WHERE WAN_CODSEQ = :ITETIN');
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      End;
    End;

    qryGen2 := fCriaQuery();
    qryGen2.Close;
    qryGen2.SQL.Clear;

    qryGen2.SQL.Add(' SELECT SQL_NO_CACHE ');
    qryGen2.SQL.Add('   COUNT(*)    QTD ');
    qryGen2.SQL.Add(' FROM WANPRO_CADWAN ');
    qryGen2.SQL.Add(' WHERE WAN_CAMADA IS NOT NULL ');
    qryGen2.SQL.Add('   AND WAN_LINHA_ = :LINHA_   ');
    qryGen2.SQL.Add('   AND WAN_CODAKZ = :CODAKZ   ');
    qryGen2.SQL.Add('   AND WAN_ALTERN = :ALTERN   ');
    qryGen2.SQL.Add('   AND WAN_DESCRI = :DESCRI   ');
    qryGen2.SQL.Add('   AND WAN_MONTAD = :MONTAD   ');
    qryGen2.SQL.Add('   AND WAN_VERCOR = :VERCOR   ');
    qryGen2.SQL.Add('   AND WAN_ANOINI = :ANOINI   ');
    qryGen2.SQL.Add('   AND WAN_ANOFIN = :ANOFIN   ');

    qryGen2.ParamByName('LINHA_').AsString := qryGen.FieldByName('WAN_LINHA_').AsString;
    qryGen2.ParamByName('CODAKZ').AsString := qryGen.FieldByName('WAN_CODAKZ').AsString;
    qryGen2.ParamByName('ALTERN').AsString := qryGen.FieldByName('WAN_ALTERN').AsString;
    qryGen2.ParamByName('DESCRI').AsString := qryGen.FieldByName('WAN_DESCRI').AsString;
    qryGen2.ParamByName('MONTAD').AsString := qryGen.FieldByName('WAN_MONTAD').AsString;
    qryGen2.ParamByName('VERCOR').AsString := qryGen.FieldByName('WAN_VERCOR').AsString;
    qryGen2.ParamByName('ANOINI').AsString := qryGen.FieldByName('WAN_ANOINI').AsString;
    qryGen2.ParamByName('ANOFIN').AsString := qryGen.FieldByName('WAN_ANOFIN').AsString;
    qryGen2.Open;

    Result := qryGen2.FieldByName('QTD').AsInteger;
  Finally
    If Assigned(qryGen) Then FreeAndNil(qryGen);
    If Assigned(qryGen2) Then FreeAndNil(qryGen2);
  End;
end;

function fRetornaNomeLinha(const strLinha: String): String;
begin
  Case StrToInt(strLinha) Of
    1 : Result := 'Autobase Plus 100:50';
    4 : Result := 'Wandabase HS';
    6 : Result := 'Wandalac';
    8 : Result := 'Wanda PU HS';
    9 : Result := 'Wandacar';
    11: Result := 'Single Stage Converter';
    12: Result := 'Autobase Plus Baseline 100:80';
    14: Result := 'Autobase Plus 100:80';
    16: Result := 'Autocoat BT120';
    19: Result := 'Autobase Plus Baseline 100:50';
    58: Result := 'Wanda PU MS';
    59: Result := 'Autocoat BT90';
    13: Result := 'Autocoat BT100';
    15: Result := 'Autocoat BT110';
    17: Result := 'Autocoat BT130';
    27: Result := 'Autowave MM';
    72: Result := 'Tech Fleet PU';
    74: Result := 'Tech Fleet Epoxy';
    75: Result := 'Tech Fleet Sintetico';
    76: Result := 'Tech Fleet Laca';
  End;
end;

function fLinhaEhWanda(const strLinha: String): Boolean;
begin
  Result := SameText(LeftStr(fRetornaNomeLinha(strLinha), 1), 'W');
end;

function fCalculoA(objFormula: TFormulaAutomotiva;
  strConDil: String; idxBase: Integer; strLinha: String): Double;
Var
  intCont: Integer;

  arrX: Array[0..19] Of Double;
  arrW: Array[0..19] Of Double;
  arrY: Array[0..19] Of Double;
  arrT: Array[0..19] Of Double;
  fltSomaW: Double;

  fltDilui: Double;
  strLinDil: String;
  strCodDil: String;
  fltFatBas: Double;

  objBase: TBaseAutomotiva;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('WCP');

  pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

  fltSomaW := 0.0;
  For intCont := 0 To 19 Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    If strConDil = 'DIL' Then
    Begin
      If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
        arrX[intCont] := fltDilui
      Else
        arrX[intCont] := objBase.fltPorcen * (100 - fltDilui) / 100;
    End
    Else If strConDil = 'CON' Then
    Begin
      If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
        arrX[intCont] := 0
      Else
        arrX[intCont] := objBase.fltPorcen;
    End;

    arrW[intCont] := arrX[intCont] / objBase.fltPesEsp;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    arrY[intCont] := (objFormula.fltVolumePro * 1000 * arrW[intCont]) / fltSomaW;
    arrT[intCont] := RoundTo(arrY[intCont] * objBase.fltPesEsp,-1);
  End;

  Result := arrT[idxBase];
end;

function fCalculoBLinha08(objFormula: TFormulaAutomotiva;
  strConDil: String; idxBase: Integer): Double;
Var
  intCont: Integer;

  arrX: Array[0..19] Of Extended;
  arrW: Array[0..19] Of Extended;
  arrY: Array[0..19] Of Extended;
  arrT: Array[0..19] Of Extended;
  fltSomaW: Extended;
  fltSomaR: Extended;
  fltDilui: Double;
  strLinDil: String;
  strCodDil: String;
  fltFatBas: Double;
  fltThiPer: Extended;
  fltPEThi: Extended;
  conf: IConfTinta;
  objBase:TBaseAutomotiva;
begin
  conf := fGetConfTinta('WCP');

  fltThiPer := 0.0;
  fltSomaR  := 0.0;
  fltSomaW  := 0.0;
  fltPEThi  := 0.0;

  For intCont := 0 To 19 Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  If (strConDil = 'DIL') Or (strConDil = 'DI2') Then
  Begin
    For intCont := 0 To objFormula.Count -1 Do
    Begin
      objBase := TBaseAutomotiva(objFormula.Items[intCont]);

      If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
        Continue;

      pRetornaInfoLinha('8', strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      fltSomaW := fltSomaW + (objBase.fltPorcen / objBase.fltPesEsp);

      If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
      Begin
        fltSomaR := fltSomaR + fltDilui;
        fltPEThi := objBase.fltPesEsp;
      End
      Else
        fltSomaR := fltSomaR + objBase.fltPorcen;
    End;
    fltThiPer := (100 * fltDilui) / fltSomaR;
    fltThiPer := (fltThiPer * fltSomaW * fltPEThi) / (100 - fltThiPer);
  End;

  fltSomaW := 0.0;
  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    {*******************************************}
    {* CATÁLISE 2:1  e 4:1                     *}
    {****************************************NC*}
    If (strConDil = 'DIL') Or (strConDil = 'DI2') Then
    Begin
      pRetornaInfoLinha('8', strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

     If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
       arrW[intCont] := fltThiPer / objBase.fltPesEsp
     Else
       arrW[intCont] := objBase.fltPorcen / objBase.fltPesEsp;

      fltSomaW := fltSomaW + arrW[intCont];
    End
    {*******************************************}
    {* CONCENTRADO                             *}
    {****************************************NC*}
    Else
    Begin
      pRetornaInfoLinha('8', strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
        arrW[intCont] := 0
      Else
        arrW[intCont] := objBase.fltPorcen / objBase.fltPesEsp;

      fltSomaW := fltSomaW + arrW[intCont];
    End;
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    arrY[intCont] := ((objFormula.fltVolumePro * 1000) * arrW[intCont])/fltSomaW;
    arrT[intCont] := RoundTo(arrY[intCont] * objBase.fltPesEsp,-1);
  End;

  Result := arrT[idxBase];
end;

function fCalculoB(objFormula: TFormulaAutomotiva; strConDil: String; idxBase: Integer;
  strLinha: String): Double;
Var
  intCont: Integer;

  arrX: Array[0..19] Of Double;
  arrW: Array[0..19] Of Double;
  arrY: Array[0..19] Of Double;
  arrT: Array[0..19] Of Double;
  fltSomaW: Double;
  fltDilui: Double;
  strLinDil: String;
  strCodDil: String;
  fltFatBas: Double;
  fltThinner: Double;
  fltTinta: Double;
  conf: IConfTinta;
  objBase:TBaseAutomotiva;
begin
  conf := fGetConfTinta('WCP');

  For intCont := 0 To 19 Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  fltSomaW := 0.0;
  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    {*******************************************}
    {* CATÁLISE 2:1                            *}
    {****************************************NC*}
    If strConDil = 'DIL' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (Pos(fStrZero(strLinha, 2), '13_') > 0) Then
      Begin
        fltTinta   := (objFormula.fltVolumePro * 1000) / 1.10;
        fltThinner := (fltDilui * fltTinta) / 100;
        If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := fltTinta;
      End
      Else If (Pos(fStrZero(strLinha, 2), '58_') > 0) Then
      Begin
        arrX[intCont] := 0;
      End;
    End
    {*******************************************}
    {* CATÁLISE 4:1                            *}
    {****************************************NC*}
    Else If strConDil = 'DI2' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (Pos(fStrZero(strLinha, 2), '58') > 0) Then
      Begin
        fltThinner := (fltDilui * (objFormula.fltVolumePro * 1000)) / 100;
        If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := (objFormula.fltVolumePro * 1000) - fltThinner;
      End
      Else  If (Pos(fStrZero(strLinha, 2), '13_') > 0) Then
      Begin
        fltTinta   := (objFormula.fltVolumePro * 1000) / 1.25;
        fltThinner := (fltDilui * fltTinta) / 100;
        If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := fltTinta;
      End;
    End
    {*******************************************}
    {* CONCENTRADO                             *}
    {****************************************NC*}
    Else If strConDil = 'CON' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
        arrX[intCont] := 0
      Else
        arrX[intCont] := objFormula.fltVolumePro * 1000;
    End;

    arrW[intCont] := objBase.fltPorcen / objBase.fltPesEsp;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    If (objBase.strLinBas = strLinDil) And (objBase.strCodBas = strCodDil) Then
      arrY[intCont] := arrX[intCont]
    Else
      arrY[intCont] := arrX[intCont] * arrW[intCont] / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * objBase.fltPesEsp,-1);
  End;

  Result := arrT[idxBase];
end;

function fCalculoC(objFormula: TFormulaAutomotiva; idxBase: Integer): Double;
Var
  intCont: Integer;
  arrR: Array[0..19] Of Double;
  arrW: Array[0..19] Of Double;
  arrY: Array[0..19] Of Double;
  arrT: Array[0..19] Of Double;
  fltSomaW: Double;
  conf: IConfTinta;
  objBase:TBaseAutomotiva;
begin
  conf := fGetConfTinta('WCP');

  fltSomaW := 0.0;
  For intCont := 0 To 19 Do
  Begin
    arrR[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    If objBase.strCodBas = 'QR080' Then
      arrR[intCont] := 0
    Else
      arrR[intCont] := (objBase.fltPorcen * 100) / (100 - 23);

    arrW[intCont] := arrR[intCont] / objBase.fltPesEsp;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  For intCont := 0 To objFormula.Count -1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
      Continue;

    If objBase.strCodBas = 'Q080' Then
      arrY[intCont] := objFormula.fltVolumePro * 1000 / 2
    Else
      arrY[intCont] := ((objFormula.fltVolumePro * 1000 / 2) * arrW[intCont]) / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * objBase.fltPesEsp,-1);
  End;

  Result := arrT[idxBase];
end;

function fRetornaPorcento(strItetin: String; intIndexBase: Integer): Double;
Var qryAux: TUniQuery;
Begin
  Try
    Result := 0;
    qryAux := fCriaQuery;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ' +
                  '   WAN_PORC'+ fStrZero(intIndexBase,2) +
                  ' FROM ' +
                  '   WANPRO_CADWAN ' +
                  ' WHERE WAN_MD5KEY = :ITETIN ');
    qryAux.ParamByName('ITETIN').AsString := strItetin;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT '+
                    '   WAN_PORC'+ fStrZero(intIndexBase,2) +
                    ' FROM '+
                    '   WANPRO_CADWAN'+
                    ' WHERE '+
                    '   UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), '+
                    '   		            IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), '+
                    '                         IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ');
      qryAux.ParamByName('ITETIN').AsString := strItetin;
      qryAux.Open;
    End;
    Result := qryAux.FieldByName('WAN_PORC'+ fStrZero(intIndexBase,2)).AsFloat;
  Finally
    FreeAndNil(qryAux);
  end;
end;

function fRetornaCodAkzo(strItetin: String): String;
Var qryAux: TUniQuery;
Begin
  Try
    Result := '';
    qryAux := fCriaQuery;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ' +
                  '   WAN_CODAKZ' +
                  ' FROM ' +
                  '   WANPRO_CADWAN ' +
                  ' WHERE WAN_MD5KEY = :ITETIN ');
    qryAux.ParamByName('ITETIN').AsString := strItetin;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT '+
                    '   WAN_CODAKZ' +
                    ' FROM '+
                    '   WANPRO_CADWAN'+
                    ' WHERE '+
                    '   UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), '+
                    '   		            IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), '+
                    '                         IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ');
      qryAux.ParamByName('ITETIN').AsString := strItetin;
      qryAux.Open;
    End;
    Result := qryAux.FieldByName('WAN_CODAKZ').AsString;
  Finally
    FreeAndNil(qryAux);
  end;
end;

function fRetornaAcrescimoMaoObra(strIteTin, strLinha: String): Double;
var
  strSQL: String;
  qryGen: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                     ';
  strSQL := strSQL + '   WAN_ACRMOB               ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   WANPRO_CADWAN            ';
  strSQL := strSQL + ' WHERE WAN_MD5KEY = :ITETIN ';
  strSQL := strSQL + '   AND WAN_LINHA_ = :LINHA_ ';

  Try
    qryGen := fCriaQuery(Nil);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      ParamByName('LINHA_').AsString := strLinha;
      Open;

      Result := FieldByName('WAN_ACRMOB').AsFloat;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fRetIndiceAdicional(const strLinha: String; const strCatali: String): Integer;
begin
  Result := -1;

  If Not fEmptyStr(strCatali) Then
  Begin
    If Pos(fStrZero(strLinha, 3), '008_013_') > 0 Then
    Begin
      If strCatali = '2:1' Then
        Result := 0
      Else If strCatali = '4:1' Then
        Result := 1;
    End
    Else If Pos(fStrZero(strLinha, 3), '058_059_') > 0 Then
    Begin
      If strCatali = '4:1' Then
        Result := 0;
    End;
  End;
end;

function fRet4Por1(const strLinha: String; const strCatali: String): Boolean;
begin
  Result := False;

  If Not fEmptyStr(strCatali) Then
  Begin
    If Pos(fStrZero(strLinha, 3), '008_013_') > 0 Then
    Begin
      If strCatali = '2:1' Then
        Result := False
      Else If strCatali = '4:1' Then
        Result := True;
    End
    Else If Pos(fStrZero(strLinha, 3), '058_059_') > 0 Then
    Begin
      If strCatali = '4:1' Then
        Result := True;
    End;
  End;
end;

function fArredondaColorPro(fltValor: Double): Double;
  Var
    strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);
  Result := fStrToFloat(strAux);
end;

procedure pPreencheProdutoEmbalagem(Var stlProEmbLt, stlProEmbGl,
  stlProEmbLa: TStringList; qryTinta: TUniQuery; conf: IConfTinta);
  procedure pPreecher(strLitro, strGalao, strLata: String);
  begin
    stlProEmbLt.Add(strLitro);
    stlProEmbGl.Add(strGalao);
    stlProEmbLa.Add(strLata);
  end;
begin
  Case AnsiIndexStr(qryTinta.FieldByName('WAN_LINHA_').AsString,
    ['1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
     '27', '58', '59', '72', '74', '75', '76']) Of
    0  : Begin //1
           pPreecher(conf.fGet('PLSILT'), conf.fGet('PLSIGL'), conf.fGet('PLSILA'));
         End;
    1  : Begin //4
           pPreecher(conf.fGet('WAHSLT'), conf.fGet('WAHSGL'), conf.fGet('WAHSLA'));
         End;
    2  : Begin //6
           pPreecher(conf.fGet('WALALT'), conf.fGet('WALAGL'), conf.fGet('WALALA'));
         End;
    3  : Begin //8
           pPreecher(conf.fGet('PUHSLT'), conf.fGet('PUHSGL'), conf.fGet('PUHSLA'));
         End;
    4  : Begin //9
           pPreecher(conf.fGet('WCARLT'), conf.fGet('WCARGL'), conf.fGet('WCARLA'));
         End;
    5  : Begin //11
           pPreecher(conf.fGet('SISTLT'), conf.fGet('SISTGL'), conf.fGet('SISTLA'));
         End;
    6  : Begin //12
           pPreecher(conf.fGet('PLBALT'), conf.fGet('PLBAGL'), conf.fGet('PLBALA'));
         End;
    7  : Begin //13
           pPreecher(conf.fGet('BTSILT'), conf.fGet('BTSIGL'), conf.fGet('BTSILA'));
         End;
    8  : Begin //14
           pPreecher(conf.fGet('PLAULT'), conf.fGet('PLAUGL'), conf.fGet('PLAULA'));
         End;
    9  : Begin //15
           pPreecher(conf.fGet('BT11LT'), conf.fGet('BT11GL'), conf.fGet('BT11LA'));
         End;
    10 : Begin //16
           pPreecher(conf.fGet('BT12LT'), conf.fGet('BT12GL'), conf.fGet('BT12LA'));
         End;
    11 : Begin //17
           pPreecher(conf.fGet('BT13LT'), conf.fGet('BT13GL'), conf.fGet('BT13LA'));
         End;
    12 : Begin //19
           pPreecher(conf.fGet('PLBLLT'), conf.fGet('PLBLGL'), conf.fGet('PLBLLA'));
         End;
    13 : Begin //27
           pPreecher(conf.fGet('MMSILT'), conf.fGet('MMSIGL'), conf.fGet('MMSILA'));
         End;
    14 : Begin //58
           pPreecher(conf.fGet('PUMSLT'), conf.fGet('PUMSGL'), conf.fGet('PUMSLA'));
         End;
    15 : Begin //59
           pPreecher(conf.fGet('BT90LT'), conf.fGet('BT90GL'), conf.fGet('BT90LA'));
         End;
    16 : Begin //72
           pPreecher(conf.fGet('TFPULT'), conf.fGet('TFPUGL'), conf.fGet('TFPULA'));
         End;
    17 : Begin //74
           pPreecher(conf.fGet('TFEPLT'), conf.fGet('TFEPGL'), conf.fGet('TFEPLA'));
         End;
    18 : Begin //75
           pPreecher(conf.fGet('TFSILT'), conf.fGet('TFSIGL'), conf.fGet('TFSILA'));
         End;
    19 : Begin //76
           pPreecher(conf.fGet('TFLALT'), conf.fGet('TFLAGL'), conf.fGet('TFLALA'));
         End;
  End;
end;

end.
