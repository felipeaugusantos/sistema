unit untResicolorDinamica;

interface

uses SysUtils, Forms, Classes, Uni,
  Dialogs, StrUtils, untFuncEspecificas, Controls, untFuncoesSimples, Math,
  untPnlBotoesAcoesNovaConsulta,
  untIConfTinta;

Type

  TfrmConsultaCompResicolor = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaResicolor = class(TFormulaImobiliaria)
    private
      conf: IConfTinta;
      fltPerAcr: Double;
    protected
      procedure SetIteBas(const Value: String); override;
      procedure pCarregarColorantes; override;
    public
      procedure pCarregaPrecosColorantes; override;
      procedure pCalculaPreco; override;
    constructor Create(strTabPrePar: String); override;
  End;

  function fRetornaPrecoResicolorDinamica(Sender: TForm; qryCadRsi: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fRetornaUniTraProResicolorDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoResicolorDinamica(strDesCor: String; qryCadRsi: TUniQuery): String;

  function fDigDadosTintometricos(qryCadRsi: TUniQuery; strTabPre, strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(Base, ProKey, SubKey, Unidad: String): String;

  function fGTinForResicolorDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaResicolorDinamica(Sender: TForm): String; stdcall;
  function fConsultaResicolorDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaResicolorDinamicaVenda(Sender: TForm; qryCadRsi: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaResicolorDinamicaInterna(Sender: TForm; qryCadRsi: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosResicolorDinamica(strIteTin: String; dicRetorno: TDicionario);

  procedure pRetornaTabelaPrecoResicolor(dicRetorno: TDicionario);

Const
//  FATOR_CNV_RESICOLOR = 0.527;
  FATOR_CNV_RESICOLOR = 1;

implementation

uses DB,  untDigTintaImobiliaria, untTintaMaquina,untFuncoes,untIConsultaTinta, untResicolorConsulta,
untGenericTintaDeMaquinaComponente, untITintaDeMaquinaComponente,
untTintaDeMaquinaComponenteTipo, untTintaDeMaquinaComponenteComparerColorante,
untTintaDeMaquinaComponenteComparerBaseImobiliaria;

function fRetornaPrecoResicolorDinamica(Sender: TForm; qryCadRsi: TUniQuery;
  Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
  strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  Var

    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    strIteTin: String;
    blnUsaPreCus: Boolean;

    {*******************************************}
    {* VARIÁVEIS INTERNAS                      *}
    {****************************************MV*}
    fltPreCus: Double;
    fltUnitar: Double;
    strCodIte: String;
    strDesCor: String;
    strTabPre: String;
    strDesBas: String;
    strRefBas: String;
    strUniBas: String;

    strAuto: String;
    tinta : IConsultaTinta;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('RSI');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  strAuto := '-1';

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaResicolorDinamicaVenda(Sender,qryCadRsi, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TResicolorConsulta.Create;

  qryCadRsi.Close;
  qryCadRsi.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadRsi.Open;

  If (Not fDigDadosTintometricos(qryCadRsi, strTabPre,
        qryCadRsi.FieldByName('RSI_CODITE').AsString, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(strAuto, strCodIte));

  strIteTin := qryCadRsi.FieldByName('RSI_DESCRI').AsString + ' ' +
               qryCadRsi.FieldByName('RSI_CODIGO').AsString + ' ' +
               qryCadRsi.FieldByName('RSI_CODIG2').AsString + ' ' +
               qryCadRsi.FieldByName('RSI_UNIDAD').AsString;

  fltPreCus := fltPreCus;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar;

  dicRetorno['unidad'] := strUniBas;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltUnitar;
//  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  Result := True;

end;

function fRetornaUniTraProResicolorDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('RSI');
  strSiglaTrava := conf.fGet('RSITRA');
  fltFatTrava   := conf.fGetDouble('FATRSI');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoResicolorDinamica(strDesCor: String; qryCadRsi: TUniQuery): String;
begin
  {***********************************}
  {* AGORA  DESCRIÇÃO É CONFIGURAVEL *}
  {********************************PH*}
  Result := strDesCor;
end;

function fRetornaProdutoBase(Base, ProKey, SubKey, Unidad: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT');
  qryAux.SQL.Add(' *');
  qryAux.SQL.Add('FROM');
  qryAux.SQL.Add('	RSI_CADBAS');
  qryAux.SQL.Add('WHERE');
  qryAux.SQL.Add('	BAS_UNIDAD = :UNIDAD');
  qryAux.SQL.Add('	AND BAS_BASE__ = :BASE');
  qryAux.SQL.Add('	AND BAS_PROKEY = :PROKEY');
  qryAux.SQL.Add('	AND BAS_SUBKEY = :SUBKEY');

  qryAux.ParamByName('UNIDAD').AsString := Unidad;
  qryAux.ParamByName('BASE').AsString := Base;
  qryAux.ParamByName('PROKEY').AsString := ProKey;
  qryAux.ParamByName('SUBKEY').AsString := SubKey;

  qryAux.Open;
  Result := qryAux.FieldByName('BAS_CODITE').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fGTinForResicolorDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strColorantes: String;
    dicColorantes: TDicionario;
    qryConsulta01: TUniQuery;
begin

  qryConsulta01 := fCriaQuery(Nil);

  dicColorantes := TDicionario.Create;
  strColorantes := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RSI_CADRSI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(RSI_DESCRI, " ", RSI_CODIGO, " ", RSI_CODIG2, " ", RSI_UNIDAD) = :ITETIN ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      Result := False;
      Exit;
    End;

    For intContador := 1 To 20 Do
    Begin
      strCamFor := 'RSI_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'RSI_QTDB' + fStrZero(IntToStr(intContador), 2);

      If fEmptyStr(FieldByName(strCamFor).AsString) Then
        Break;

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := fFormataFloat(FieldByName(strCamBas).AsFloat * FATOR_CNV_RESICOLOR, 2);

      dicColorantes[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

      {*******************************************}
      {* GUARDA COLORANTES PARA POSTERIOR BUSCA  *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strColorantes := strColorantes + QuotedStr(arrFormul[intContador].strFormul);
      If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
        strColorantes := strColorantes + ', ';

    End;

    strColorantes := Trim(strColorantes);
    If (RightStr(strColorantes, 1) = ',') Then
      strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COL_CODCOL, ';
  strSQL := strSQL + '  COL_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RSI_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL IN (' + strColorantes + ') ';

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
      stlItensTraMl.Add(FieldByName('COL_CODITE').AsString);

      arrBaixaPigmentos[intPos].strCodIte   := FieldByName('COL_CODITE').AsString;
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[FieldByName('COL_CODCOL').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicColorantes);
  FreeAndNil(qryConsulta01);

end;

function fConsultaResicolorDinamica(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaResicolorDinamicaInterna(Sender, qryGen, '1', tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
end;

function fConsultaResicolorDinamicaGeral(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaResicolorDinamicaInterna(Sender, qryGen, '1', tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
end;

function fConsultaResicolorDinamicaVenda(Sender: TForm; qryCadRsi: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
Begin
  Result := fConsultaResicolorDinamicaInterna(Sender, qryCadRsi, strTabPre, tpcVenda, blnFaturamento, dicRetorno, sltItems);
End;

{ TFormulaResicolor }

constructor TFormulaResicolor.Create(strTabPrePar: String);
begin
  inherited Create(strTabPrePar);
  conf := fGetConfTinta('RSI');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

procedure TFormulaResicolor.pCalculaPreco;
  Var
    objColorante: TColoranteImobiliario;
    intIndex: Integer;
    componente: ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    FPreCus := 0.0;
    FCu2Col := 0.0;
    FPreVen := 0.0;
    FCusCol := 0.0;
    FVenCol := 0.0;

    FOutVal := 0;
    FIcmsai := 0;
    FImpFed := 0;
    FDesOpe := 0;
    FPreMed := 0;

    FPreUlt := 0;
    FImpUlt := 0;
    FComLiq := 0;
  End;
begin
  inherited;

  pZerarPrecos;

  For intIndex := 0 To Count -1 Do
  Begin

    objColorante := TColoranteImobiliario(Items[intIndex]);

    If (Not qryCadCol.Locate('COL_CODCOL', objColorante.strCodcol, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (qryCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    if not IsItemAtivo(qryCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(objColorante.strCodCol));
    if not Assigned(componente) then
    begin
      componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objColorante.strCodIte, objColorante.strCodCol, tmctColoranteImobiliario));
    end;

    componente.Quantidade                := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR);
    componente.PrecoCusto                := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreCus / 1000);
    componente.PrecoCustoReal            := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreCu2 / 1000);
    componente.PrecoVenda                := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreVen / 1000);
    componente.PrecoMedio                := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreMed / 1000);
    componente.OutrosValores             := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltOutVal / 1000);
    componente.IcmsSaida                 := (objColorante.fltPreVen * objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltIcmsai / 1000) / 100;
    componente.ImpostosFederais          := (objColorante.fltPreVen * objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltImpFed / 1000) / 100;
    componente.DespesasOperacionais      := (objColorante.fltPreVen * objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltDesOpe / 1000) / 100;
    componente.UltimoPrecoCompra         := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreUlt / 1000);
    componente.UltimoPrecoCompraImpostos := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltImpUlt / 1000);
    componente.PrecoCompraLiquido        := (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltComLiq / 1000);

{
    FCusCol := FCusCol + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreCus / 1000);
    FCu2Col := FCu2Col + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreCu2 / 1000);
    FVenCol := FVenCol + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreVen / 1000);

    FOutVal := FOutVal + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltOutVal / 1000);

    FIcmsai := FIcmsai + (objColorante.fltPreVen * objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltIcmsai / 1000) / 100;
    FImpFed := FImpFed + (objColorante.fltPreVen * objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltImpFed / 1000) / 100;
    FDesOpe := FDesOpe + (objColorante.fltPreVen * objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltDesOpe / 1000) / 100;

    FPreMed := FPreMed + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreMed / 1000);

    FPreUlt := FPreUlt + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltPreUlt / 1000);
    FImpUlt := FImpUlt + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltImpUlt / 1000);
    FComLiq := FComLiq + (objColorante.fltQtdCol * FATOR_CNV_RESICOLOR) * (objColorante.fltComLiq / 1000);
}
    pCarregaPrecosColorantes;

  End;

  FCusCol := tintaDeMaquina.GetPrecoCustoComponentes;
  FCu2Col := tintaDeMaquina.GetPrecoCustoRealComponentes;
  FVenCol := tintaDeMaquina.GetPrecoVendaComponentes + (fltPerAcr * tintaDeMaquina.GetPrecoVendaComponentes);
  FPreMed := tintaDeMaquina.GetPrecoMedioComponentes;
  FPreUlt := tintaDeMaquina.GetUltimoPrecoCompraComponentes;
  FImpUlt := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
  FComLiq := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

  FOutVal := tintaDeMaquina.GetOutrosValoresComponentes;
  FIcmsai := tintaDeMaquina.GetIcmsSaidaComponentes;
  FImpFed := tintaDeMaquina.GetImpostosFederaisComponentes;
  FDesOpe := tintaDeMaquina.GetDespesasOperacionaisComponentes;

  FPreCus := tintaDeMaquina.GetPrecoCustoComponentes + tintaDeMaquina.GetPrecoCustoEmbalagemBase;
  FPreCu2 := tintaDeMaquina.GetPrecoCustoRealComponentes + tintaDeMaquina.GetPrecoCustoRealEmbalagemBase;
  FPreVen := FVenCol + tintaDeMaquina.GetPrecoVendaEmbalagemBase;

{
  FVenCol := FVenCol + (fltPerAcr * FVenCol);

  FPreCus := FCusBas + FCusCol;
  FPreCu2 := FCu2Bas + FCu2Col;
  FPreVen := FVenBas + FVenCol;
}
end;

procedure TFormulaResicolor.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objColorante: TColoranteImobiliario;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro: Double;
begin
  conf := fGetConfTinta('RSI');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count-1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intContador]);
    qryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []);

    If fCarregaPromocao(qryCadCol.FieldByName('COL_CODITE').AsString, fTabPreco,
      strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      objColorante.fltPreCus := fltPreCusPro;
      objColorante.fltPreVen := fltPreVenPro;
      FPromoc := 'S';

      If objColorante.fltPreCus = 0 Then
        objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
      objColorante.fltPreVen := qryCadCol.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objColorante.strCodIte := qryCadCol.FieldByName('COL_CODITE').AsString;
    objColorante.fltOutVal := qryCadCol.FieldByName('ITE_OUTVAL').AsFloat;
    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objColorante.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objColorante.strCodIte, objColorante.strImpDir)
    else
      objColorante.fltIcmSai := qryCadCol.FieldByName('ITE_ICMSAI').AsFloat;
    objColorante.fltImpFed := qryCadCol.FieldByName('ITE_IMPFED').AsFloat;
    objColorante.fltDesOpe := qryCadCol.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objColorante.fltPreMed := qryCadCol.FieldByName('ITE_PREMED').AsFloat;
    objColorante.fltPreUlt := qryCadCol.FieldByName('ITE_PREULT').AsFloat;
    objColorante.fltImpUlt := qryCadCol.FieldByName('ITE_IMPULT').AsFloat;
    objColorante.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade) * (Preço / 1000)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaResicolor.pCarregarColorantes;
begin
  inherited;
  qryCadCol.SQL.Clear;
  qryCadCol.SQL.Add('SELECT ');
  qryCadCol.SQL.Add('  COL_CODCOL, ');
  qryCadCol.SQL.Add('  COL_CODITE, ');
  qryCadCol.SQL.Add('  ITE_CNV_ML, ');

  qryCadCol.SQL.Add('     ITE_PREULT                     ');
  qryCadCol.SQL.Add('   , ITE_IMPULT                     ');
  qryCadCol.SQL.Add('   , ITE_PREMED                     ');

  qryCadCol.SQL.Add('   , ITE_PRECOM                       ');
  qryCadCol.SQL.Add('   , ITE_DESF01                       ');
  qryCadCol.SQL.Add('   , ITE_DESF02                       ');
  qryCadCol.SQL.Add('   , ITE_DESF03                       ');
  qryCadCol.SQL.Add('   , ITE_DESF04                       ');
  qryCadCol.SQL.Add('   , ITE_DESF05                       ');
  qryCadCol.SQL.Add('   , ITE_DESF06 ,                     ');  

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  Begin
    qryCadCol.SQL.Add('  ITE_ICMSAI, ');
    qryCadCol.SQL.Add('  ITE_IMPFED, ');
    qryCadCol.SQL.Add('  ITE_DESOPE, ');
    qryCadCol.SQL.Add('  ITE_OUTVAL, ');
  End
  Else
  Begin
    qryCadCol.SQL.Add('  -1.0000 AS ITE_ICMSAI, ');
    qryCadCol.SQL.Add('  -1.0000 AS ITE_IMPFED, ');
    qryCadCol.SQL.Add('  -1.0000 AS ITE_DESOPE, ');
    qryCadCol.SQL.Add('  -1.0000 AS ITE_OUTVAL, ');
  End;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadCol.SQL.Add('  COL_PRELIT AS ITE_PRECUS, ');
    qryCadCol.SQL.Add('  COL_PREVEN AS ITE_PREVEN ');
  End
  Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
  Begin
    qryCadCol.SQL.Add('  ITE_PRECUS, ');
    qryCadCol.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  End
  Else
  Begin
    qryCadCol.SQL.Add('  ITE_PRECUS, ');
    qryCadCol.SQL.Add('  ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ');
  End;

  qryCadCol.SQL.Add('FROM ');
  qryCadCol.SQL.Add('  RSI_CADCOL');
  qryCadCol.SQL.Add('  JOIN ITEGER G ON G.ITE_CODITE = COL_CODITE ');
  qryCadCol.SQL.Add('              AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
  qryCadCol.SQL.Add('  LEFT JOIN CADITE I ON I.ITE_CODITE = COL_CODITE  ');

  Try
    qryCadCol.Open;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
    End;
  End;
end;

procedure TFormulaResicolor.SetIteBas(const Value: String);
  Var
    qryAux: TUniQuery;
    fltIcmsai: Double;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro : Double;
    base: ITintaDeMaquinaComponente;

    function fPrecoCusto2Base(const fltPreCus, fltPreVen: Double): Double;
    begin
      Result := fCalculaPrecoCusto2(fltPreVen,
                                    fltPreCus,
                                    qryAux.FieldByName('ITE_OUTVAL').AsFloat,
                                    fltIcmsai,
                                    qryAux.FieldByName('ITE_IMPFED').AsFloat,
                                    qryAux.FieldByName('ITE_DESOPE').AsFloat);
    end;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBas)));
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBasOri)));
  inherited;
  conf := fGetConfTinta('RSI');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');
  Try
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Clear;
    If Value = strIteBasOri Then
    Begin

      {*******************************************}
      {* CASO NÃO TENHA CARREGADO OS PREÇOS ORI- *}
      {* GINAIS, CARREGA DO CADASTRO DE BASES.   *}
      {****************************************MV*}
      If fltCusBasOri <= 0.0 Then
      Begin

        qryAux.SQL.Add('SELECT ');

        qryAux.SQL.Add('     ITE_PREULT                     ');
        qryAux.SQL.Add('   , ITE_IMPULT                     ');
        qryAux.SQL.Add('   , ITE_PREMED                     ');
        qryAux.SQL.Add('   , ITE_PRECOM                     ');
        qryAux.SQL.Add('   , ITE_DESF01                     ');
        qryAux.SQL.Add('   , ITE_DESF02                     ');
        qryAux.SQL.Add('   , ITE_DESF03                     ');
        qryAux.SQL.Add('   , ITE_DESF04                     ');
        qryAux.SQL.Add('   , ITE_DESF05                     ');
        qryAux.SQL.Add('   , ITE_DESF06 ,                   ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
        Begin
          qryAux.SQL.Add('  ITE_ICMSAI, ');
          qryAux.SQL.Add('  ITE_IMPFED, ');
          qryAux.SQL.Add('  ITE_DESOPE, ');
          qryAux.SQL.Add('  ITE_OUTVAL, ');
        End
        Else
        Begin
          qryAux.SQL.Add('  -1.0000 AS ITE_ICMSAI, ');
          qryAux.SQL.Add('  -1.0000 AS ITE_IMPFED, ');
          qryAux.SQL.Add('  -1.0000 AS ITE_DESOPE, ');
          qryAux.SQL.Add('  -1.0000 AS ITE_OUTVAL, ');
        End;

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
        Begin
          qryAux.SQL.Add('  BAS_PRECUS AS ITE_PRECUS, ');
          qryAux.SQL.Add('  BAS_PREVEN AS ITE_PREVEN ');
        End
        Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
        Begin
          qryAux.SQL.Add('  ITE_PRECUS, ');
          qryAux.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
        End
        Else
        Begin
          qryAux.SQL.Add('  ITE_PRECUS, ');
          qryAux.SQL.Add('  ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ');
        End;

        qryAux.SQL.Add('FROM ');
        qryAux.SQL.Add('  RSI_CADBAS ');
        qryAux.SQL.Add('  JOIN ITEGER ON ITE_CODITE = BAS_CODITE AND ');
        qryAux.SQL.Add('                 ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  ITE_CODITE = :CODITE ');

        qryAux.ParamByName('CODITE').AsString := FIteBas;
        qryAux.Open;

        If fCarregaPromocao(FIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro) Then
        Begin
          FCusBasOri := fltPreCusPro;
          FVenBasOri := fltPreVenPro;
          FPromoc := 'S';

          If FCusBasOri = 0 Then
            FCusBasOri := qryAux.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          FCusBasOri := qryAux.FieldByName('ITE_PRECUS').AsFloat;
          FVenBasOri := qryAux.FieldByName('ITE_PREVEN').AsFloat;
        End;

        FVenBasOri := FVenBasOri + (fltPerAcr * FVenBasOri);

        FOutValBas := qryAux.FieldByName('ITE_OUTVAL').AsFloat;

        if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        begin
          fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryAux.FieldByName('ITE_IMPDIR').AsString);
          FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
        end
        else
        begin
          fltIcmsai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;
          FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
        end;

        FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);

        FImpFedBas := qryAux.FieldByName('ITE_IMPFED').AsFloat * FVenBasOri / 100;
        FDesOpeBas := (((qryAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBasOri) / 100);
        FPreMedBas := qryAux.FieldByName('ITE_PREMED').AsFloat;

        FPreUltBas := qryAux.FieldByName('ITE_PREULT').AsFloat;
        FImpUltBas := qryAux.FieldByName('ITE_IMPULT').AsFloat;
        FComLiqBas := fFormataFloat(fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));

      End;
      FCusBas := fltCusBasOri;
      FCu2Bas := fltCu2BasOri;
      FVenBas := fltVenBasOri;
    End
    Else
    Begin
      FIteBas := Value;
      qryAux.SQL.Add('SELECT ');

      qryAux.SQL.Add('     G.ITE_PREULT                     ');
      qryAux.SQL.Add('   , G.ITE_IMPULT                     ');
      qryAux.SQL.Add('   , ITE_PREMED                       ');

      qryAux.SQL.Add('   , ITE_PRECOM                       ');
      qryAux.SQL.Add('   , ITE_DESF01                       ');
      qryAux.SQL.Add('   , ITE_DESF02                       ');
      qryAux.SQL.Add('   , ITE_DESF03                       ');
      qryAux.SQL.Add('   , ITE_DESF04                       ');
      qryAux.SQL.Add('   , ITE_DESF05                       ');
      qryAux.SQL.Add('   , ITE_DESF06 ,                     ');

      If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
      Begin
        qryAux.SQL.Add('  ITE_ICMSAI, ');
        qryAux.SQL.Add('  ITE_IMPFED, ');
        qryAux.SQL.Add('  ITE_DESOPE, ');
        qryAux.SQL.Add('  ITE_OUTVAL, ');
      End
      Else
      Begin
        qryAux.SQL.Add('  -1.0000 AS ITE_ICMSAI, ');
        qryAux.SQL.Add('  -1.0000 AS ITE_IMPFED, ');
        qryAux.SQL.Add('  -1.0000 AS ITE_DESOPE, ');
        qryAux.SQL.Add('  -1.0000 AS ITE_OUTVAL, ');
      End;

      qryAux.SQL.Add('  G.ITE_PRECUS, ');
      qryAux.SQL.Add('  G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  ITEGER G ');
      qryAux.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  G.ITE_CODITE = :CODITE AND ');
      qryAux.SQL.Add('  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');

      qryAux.ParamByName('CODITE').AsString := FIteBas;

      Try
        qryAux.Open;

        If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro) Then
        Begin
          FCusBas := fltPreCusPro;
          FVenBas := fltPreVenPro;
          FPromoc := 'S';

          If FCusBas = 0 Then
            FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
          FVenBas := qryAux.FieldByName('ITE_PREVEN').AsFloat;
        End;

        FVenBas := FVenBas + (fltPerAcr * FVenBas);

        FOutValBas := qryAux.FieldByName('ITE_OUTVAL').AsFloat;

        if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        begin
          fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryAux.FieldByName('ITE_IMPDIR').AsString);
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end
        else
        begin
          fltIcmsai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end;

        FImpFedBas := qryAux.FieldByName('ITE_IMPFED').AsFloat * FVenBas / 100;
        FDesOpeBas := (((qryAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBas) / 100);
        FCu2Bas := fPrecoCusto2Base(FCusBas, FVenBas);
        FPreMedBas := qryAux.FieldByName('ITE_PREMED').AsFloat;
        FPreUltBas := qryAux.FieldByName('ITE_PREULT').AsFloat;
        FImpUltBas := qryAux.FieldByName('ITE_IMPULT').AsFloat;
        FComLiqBas := fFormataFloat(fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message,'');
        End;
      End;
    End;

    base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Value));
    if not Assigned(base) then
    begin
      base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        FIteBas, fRetNomProduto(FIteBas), FDesOpeBas, FIcmsaiBas, FImpFedBas,
        FOutValBas, FCusBas, FCu2Bas, FPreMedBas, FVenBas, 1, tmctBaseImobiliaria,
        FPreUltBas, FImpUltBas, FComLiqBas
      ));
    end;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;

end;

function fDigDadosTintometricos(qryCadRsi: TUniQuery; strTabPre, strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
  Var
    objColorante: TColoranteImobiliario;
    objColoranteEsp: TColoranteImobiliario;
    objFormula: TFormulaResicolor;
    objFormulaEsp: TFormulaResicolor;
    intContador: Integer;

    function fCriaFormula: TFormulaResicolor;
    begin
      Result := TFormulaResicolor.Create(strTabPre);
      Result.fltFatorEstoque := FATOR_CNV_RESICOLOR;
      Result.strCodCli    := IfNull(dicRetorno['codcli'], '');
      Result.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      Result.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      Result.intPrzMed    := IfNull(dicRetorno['przmed'], 0);

      Result.strIteBasOri := fRetornaProdutoBase(qryCadRsi.FieldByName('RSI_BASE__').AsString,
                                                     qryCadRsi.FieldByName('RSI_PROKEY').AsString,
                                                     qryCadRsi.FieldByName('RSI_SUBKEY').AsString,
                                                     qryCadRsi.FieldByName('RSI_UNIDAD').AsString);

      Result.strIteBas    := Result.strIteBasOri;
      Result.strUnidad    := qryCadRsi.FieldByName('RSI_UNIDAD').AsString;
      Result.strDescri    := qryCadRsi.FieldByName('RSI_DESCRI').AsString;
    end;
begin
  objFormula := fCriaFormula;
  objFormulaEsp := fCriaFormula;

  For intContador := 1 To 20 Do
  Begin

    If (fEmptyStr(qryCadRsi.FieldByName('RSI_FORM' + fStrZero(intContador, 2)).AsString)) Then
      Break;

    objColorante := TColoranteImobiliario(objFormula.Add);
    objColorante.strCodCol := qryCadRsi.FieldByName('RSI_FORM' + fStrZero(intContador, 2)).AsString;
    objColorante.fltQtdCol := qryCadRsi.FieldByName('RSI_QTDB' + fStrZero(intContador, 2)).AsFloat;

    objColoranteEsp  := TColoranteImobiliario(objFormulaEsp.Add);
    objColoranteEsp.strCodCol := qryCadRsi.FieldByName('RSI_FORM' + fStrZero(intContador, 2)).AsString;
    objColoranteEsp.fltQtdCol := fFormataFloat(qryCadRsi.FieldByName('RSI_QTDB' + fStrZero(intContador, 2)).AsFloat * FATOR_CNV_RESICOLOR, 2);

  End;

  objFormula.pCarregaPrecosColorantes;
  objFormulaEsp.pCarregaPrecosColorantes;

  Result := False;
  Try
    Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
    objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
    frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Resicolor';
    frmDigTintaImobiliaria.objFormula := objFormula;
    frmDigTintaImobiliaria.objFormulaEsp := objFormulaEsp;
    frmDigTintaImobiliaria.strIdePro := 'RSI';
    If frmDigTintaImobiliaria.ShowModal = mrOk Then
      Result := True;
  Finally

    If (Result) Then
    Begin
      strNovBas := frmDigTintaImobiliaria.strNovBas;
      strDesBas := frmDigTintaImobiliaria.strDesBas;
      strRefere := frmDigTintaImobiliaria.strRefere;
      strUniBas := frmDigTintaImobiliaria.strUniBas;
      strDesCor := frmDigTintaImobiliaria.strDesCor;
      fltPreCus := frmDigTintaImobiliaria.fltPreCus;
      fltPreVen := frmDigTintaImobiliaria.fltPreVen;
    End;

    dicRetorno['premed'] := objFormula.fltPreMed + objFormula.fltPreMedBas;
    dicRetorno['preult'] := objFormula.fltPreUlt + objFormula.fltPreUltBas;
    dicRetorno['impult'] := objFormula.fltImpUlt + objFormula.fltImpUltBas;
    dicRetorno['prctin'] := objFormula.fltComLiq + objFormula.fltComLiqBas;

    dicRetorno['precu2'] := objFormula.fltPreCu2;
    dicRetorno['promoc'] := objFormula.StrPromoc;

    AcertaImpostos(fltPreCus, objFormula.fltPreCu2,
        objFormula.fltOutVal + objFormula.fltOutValBas,
        objFormula.fltIcmsai + objFormula.fltIcmsaiBas,
        objFormula.fltImpFed + objFormula.fltImpFedBas,
        objFormula.fltDesOpe + objFormula.fltDesOpeBas,
        dicRetorno);

    dicRetorno['maximoqtdbase'] := frmDigTintaImobiliaria.fltQtdMaximo;
    dicRetorno.AdicionarObjeto('formul', frmDigTintaImobiliaria.matrizSaldosColorantes);
    dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina);

    FreeAndNil(frmDigTintaImobiliaria);
  End;

  If (Result) And (Assigned(dicRetorno)) Then
  Begin
    objFormula.pRecalculaTabelas(dicRetorno);
  End;

end;

procedure pRetornaDadosResicolorDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadRsi: TUniQuery;
    strSQL: String;
begin

  qryCadRsi := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RSI_CADRSI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(RSI_DESCRI, " ", RSI_CODIGO, " ", RSI_CODIG2) = :ITETIN ';

  With qryCadRsi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadRsi.FieldByName('RSI_DESCRI').AsString;
    Close;
  End;

  FreeAndNil(qryCadRsi);
end;

procedure pRetornaTabelaPrecoResicolor(dicRetorno: TDicionario);
  Var
    objFormula: TFormulaResicolor;
begin
  objFormula := TFormulaResicolor.Create('1');
  objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
  objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
  objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
  objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
  objFormula.blnCalculaUnitario := False;
  pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, FATOR_CNV_RESICOLOR); //0.924
end;

{ TfrmConsultaCompResicolor }

procedure TfrmConsultaCompResicolor.pTarefaFormulacao(
  Sender: TObject);
  Var
    qryGen: TUniQuery;

    fltPreCus: Double;
    fltUnitar: Double;
    strCodIte: String;
    strDesCor: String;
    strDesBas: String;
    strRefBas: String;
    strUniBas: String;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT * FROM RSI_CADRSI WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre, qryGen.FieldByName('RSI_CODITE').AsString,
    strCodIte, strDesBas, strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create);
    
  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompResicolor.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender
  );
end;

procedure TfrmConsultaCompResicolor.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadRsiNovasFormulas', False);
end;

function fConsultaResicolorDinamicaInterna(Sender: TForm; qryCadRsi: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TResicolorConsulta.Create).fExecutarConsulta(Sender,
    qryCadRsi, tipoConsulta, strTabPre, TfrmConsultaCompResicolor, '', blnFaturamento, dicRetorno, sltItems);
end;

end.
