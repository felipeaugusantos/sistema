unit untDacarDinamica;

interface

uses SysUtils, Forms, Classes,
  Uni,
  StrUtils, untFuncEspecificas, Controls, untFuncoesSimples,
  untPnlBotoesAcoesNovaConsulta;

Type
  TfrmConsultaCompDacar = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

Type
  TFormulaDacar = class(TFormulaImobiliaria)
    private
      fltPerAcr: Double;
    protected
      procedure SetIteBas(const Value: String); override;
      procedure pCarregarColorantes; override;
    public
      procedure pCarregaPrecosColorantes; override;
      procedure pCalculaPreco; override;
      constructor Create(strTabPrePar: String); override;
  End;

  function fRetornaPrecoDacarDinamica(Sender: TForm; qryCadDac: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProDacarDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoDacarDinamica(strDesCor: String; qryCadDac: TUniQuery): String;

  function fDigDadosTintometricos(qryCadDac: TUniQuery; strTabPre, strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodFml, strCodBas, strCodUni: String): String;

  function fGTinForDacarDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaDacarDinamica(Sender: TForm): String; stdcall;
  function fConsultaDacarDinamicaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaDacarDinamicaVenda(Sender: TForm; strCodEmp: String;
    qryCadDac: TUniQuery): String; stdcall;

  function fConsultaDacarDinamicaInterna(Sender: TForm; qryCadDac: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String): String; stdcall;

  procedure pRetornaDadosDacarDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoDacar(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses DB, untDigTintaImobiliaria, untDacarConsulta,untTintaMaquina,
  untIConsultaTinta,untFuncoes,untIConfTinta,untICalculadorFatVendas,
     untGenericTintaDeMaquinaComponente, untITintaDeMaquinaComponente,
     untTintaDeMaquinaComponenteTipo, untTintaDeMaquinaComponenteComparerColorante,
     untTintaDeMaquinaComponenteComparerBaseImobiliaria;

function fRetornaPrecoDacarDinamica(Sender: TForm; qryCadDac: TUniQuery;
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
  conf         := fGetConfTinta('DAC');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  strAuto := fConsultaDacarDinamicaVenda(Sender, strCodEmp, qryCadDac);
  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  tinta := TDacarConsulta.Create;
  qryCadDac.Close;
  qryCadDac.SQL.Text := TDacarConsulta.Create.fGetSelectAutoIncrem(strAuto);
  qryCadDac.Open;

  If (Not fDigDadosTintometricos(qryCadDac, strTabPre,
        qryCadDac.FieldByName('DAC_CODITE').AsString, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryCadDac.FieldByName('AUTOINCREM').AsString, strCodIte));

  strIteTin := qryCadDac.FieldByName('DAC_DESCRI').AsString +
               qryCadDac.FieldByName('DAC_REFERE').AsString +
               qryCadDac.FieldByName('DAC_CODUNI').AsString +
               qryCadDac.FieldByName('DAC_EMBALA').AsString +
               qryCadDac.FieldByName('DAC_PROCOD').AsString +
               qryCadDac.FieldByName('DAC_CODBAS').AsString +
               qryCadDac.FieldByName('DAC_CODFML').AsString +
               qryCadDac.FieldByName('DAC_COLECA').AsString +
               qryCadDac.FieldByName('DAC_CODCOR').AsString;

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

function fRetornaUniTraProDacarDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf          := fGetConfTinta('DAC');
  strSiglaTrava := conf.fGet('TRADAC'); //fArqIniTinta(0, 'DACAR', 'TRADAC', '');
  fltFatTrava   := conf.fGetDouble('FATDAC'); //fStrToFloat(fArqIniTinta(0, 'DACAR', 'FATDAC', ''));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoDacarDinamica(strDesCor: String; qryCadDac: TUniQuery): String;
begin
  Result := strDesCor;
end;

function fRetornaProdutoBase(strCodFml, strCodBas, strCodUni: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('	BAS_CODITE ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('	DAC_CADBAS ');
  qryAux.SQL.Add('	INNER JOIN DAC_UNIDAC ');
  qryAux.SQL.Add('	ON (DAC_CADBAS.BAS_UNIDAD = DAC_UNIDAC.DAC_UNIAUT) ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('	BAS_CODFML = :CODFML AND ');
  qryAux.SQL.Add('	BAS_BASE__ = :CODBAS AND ');
  qryAux.SQL.Add('	DAC_UNIAUT = :CODUNI ');

  qryAux.ParamByName('CODFML').AsString := strCodFml;
  qryAux.ParamByName('CODBAS').AsString := strCodBas;
  qryAux.ParamByName('CODUNI').AsString := strCodUni;

  qryAux.Open;
  Result := qryAux.FieldByName('BAS_CODITE').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fGTinForDacarDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM DAC_CADDAC ';
  strSQL := strSQL + ' WHERE CONCAT(IFNULL(DAC_DESCRI,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_REFERE,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODUNI,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_EMBALA,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_PROCOD,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODBAS,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODFML,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_COLECA,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODCOR,"")) = :ITETIN; ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  DAC_CADDAC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ';

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
    End;

    For intContador := 1 To 15 Do
    Begin

      strCamFor := 'DAC_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'DAC_QTDB' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat;

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
  strSQL := strSQL + '  DAC_CADCOL ';
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

function fConsultaDacarDinamica(Sender: TForm): String;
  Var
    qryCadSal: TUniQuery;
begin
  qryCadSal := fCriaQuery(Sender);
  Result :=  fConsultaDacarDinamicaInterna(Sender, qryCadSal, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
  FreeAndNil(qryCadSal);
end;

function fConsultaDacarDinamicaGeral(Sender: TForm; strCodEmp: String): String;
begin
  Result := fConsultaDacarDinamica(Sender);
end;

function fConsultaDacarDinamicaVenda(Sender: TForm; strCodEmp: String;
  qryCadDac: TUniQuery): String;
begin
  Result := fConsultaDacarDinamicaInterna(Sender, qryCadDac, tpcVenda, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
end;

{ TFormulaDacar }

constructor TFormulaDacar.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('DAC');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

end;

procedure TFormulaDacar.pCalculaPreco;
  Var
    objColorante : TColoranteImobiliario;
    intIndex  : Integer;
    fltEmbala : Double;
    componente: ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    FPreCus := 0.0;
    FPreVen := 0.0;
    FCusCol := 0.0;
    FCu2Col := 0.0;
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

    If (qryCadCol.FieldByName('DAC_EMBALA').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não está com a embalagem configurada.' + #13#10 +
                             'Favor verificar.');
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

    fltEmbala := qryCadCol.FieldByName('DAC_EMBALA').AsFloat;

    componente.Quantidade                := objColorante.fltQtdCol;
    componente.PrecoCusto                := (objColorante.fltQtdCol) * (objColorante.fltPreCus / fltEmbala);
    componente.PrecoCustoReal            := (objColorante.fltQtdCol) * (objColorante.fltPreCu2 / fltEmbala);
    componente.PrecoVenda                := (objColorante.fltQtdCol) * (objColorante.fltPreVen / fltEmbala);
    componente.PrecoMedio                := objColorante.fltPreMed * objColorante.fltQtdCol / fltEmbala;
    componente.OutrosValores             := objColorante.fltOutVal * objColorante.fltQtdCol / fltEmbala;
    componente.IcmsSaida                 := objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol / fltEmbala) / 100;
    componente.ImpostosFederais          := objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol / fltEmbala) / 100;
    componente.DespesasOperacionais      := objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol / fltEmbala) / 100;
    componente.UltimoPrecoCompra         := objColorante.fltPreUlt * objColorante.fltQtdCol / fltEmbala;;
    componente.UltimoPrecoCompraImpostos := objColorante.fltImpUlt * objColorante.fltQtdCol / fltEmbala;;
    componente.PrecoCompraLiquido        := objColorante.fltComLiq * objColorante.fltQtdCol / fltEmbala;;

{
    fltEmbala := qryCadCol.FieldByName('DAC_EMBALA').AsFloat;

    FCusCol := FCusCol + (objColorante.fltQtdCol) * (objColorante.fltPreCus / fltEmbala);
    FCu2Col := FCu2Col + (objColorante.fltQtdCol) * (objColorante.fltPreCu2 / fltEmbala);
    FVenCol := FVenCol + (objColorante.fltQtdCol) * (objColorante.fltPreVen / fltEmbala);
    FPreMed := FPreMed + objColorante.fltPreMed * objColorante.fltQtdCol / fltEmbala;

    FOutVal := FOutVal + objColorante.fltOutVal * objColorante.fltQtdCol / fltEmbala;
    FIcmsai := FIcmsai + objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol / fltEmbala) / 100;
    FImpFed := FImpFed + objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol / fltEmbala) / 100;
    FDesOpe := FDesOpe + objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol / fltEmbala) / 100;

    FPreUlt := FPreUlt + objColorante.fltPreUlt * objColorante.fltQtdCol / fltEmbala;
    FImpUlt := FImpUlt + objColorante.fltImpUlt * objColorante.fltQtdCol / fltEmbala;
    FComLiq := FComLiq + objColorante.fltComLiq * objColorante.fltQtdCol / fltEmbala;
}
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

procedure TFormulaDacar.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objColorante: TColoranteImobiliario;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro, fltPreVenPro: Double;

begin
  conf := fGetConfTinta('DAC');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');
  Try
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
      objColorante.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                                     qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                                     qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                                     qryCadCol.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
    End;

    FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
    FCalculo.Add('Valor do Colorante = (Quantidade) * (Preço / Embalagem)');
    FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
  Except
    fMensagem('ATENÇÃO', 'NÃO FOI POSSIVEL COLETAR OS DADOS DOS COLORANTES!!!', ['OK']);
  End;
end;

procedure TFormulaDacar.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
    qryCadCol.SQL.Add('   , ITE_CNV_ML                     ');
    qryCadCol.SQL.Add('   , DAC_EMBALA                     ');

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
      qryCadCol.SQL.Add('   , COL_PRECUS AS ITE_PRECUS       ');
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
    qryCadCol.SQL.Add('   DAC_CADCOL                       ');
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

procedure TFormulaDacar.SetIteBas(const Value: String);
var
  qryAux         : TUniQuery;
  fltIcmsai      : Double;
  conf           : IConfTinta;
  fltDesOpeTinta : Double;
  fltPreCusPro,
  fltPreVenPro   : Double;
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
  conf := fGetConfTinta('DAC');
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
          qryAux.SQL.Add('   DAC_CADBAS B                       ');
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
            FPromoc    := 'N';
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

          FPreUltBas := qryAux.FieldByName('ITE_PREULT').AsFloat;
          FImpUltBas := qryAux.FieldByName('ITE_IMPULT').AsFloat;

          FComLiqBas := fFormataFloat(fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                                             qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                                             qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                                             qryAux.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));

          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);
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
          FPromoc := 'N';
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

function fDigDadosTintometricos(qryCadDac: TUniQuery; strTabPre, strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaDacar;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  Result := False;
  objFormula := nil;
  frmDigTintaImobiliaria := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaDacar.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 1;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadDac.FieldByName('DAC_CODFML').AsString,
                                                     qryCadDac.FieldByName('DAC_CODBAS').AsString,
                                                     qryCadDac.FieldByName('DAC_CODUNI').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadDac.FieldByName('DAC_CODUNI').AsString;
      objFormula.strDescri    := qryCadDac.FieldByName('DAC_DESCRI').AsString;

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(qryCadDac.FieldByName('DAC_FORM' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadDac.FieldByName('DAC_FORM' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadDac.FieldByName('DAC_QTDB' + fStrZero(intContador, 2)).AsFloat;

      End;

      objFormula.pCarregaPrecosColorantes;

      Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Dacar';
      frmDigTintaImobiliaria.objFormula := objFormula;
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
    if Assigned(frmDigTintaImobiliaria) then FreeAndNil(frmDigTintaImobiliaria);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
end;

procedure pRetornaDadosDacarDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadDac: TUniQuery;
    strSQL: String;
begin
  qryCadDac := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM DAC_CADDAC ';
  strSQL := strSQL + ' WHERE CONCAT(IFNULL(DAC_DESCRI,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_REFERE,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODUNI,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_EMBALA,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_PROCOD,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODBAS,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODFML,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_COLECA,""),  ';
  strSQL := strSQL + ' 	IFNULL(DAC_CODCOR,"")) = :ITETIN; ';

  With qryCadDac Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  DAC_CADDAC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      Open;
    End;

    dicRetorno['codtin'] := qryCadDac.FieldByName('DAC_DESCRI').AsString;
    Close;
  End;

  FreeAndNil(qryCadDac);
end;

procedure pRetornaTabelaPrecoDacar(dicRetorno: TDicionario);
var
  objFormula: TFormulaDacar;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaDacar.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strIteBas := dicRetorno['itebas'];
            
      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, 1);
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

function fConsultaDacarDinamicaInterna(Sender: TForm; qryCadDac: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String): String; stdcall;
begin
  Result := (TDacarConsulta.Create).fExecutarConsulta(Sender,
    qryCadDac, tipoConsulta, strTabPre, TfrmConsultaCompDacar);
end;

{ TfrmConsultaCompDacar }

procedure TfrmConsultaCompDacar.pTarefaFormulacao(Sender: TObject);
  Var
    qryConsulta01: TUniQuery;

    {*******************************************}
    {* VARIÁVEIS INTERNAS                      *}
    {****************************************MV*}
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

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM DAC_CADDAC WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  If (Not fDigDadosTintometricos(qryConsulta01, strTabPre,
        qryConsulta01.FieldByName('DAC_CODITE').AsString, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create)) Then
  Begin
    Exit;
  End;

  FreeAndNil(qryConsulta01);
end;

procedure TfrmConsultaCompDacar.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompDacar.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadDacNovasFormulas', False);
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
        '   DAC_CADDAC A                        ' +
        '   INNER JOIN DAC_CADBAS B             ' +
        '     ON A.DAC_CODFML = B.BAS_CODFML    ' +
        '     AND A.DAC_CODBAS = B.BAS_BASE__   ' +
        '   INNER JOIN DAC_UNIDAC U             ' +
        '     ON B.BAS_UNIDAD = U.DAC_UNIAUT    ' +
        '     AND U.DAC_UNIAUT = A.DAC_CODUNI   ' +
        ' WHERE CONCAT(                         ' +
        '     IFNULL(A.DAC_DESCRI, '''')        ' +
        '     , IFNULL(A.DAC_REFERE, '''')      ' +
        '     , IFNULL(A.DAC_CODUNI, '''')      ' +
        '     , IFNULL(A.DAC_EMBALA, '''')      ' +
        '     , IFNULL(A.DAC_PROCOD, '''')      ' +
        '     , IFNULL(A.DAC_CODBAS, '''')      ' +
        '     , IFNULL(A.DAC_CODFML, '''')      ' +
        '     , IFNULL(A.DAC_COLECA, '''')      ' +
        '     , IFNULL(A.DAC_CODCOR, '''')      ' +
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
