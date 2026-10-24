unit untSherwinWhilliamsDinamica;

interface

uses SysUtils, Forms, Classes,
Uni,
Dialogs, StrUtils, untFuncEspecificas, Controls, untFuncoesSimples, Math, untConsultaCompTinta,
untConsultaCompTintaNova, untPnlBotoesAcoesNovaConsulta,
untIConfTinta;

Type

  TfrmConsultaCompSherwinWhilliams = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaSherwinWhilliams = class(TFormulaImobiliaria)
    private
      conf     : IConfTinta;
      fltPerAcr: Double;
    protected
      procedure SetIteBas(const Value: String); override;
      procedure pCarregarColorantes; override;
    public
      procedure pCarregaPrecosColorantes; override;
      procedure pCalculaPreco; override;
    constructor Create(strTabPrePar: String); override;
  End;

  function fRetornaPrecoSherwinWhilliamsDinamica(Sender: TForm; qryCadShe: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProSherwinWhilliamsDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoSherwinWhilliamsDinamica(strDesCor: String; qryCadShe: TUniQuery): String;

  function fDigDadosTintometricos(qryCadShe: TUniQuery; strTabPre, strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(Base, ProKey, SubKey, Unidad: String): String;

  function fGTinForSherwinWhilliamsDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaSherwinWhilliamsDinamica(Sender: TForm): String; stdcall;
  function fConsultaSherwinWhilliamsDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaSherwinWhilliamsDinamicaVenda(Sender: TForm; qryCadShe: TUniQuery; strTabPre: String): String; stdcall;

  function fConsultaSherwinWhilliamsDinamicaInterna(Sender: TForm; qryCadShe: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;

  procedure pRetornaDadosSherwinWhilliamsDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoSherwinWhilliams(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses DB, untDigTintaImobiliaria, untTintaMaquina,untFuncoes,untICalculadorFatVendas,untIConsultaTinta, untSherwinWilliamsConsulta,
     untGenericTintaDeMaquinaComponente, untITintaDeMaquinaComponente,
     untTintaDeMaquinaComponenteTipo, untTintaDeMaquinaComponenteComparerColorante,
     untTintaDeMaquinaComponenteComparerBaseImobiliaria;

function fRetornaPrecoSherwinWhilliamsDinamica(Sender: TForm; qryCadShe: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
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
  conf := fGetConfTinta('SHE');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  strAuto := '-1';
  strAuto := fConsultaSherwinWhilliamsDinamicaVenda(Sender,qryCadShe, strTabPre);

  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  tinta := TSherwinWilliamsConsulta.Create;

  qryCadShe.Close;
  qryCadShe.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadShe.Open;

  If (Not fDigDadosTintometricos(qryCadShe, strTabPre,
        qryCadShe.FieldByName('SHE_CODITE').AsString, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(strAuto, strCodIte));

  strIteTin := qryCadShe.FieldByName('SHE_DESCRI').AsString + ' ' +
               qryCadShe.FieldByName('SHE_CODIGO').AsString + ' ' +
               qryCadShe.FieldByName('SHE_CODIG2').AsString + ' ' +
               qryCadShe.FieldByName('SHE_UNIDAD').AsString;

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

function fRetornaUniTraProSherwinWhilliamsDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SHE');
  strSiglaTrava := conf.fGet('TRASHE');
  fltFatTrava   := conf.fGetDouble('FATSHE');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoSherwinWhilliamsDinamica(strDesCor: String; qryCadShe: TUniQuery): String;
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
  qryAux.SQL.Add('	SHE_CADBAS');
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

function fGTinForSherwinWhilliamsDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  SHE_CADSHE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(SHE_DESCRI, " ", SHE_CODIGO, " ", SHE_CODIG2, " ", SHE_UNIDAD) = :ITETIN ';

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
      strCamFor := 'SHE_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'SHE_QTDB' + fStrZero(IntToStr(intContador), 2);

      If fEmptyStr(FieldByName(strCamFor).AsString) Then
        Break;

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat * 0.924;

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
  strSQL := strSQL + '  SHE_CADCOL ';
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

function fConsultaSherwinWhilliamsDinamica(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaSherwinWhilliamsDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral);
  FreeAndNil(qryGen);
end;

function fConsultaSherwinWhilliamsDinamicaGeral(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaSherwinWhilliamsDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral);
  FreeAndNil(qryGen);
end;

function fConsultaSherwinWhilliamsDinamicaVenda(Sender: TForm; qryCadShe: TUniQuery; strTabPre: String): String;
Begin
  Result := fConsultaSherwinWhilliamsDinamicaInterna(Sender, qryCadShe, strTabPre, tpcVenda);
End;

{ TFormulaSherwinWhilliams }

constructor TFormulaSherwinWhilliams.Create(strTabPrePar: String);
begin
  inherited Create(strTabPrePar);
  conf      := fGetConfTinta('SHE');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

procedure TFormulaSherwinWhilliams.pCalculaPreco;
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

    componente.Quantidade                := (objColorante.fltQtdCol * 0.924);
    componente.PrecoCusto                := (objColorante.fltQtdCol * 0.924) * (objColorante.fltPreCus / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    componente.PrecoCustoReal            := (objColorante.fltQtdCol * 0.924) * (objColorante.fltPreCu2 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    componente.PrecoVenda                := (objColorante.fltQtdCol * 0.924) * (objColorante.fltPreVen / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    componente.PrecoMedio                := objColorante.fltPreMed * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000);
    componente.OutrosValores             := objColorante.fltOutVal * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000);
    componente.IcmsSaida                 := objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000)) / 100;
    componente.ImpostosFederais          := objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000)) / 100;
    componente.DespesasOperacionais      := objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000)) / 100;
    componente.UltimoPrecoCompra         := (objColorante.fltPreUlt * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    componente.UltimoPrecoCompraImpostos := (objColorante.fltImpUlt * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    componente.PrecoCompraLiquido        := (objColorante.fltComLiq * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));

{
    FCusCol := FCusCol + (objColorante.fltQtdCol * 0.924) * (objColorante.fltPreCus / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    FCu2Col := FCu2Col + (objColorante.fltQtdCol * 0.924) * (objColorante.fltPreCu2 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    FVenCol := FVenCol + (objColorante.fltQtdCol * 0.924) * (objColorante.fltPreVen / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    FPreMed := FPreMed + objColorante.fltPreMed * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000);

    FOutVal := FOutVal + objColorante.fltOutVal * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000);
    FIcmsai := FIcmsai + objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000)) / 100;
    FImpFed := FImpFed + objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000)) / 100;
    FDesOpe := FDesOpe + objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000)) / 100;

    FPreUlt := FPreUlt + (objColorante.fltPreUlt * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
    FImpUlt := FImpUlt + (objColorante.fltImpUlt * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));

    FComLiq := FComLiq + (objColorante.fltComLiq * objColorante.fltQtdCol * 0.924 / IfThen(conf.fGetInteger('SHEEMB') = 0, 946, 1000));
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

procedure TFormulaSherwinWhilliams.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objColorante: TColoranteImobiliario;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro : Double;
begin
  conf := fGetConfTinta('SHE');
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

    objColorante.strImpDir := qryCadCol.FieldByName('ITE_IMPDIR').AsString;
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

    objColorante.fltComLiq := fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade * 0.924) * (Preço / ' + IfThen(conf.fGetInteger('SHEEMB') = 0, '946', '1000') + ')');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaSherwinWhilliams.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
    qryCadCol.SQL.Add('   , ITE_CNV_ML                     ');
    qryCadCol.SQL.Add('   , ITE_PREULT                     ');
    qryCadCol.SQL.Add('   , ITE_IMPULT                     ');

    qryCadCol.SQL.Add('   , ITE_PRECOM                       ');
    qryCadCol.SQL.Add('   , ITE_DESF01                       ');
    qryCadCol.SQL.Add('   , ITE_DESF02                       ');
    qryCadCol.SQL.Add('   , ITE_DESF03                       ');
    qryCadCol.SQL.Add('   , ITE_DESF04                       ');
    qryCadCol.SQL.Add('   , ITE_DESF05                       ');
    qryCadCol.SQL.Add('   , ITE_DESF06                       ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
    begin
      qryCadCol.SQL.Add('   , ITE_ICMSAI                     ');
      qryCadCol.SQL.Add('   , ITE_IMPFED                     ');
      qryCadCol.SQL.Add('   , ITE_DESOPE                     ');
      qryCadCol.SQL.Add('   , ITE_OUTVAL                     ');
      qryCadCol.SQL.Add('   , ITE_PREMED                     ');
    end
    else
    begin
      qryCadCol.SQL.Add('   , 0 AS ITE_ICMSAI                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_IMPFED                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_DESOPE                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_OUTVAL                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_PREMED                ');
    end;

    If fCfgSis('IMPDIG') = '1' Then
      qryCadCol.SQL.Add('   , I.ITE_IMPDIR                   ')
    else
      qryCadCol.SQL.Add('   , G.ITE_IMPDIR                   ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    begin
      qryCadCol.SQL.Add('   , COL_PRELIT AS ITE_PRECUS       ');
      qryCadCol.SQL.Add('   , COL_PREVEN AS ITE_PREVEN       ');
    end
    Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
    begin
      qryCadCol.SQL.Add('   , ITE_PRECUS                     ');
      qryCadCol.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
    end
    else
    begin
      qryCadCol.SQL.Add('   , ITE_PRECUS                     ');
      qryCadCol.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
    end;

    qryCadCol.SQL.Add(' FROM                               ');
    qryCadCol.SQL.Add('   SHE_CADCOL                       ');
    qryCadCol.SQL.Add('   JOIN ITEGER G                    ');
    qryCadCol.SQL.Add('     ON G.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add('   LEFT JOIN CADITE I               ');
    qryCadCol.SQL.Add('     ON I.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP       ');

    qryCadCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadCol.Open;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

procedure TFormulaSherwinWhilliams.SetIteBas(const Value: String);
var
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
  conf := fGetConfTinta('SHE');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');
  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Clear;

      If Value = strIteBasOri Then
      Begin
        If fltCusBasOri <= 0.0 Then
        Begin
          qryAux.SQL.Clear;
          qryAux.SQL.Add(' SELECT                               ');
          qryAux.SQL.Add('   I.ITE_CODITE                       ');
          qryAux.SQL.Add('   , G.ITE_PREULT                     ');
          qryAux.SQL.Add('   , G.ITE_IMPULT                     ');

          qryAux.SQL.Add('   , ITE_PRECOM                       ');
          qryAux.SQL.Add('   , ITE_DESF01                       ');
          qryAux.SQL.Add('   , ITE_DESF02                       ');
          qryAux.SQL.Add('   , ITE_DESF03                       ');
          qryAux.SQL.Add('   , ITE_DESF04                       ');
          qryAux.SQL.Add('   , ITE_DESF05                       ');
          qryAux.SQL.Add('   , ITE_DESF06                       ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
          begin
            qryAux.SQL.Add('   , ITE_ICMSAI                       ');
            qryAux.SQL.Add('   , ITE_IMPFED                       ');
            qryAux.SQL.Add('   , ITE_DESOPE                       ');
            qryAux.SQL.Add('   , ITE_OUTVAL                       ');
            qryAux.SQL.Add('   , ITE_PREMED                       ');
          end
          else
          begin
            qryAux.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
            qryAux.SQL.Add('   , 0 AS ITE_IMPFED                  ');
            qryAux.SQL.Add('   , 0 AS ITE_DESOPE                  ');
            qryAux.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
            qryAux.SQL.Add('   , 0 AS ITE_PREMED                  ');
          end;

          If fCfgSis('IMPDIG') = '1' Then
            qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
          else
            qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
          begin
            qryAux.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
            qryAux.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
          end
          Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
          begin
            qryAux.SQL.Add('   , ITE_PRECUS                       ');
            qryAux.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
          end
          else
          begin
            qryAux.SQL.Add('   , ITE_PRECUS                       ');
            qryAux.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
          end;

          qryAux.SQL.Add(' FROM                                 ');
          qryAux.SQL.Add('   SHE_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
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


          FImpFedBas := qryAux.FieldByName('ITE_IMPFED').AsFloat * FVenBasOri / 100;
          FDesOpeBas := (((qryAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBasOri) / 100);
          FPreMedBas := qryAux.FieldByName('ITE_PREMED').AsFloat;
          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);
          FPreUltBas := qryAux.FieldByName('ITE_PREULT').AsFloat;
          FImpUltBas := qryAux.FieldByName('ITE_IMPULT').AsFloat;
          FComLiqBas := fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                               qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                               qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                               qryAux.Fieldbyname('ITE_DESF06').AsFloat);
        End;

        FCusBas := fltCusBasOri;
        FCu2Bas := fltCu2BasOri;
        FVenBas := fltVenBasOri;
      End
      Else
      Begin
        FIteBas := Value;

        qryAux.SQL.Clear;
        qryAux.SQL.Add(' SELECT                               ');
        qryAux.SQL.Add('   I.ITE_CODITE                       ');
        qryAux.SQL.Add('   , G.ITE_PREULT                     ');
        qryAux.SQL.Add('   , G.ITE_IMPULT                     ');                

        qryAux.SQL.Add('   , ITE_PRECOM                       ');
        qryAux.SQL.Add('   , ITE_DESF01                       ');
        qryAux.SQL.Add('   , ITE_DESF02                       ');
        qryAux.SQL.Add('   , ITE_DESF03                       ');
        qryAux.SQL.Add('   , ITE_DESF04                       ');
        qryAux.SQL.Add('   , ITE_DESF05                       ');
        qryAux.SQL.Add('   , ITE_DESF06                       ');                

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
        begin
          qryAux.SQL.Add('   , ITE_ICMSAI                       ');
          qryAux.SQL.Add('   , ITE_IMPFED                       ');
          qryAux.SQL.Add('   , ITE_DESOPE                       ');
          qryAux.SQL.Add('   , ITE_OUTVAL                       ');
          qryAux.SQL.Add('   , ITE_PREMED                       ');
        end
        else
        begin
          qryAux.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
          qryAux.SQL.Add('   , 0 AS ITE_IMPFED                  ');
          qryAux.SQL.Add('   , 0 AS ITE_DESOPE                  ');
          qryAux.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
          qryAux.SQL.Add('   , 0 AS ITE_PREMED                  ');
        end;

        If fCfgSis('IMPDIG') = '1' Then
          qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
        else
          qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
        begin
          qryAux.SQL.Add('   , ITE_PRECUS                       ');
          qryAux.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
        end
        else
        begin
          qryAux.SQL.Add('   , ITE_PRECUS                       ');
          qryAux.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
        end;

        qryAux.SQL.Add(' FROM                                 ');
        qryAux.SQL.Add('   CADITE I                           ');
        qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
        qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
        qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
        qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

        qryAux.ParamByName('CODITE').AsString := FIteBas;
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.Open;

        If fCarregaPromocao(FIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed,
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

        FComLiqBas := fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF06').AsFloat);
      End;

//      FOutValBas := fFormataFloat(FOutValBas, fCfgSis('DECUNI', varInteger));
//      FIcmsaiBas := fFormataFloat(FIcmsaiBas, fCfgSis('DECUNI', varInteger));
//      FImpFedBas := fFormataFloat(FImpFedBas, fCfgSis('DECUNI', varInteger));
//      FDesOpeBas := fFormataFloat(FDesOpeBas, fCfgSis('DECUNI', varInteger));
//      FPreMed    := fFormataFloat(FPreMed,    fCfgSis('DECUNI', varInteger));

      base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Value));
      if not Assigned(base) then
      begin
        base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
          FIteBas, fRetNomProduto(FIteBas), FDesOpeBas, FIcmsaiBas, FImpFedBas,
          FOutValBas, FCusBas, FCu2Bas, FPreMedBas, FVenBas, 1, tmctBaseImobiliaria,
          FPreUltBas, FImpUltBas, FComLiqBas
        ));
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;

function fDigDadosTintometricos(qryCadShe: TUniQuery; strTabPre, strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaSherwinWhilliams;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  Result := False;
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TFormulaSherwinWhilliams.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 0.924;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadShe.FieldByName('SHE_BASE__').AsString,
                                                     qryCadShe.FieldByName('SHE_PROKEY').AsString,
                                                     qryCadShe.FieldByName('SHE_SUBKEY').AsString,
                                                     qryCadShe.FieldByName('SHE_UNIDAD').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadShe.FieldByName('SHE_UNIDAD').AsString;
      objFormula.strDescri    := qryCadShe.FieldByName('SHE_DESCRI').AsString;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(qryCadShe.FieldByName('SHE_FORM' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadShe.FieldByName('SHE_FORM' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadShe.FieldByName('SHE_QTDB' + fStrZero(intContador, 2)).AsFloat;

      End;

      objFormula.pCarregaPrecosColorantes;
      
      Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst             := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption      := frmDigTintaImobiliaria.Caption + 'Sherwin Williams';
      frmDigTintaImobiliaria.objFormula   := objFormula;
      frmDigTintaImobiliaria.strIdePro    := IfNull(dicRetorno['idepro'], 'SHE');
      If frmDigTintaImobiliaria.ShowModal = mrOk Then
        Result := True;

      If (Result) Then
      Begin
        strNovBas := frmDigTintaImobiliaria.strNovBas;
        strDesBas := frmDigTintaImobiliaria.strDesBas;
        strRefere := frmDigTintaImobiliaria.strRefere;
        strUniBas := frmDigTintaImobiliaria.strUniBas;
        strDesCor := frmDigTintaImobiliaria.strDesCor;
        fltPreCus := frmDigTintaImobiliaria.fltPreCus;
        fltPreVen := frmDigTintaImobiliaria.fltPreVen;

        dicRetorno['precu2'] := objFormula.fltPreCu2;
        dicRetorno['premed'] := objFormula.fltPreMed + objFormula.fltPreMedBas;
        dicRetorno['preult'] := objFormula.fltPreUlt + objFormula.fltPreUltBas;
        dicRetorno['impult'] := objFormula.fltImpUlt + objFormula.fltImpUltBas;
        dicRetorno['prctin'] := objFormula.fltComLiq + objFormula.fltComLiqBas;
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
      End;

      If (Result) And (Assigned(dicRetorno)) Then
      Begin
        objFormula.pRecalculaTabelas(dicRetorno);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTintaImobiliaria) then FreeAndNil(frmDigTintaImobiliaria);
  End;
end;

procedure pRetornaDadosSherwinWhilliamsDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadShe: TUniQuery;
    strSQL: String;
begin

  qryCadShe := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SHE_CADSHE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(SHE_DESCRI, " ", SHE_CODIGO, " ", SHE_CODIG2) = :ITETIN ';

  With qryCadShe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadShe.FieldByName('SHE_DESCRI').AsString;
    Close;
  End;

  FreeAndNil(qryCadShe);
end;

procedure pRetornaTabelaPrecoSherwinWhilliams(dicRetorno: TDicionario);
var
  objFormula: TFormulaSherwinWhilliams;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaSherwinWhilliams.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strIteBas := dicRetorno['itebas'];
      
      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, 0.924);
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

{ TfrmConsultaCompSherwinWhilliams }

procedure TfrmConsultaCompSherwinWhilliams.pTarefaFormulacao(
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
    dicParams: TDicionario;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  dicParams := TDicionario.Create;
  dicParams['idepro'] := 'SHE';

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT * FROM SHE_CADSHE WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre, qryGen.FieldByName('SHE_CODITE').AsString,
    strCodIte, strDesBas, strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicParams);

  FreeAndNil(dicParams);
  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompSherwinWhilliams.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompSherwinWhilliams.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadSheNovasFormulas', False);
end;

function fConsultaSherwinWhilliamsDinamicaInterna(Sender: TForm; qryCadShe: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;
begin
  Result := (TSherwinWilliamsConsulta.Create).fExecutarConsulta(Sender,
    qryCadShe, tipoConsulta, strTabPre, TfrmConsultaCompSherwinWhilliams);
end;

function GetIteBasOri(const strIteTin: string): string;
var
  qryGen: TUniQuery;
begin
  Result := '';
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                ' +
        '   B.BAS_CODITE                        ' +
        ' FROM                                  ' +
        '   SHE_CADSHE S                        ' +
        '   INNER JOIN SHE_CADBAS B             ' +
        '     ON S.SHE_BASE__ = B.BAS_BASE__    ' +
        '     AND S.SHE_PROKEY = B.BAS_PROKEY   ' +
        '     AND S.SHE_SUBKEY = B.BAS_SUBKEY   ' +
        '     AND S.SHE_UNIDAD = B.BAS_UNIDAD   ' +
        ' WHERE CONCAT(                         ' +
        '     S.SHE_DESCRI                      ' +
        '     , " "                             ' +
        '     , S.SHE_CODIGO                    ' +
        '     , " "                             ' +
        '     , S.SHE_CODIG2                    ' +
        '     , " "                             ' +
        '     , S.SHE_UNIDAD                    ' +
        '   ) = :ITETIN                         ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;
      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('BAS_CODITE').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.
