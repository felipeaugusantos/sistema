unit untAdvanceIndustrialDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, SysUtils, Controls,
  Math, Dialogs, Variants, untPnlBotoesAcoesNovaConsulta,
  UniClientDataSet;

Type
  TfrmConsultaCompAdvance = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaAdvance = class(TFormulaIndustrial)  
  private
    fltPerAcr: Double;
  protected
    procedure pCarregarBases(dicRetorno: TDicionario); override;
    procedure pCarregarColorantes; override;
    procedure SetIteBas(const Value: String); override;
    procedure SetstrCompB(const Value: String); override;
  public
    procedure pCalculaPreco; override;
    procedure pCarregaPrecosColorantes; override;
    constructor Create(strTabPrePar: String); override;
    destructor Destroy; override;
  End;

  function fRetornaPrecoAdvanceDinamica(Sender: TForm; qryCadAdv: TUniQuery; Var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fRetornaUniTraProAdvanceDinamica(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaDescricaoAdvanceDinamica(strDesCor: String; qryCadAdv: TUniClientDataSet): String;

  function fDigDadosTintometricos(qryCadAdv: TUniClientDataSet; strTabPre: String; var strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strCodUni: String): String;
  function fGTinForAdvanceDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;

  function fConsultaAdvanceDinamica(Sender: TForm): String; stdcall;
  function fConsultaAdvanceDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaAdvanceDinamicaVenda(Sender: TForm; qryCadAdv: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaAdvanceDinamicaInterna(Sender: TForm;  qryCadAdv: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosAdvanceDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoAdvance(dicRetorno: TDicionario);
  function fGetItemBaseOri(const strIteTin: String): string;

implementation

uses DB, untDigTintaIndustrial, untFuncoes, untAdvanceIndustrialConsulta, untClientDataSetFactory,
  untMultiSelectLocalizadorFactory,untIConfTinta ,untTintaMaquina, untIConsultaTinta;

{ TfrmConsultaCompAdvance }

procedure TfrmConsultaCompAdvance.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  strCodIte: String;
  strDesBas: String;
  strRefBas: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  fltUnitar: Double;
  strCodBas: String;
begin
  qryGen := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM ADV_CADADV WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;

      fDigDadosTintometricos(TClientDataSetFactory.GetClientDataSet(qryGen), strTabPre, strCodBas, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create);
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

procedure TfrmConsultaCompAdvance.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompAdvance.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadAdvNovasFormulas', False);
end;

{ TFormulaAdvance }

constructor TFormulaAdvance.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
    dicRetorno: TDicionario;
begin
  inherited Create(strTabPrePar, TComponenteIndustrial);
  dicRetorno := Nil;
  qryCadBas := fCriaQuery();
  pCarregarBases(dicRetorno);

  conf := fGetConfTinta('ADV');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

end;

destructor TFormulaAdvance.Destroy;
begin
  FreeAndNil(qryCadBas);
  inherited;
end;


procedure TFormulaAdvance.pCalculaPreco;
var
  objComponente: TComponenteIndustrial;
  intIndex: Integer;
  cdsCadCol: TUniClientDataSet;

  procedure pZerarPrecos;
  begin
    FPreCus := 0.0;
    FPreVen := 0.0;
    FCusCol := 0.0;
    FVenCol := 0.0;

    FOutVal := 0;
    FIcmsai := 0;
    FImpFed := 0;
    FDesOpe := 0;
  End;
begin
  inherited;
  pZerarPrecos;
  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

  For intIndex := 0 To Count -1 Do
  Begin

    objComponente := TComponenteIndustrial(Items[intIndex]);

    if objComponente.strTipComp = 'C' then
    begin
      If (Not cdsCadCol.Locate('COL_CODCOL', objComponente.strCodcol, [])) Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não cadastrado. Favor verificar.');
        Exit;
      End;

      If (fEmptyStr(cdsCadCol.FieldByName('COL_CODITE').AsString)) Then
      Begin
        pZerarPrecos;     
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                               'Favor verificar.');
        Exit;
      End;

      If (cdsCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('O produto ' + cdsCadCol.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                               'preenchido corretamente. Favor verificar.');
        Exit;
      End;

      If fEmptyStr(cdsCadCol.FieldByName('COL_PESESP').AsString) Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não está com o peso específico cadastrado.' + #13#10 +
                               'Favor verificar.');
        Exit;
      End;

      If cdsCadCol.FieldByName('COL_PESESP').AsFloat <= 0 Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' deve ter o peso específico maior que zero!' + #13#10 +
                               'Favor verificar.');
        Exit;
      End;

      If cdsCadCol.FieldByName('COL_EMBALA').AsFloat <= 0 Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' deve ter a embalagem maior que zero!' + #13#10 +
                               'Favor verificar.');
        Exit;
      End;

      if not IsItemAtivo(cdsCadCol.FieldByName('COL_CODITE').AsString) then
      begin
        pZerarPrecos;
        raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadCol.FieldByName('COL_CODITE').AsString]);
      end;
    End;

    FCusCol := FCusCol + objComponente.fltQtdCol * objComponente.fltPreCus / cdsCadCol.FieldByName('COL_EMBALA').AsFloat;
    FVenCol := FVenCol + objComponente.fltQtdCol * objComponente.fltPreVen / cdsCadCol.FieldByName('COL_EMBALA').AsFloat;
  End;

  FVenCol := FVenCol + (fltPerAcr * FVenCol);

  FPreCus := FCusBas + FCusCol + IfThen(strCompB <> '', fltCusBasB, 0);
  FPreVen := FVenBas + FVenCol + IfThen(strCompB <> '', fltVenBasB, 0);

  pCarregaPrecosColorantes;
end;

procedure TFormulaAdvance.pCarregaPrecosColorantes;
var
  intContador: Integer;
  objComponente: TComponenteIndustrial;
  cdsCadCol: TUniClientDataSet;
  fltPreCusPro,
  fltPreVenPro : Double;
begin
  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);
  For intContador := 0 To Self.Count-1 Do
  Begin
    objComponente := TComponenteIndustrial(Self.Items[intContador]);
    cdsCadCol.Locate('COL_CODCOL', objComponente.strCodCol, []);

    If fCarregaPromocao(cdsCadCol.FieldByName('COL_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,fltPreCusPro, fltPreVenPro) Then
    Begin
      FCusBasOri := fltPreCusPro;
      FVenBasOri := fltPreVenPro;
      FPromoc    := 'S';

      If FCusBasOri = 0 Then
        FCusBasOri := cdsCadCol.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      FCusBasOri := cdsCadCol.FieldByName('ITE_PRECUS').AsFloat;
      FVenBasOri := cdsCadCol.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objComponente.fltPreCus := FCusBasOri;
    objComponente.fltPreVen := FVenBasOri;



    objComponente.fltPesEsp := cdsCadCol.FieldByName('COL_PESESP').AsFloat;
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Parte B = ' + IfThen(strCompB <> '', FormatCurr('0.00', fltVenBasB), 'Incluso no valor da base'));
  FCalculo.Add('Valor do Componente = (Quantidade) * (Preço / Embalagem)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Componente de todos os Componentes)');
end;

procedure TFormulaAdvance.pCarregarBases(dicRetorno: TDicionario);
begin
  Try
    Try
      qryCadBas.SQL.Clear;
      qryCadBas.SQL.Add('SELECT ');
      qryCadBas.SQL.Add('  BAS_CODBAS, ');
      qryCadBas.SQL.Add('  BAS_CODITE, ');
      qryCadBas.SQL.Add('  BAS_UNIDAD, ');
      qryCadBas.SQL.Add('  ITE_CNV_ML, ');

      If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
      Begin
        qryCadBas.SQL.Add('  BAS_PRECUS AS ITE_PRECUS, ');
        qryCadBas.SQL.Add('  BAS_PREVEN AS ITE_PREVEN ');
      End
      Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
      Begin
        qryCadBas.SQL.Add('  ITE_PRECUS, ');
        qryCadBas.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
      End
      Else
      Begin
        qryCadBas.SQL.Add('  ITE_PRECUS, ');
        qryCadBas.SQL.Add('  ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ');
      End;

      qryCadBas.SQL.Add('FROM ');
      qryCadBas.SQL.Add('  ADV_CADBAS');
      qryCadBas.SQL.Add('  JOIN ITEGER G ON G.ITE_CODITE = BAS_CODITE ');
      qryCadBas.SQL.Add('              AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
      qryCadBas.SQL.Add('  LEFT JOIN CADITE I ON I.ITE_CODITE = BAS_CODITE  ');
      TClientDataSetFactory.GetClientDataSet(qryCadBas);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

procedure TFormulaAdvance.pCarregarColorantes;
begin
  Try
    Try
      qryCadCol.SQL.Clear;
      qryCadCol.SQL.Add('SELECT ');
      qryCadCol.SQL.Add('  COL_CODCOL, ');
      qryCadCol.SQL.Add('  COL_CODITE, ');
      qryCadCol.SQL.Add('  ITE_CNV_ML, ');
      qryCadCol.SQL.Add('  COL_PESESP, ');
      qryCadCol.SQL.Add('  COL_EMBALA, ');

      If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
      Begin
        qryCadCol.SQL.Add('  COL_PRECUS AS ITE_PRECUS, ');
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
      qryCadCol.SQL.Add('  ADV_CADCOL');
      qryCadCol.SQL.Add('  JOIN ITEGER G ON G.ITE_CODITE = COL_CODITE ');
      qryCadCol.SQL.Add('              AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
      qryCadCol.SQL.Add('  LEFT JOIN CADITE I ON I.ITE_CODITE = COL_CODITE  ');
      TClientDataSetFactory.GetClientDataSet(qryCadCol);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

procedure TFormulaAdvance.SetIteBas(const Value: String);
var
  qryAux: TUniQuery;
  cdsAux: TUniClientDataSet;
  fltPreCusPro,
  fltPreVenPro : Double;
begin
  inherited;
  qryAux := nil;
  Try
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

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
          Begin
            qryAux.SQL.Add('  BAS_PRECUS AS ITE_PRECUS, ');
            qryAux.SQL.Add('  BAS_PREVEN AS ITE_PREVEN, ');
          End
          Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
          Begin
            qryAux.SQL.Add('  ITE_PRECUS, ');
            qryAux.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN, ');
          End
          Else
          Begin
            qryAux.SQL.Add('  ITE_PRECUS, ');
            qryAux.SQL.Add('  ITE_PREVE' + strTabPre + ' AS ITE_PREVEN, ');
          End;

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
          Begin
            qryAux.SQL.Add('  ITE_ICMSAI, ');
            qryAux.SQL.Add('  ITE_IMPFED, ');
            qryAux.SQL.Add('  ITE_DESOPE, ');
            qryAux.SQL.Add('  ITE_OUTVAL ');
          End
          Else
          Begin
            qryAux.SQL.Add('  -1.0000 AS ITE_ICMSAI, ');
            qryAux.SQL.Add('  -1.0000 AS ITE_IMPFED, ');
            qryAux.SQL.Add('  -1.0000 AS ITE_DESOPE, ');
            qryAux.SQL.Add('  -1.0000 AS ITE_OUTVAL ');
          End;

          qryAux.SQL.Add('FROM ');
          qryAux.SQL.Add('  ADV_CADBAS ');
          qryAux.SQL.Add('  JOIN ITEGER ON ITE_CODITE = BAS_CODITE AND ');
          qryAux.SQL.Add('                 ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
          qryAux.SQL.Add('WHERE ');
          qryAux.SQL.Add('  ITE_CODITE = :CODITE ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          cdsAux := TClientDataSetFactory.GetClientDataSet(qryAux);


          If fCarregaPromocao(FIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed,fltPreCusPro, fltPreVenPro) Then
          Begin
            FCusBasOri := fltPreCusPro;
            FVenBasOri := fltPreVenPro + (fltPerAcr * fltPreVenPro);
            FPromoc    := 'S';

            If FCusBasOri = 0 Then
              FCusBasOri := cdsAux.FieldByName('ITE_PRECUS').AsFloat;

          End
          Else
          Begin
            FCusBasOri := cdsAux.FieldByName('ITE_PRECUS').AsFloat;
            FVenBasOri := cdsAux.FieldByName('ITE_PREVEN').AsFloat + (fltPerAcr * cdsAux.FieldByName('ITE_PREVEN').AsFloat);
          End;

          FOutValBas := 0;
          FIcmsaiBas := 0;
          FImpFedBas := 0;
          FDesOpeBas := 0;
        End;
        FCusBas := fltCusBasOri;
        FVenBas := fltVenBasOri;
      End
      Else
      Begin
        FIteBas := Value;
        qryAux.SQL.Add('SELECT ');
        qryAux.SQL.Add('  G.ITE_PRECUS, ');
        qryAux.SQL.Add('  G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ');
        qryAux.SQL.Add('FROM ');
        qryAux.SQL.Add('  ITEGER G ');
        qryAux.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  G.ITE_CODITE = :CODITE AND ');
        qryAux.SQL.Add('  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');

        qryAux.ParamByName('CODITE').AsString := strIteBas;

        qryAux.Open;

        If fCarregaPromocao(strIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro) Then
        Begin
          FCusBas := fltPreCusPro;
          FVenBas := fltPreVenPro + (fltPerAcr * fltPreVenPro);
          FPromoc := 'S';

          If FCusBas = 0 Then
            FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
          FVenBas := qryAux.FieldByName('ITE_PREVEN').AsFloat + (fltPerAcr * qryAux.FieldByName('ITE_PREVEN').AsFloat);
        End;


        FOutValBas := 0;
        FIcmsaiBas := 0;
        FImpFedBas := 0;
        FDesOpeBas := 0;
      End;

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


function fRetornaPrecoAdvanceDinamica(Sender: TForm; qryCadAdv: TUniQuery; Var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
  strCodEmp: String;
  strOpcDoc: String;
  blnUsaPreCus: Boolean;
  strTabPre: String;

  strCodBas: String;
  strNovBas: String;
  strDesBas: String;
  strRefere: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  fltPreVen: Double;

  strIteTin: String;
  fltUniTar: Double;
  strAuto: string;
  tinta : IConsultaTinta;
  cdsCadAdv: TUniClientDataSet;
begin
  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaAdvanceDinamicaVenda(Sender, qryCadAdv, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TAdvanceIndustrialConsulta.Create;

  qryCadAdv.Close;
  qryCadAdv.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  cdsCadAdv := TClientDataSetFactory.GetClientDataSet(qryCadAdv);

  strDesCor := cdsCadAdv.FieldbyName('AUTOINCREM').AsString;

  If Not fDigDadosTintometricos(cdsCadAdv, strTabPre, strCodBas,
      strNovBas, strDesBas, strRefere, strUniBas, strDesCor, fltPreCus,
      fltPreVen, dicRetorno) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(cdsCadAdv.FieldbyName('AUTOINCREM').AsString, strNovBas));

  strIteTin := cdsCadAdv.FieldByName('ADV_MD5KEY').AsString;
  fltUniTar := fltPreVen;

  If blnUsaPreCus Then
    fltUniTar := fltPreCus;

  dicRetorno['unidad'] := strUniBas;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltUnitar;
  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strNovBas;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;

  Result := True;
end;

function fRetornaUniTraProAdvanceDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf          := fGetConfTinta('ADV');
  strSiglaTrava := conf.fGet('ADVTRA'); //fArqIniTinta(0, 'ADVANCE', 'ADVTRA', '');
  fltFatTrava   := conf.fGetDouble('FATADV'); //fStrToFloat(fArqIniTinta(0, 'ADVANCE', 'FATADV', ''));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoAdvanceDinamica(strDesCor: String; qryCadAdv: TUniClientDataSet): String;
  Var
    strAux: String;
    strAuxb: String;
begin
  strAux := qryCadAdv.FieldByName('ADV_FORMUL').AsString;
  strAuxb := qryCadAdv.FieldByName('ADV_UNIDAD').AsString;

  Result := Trim(Format(strDesCor, [strAux, strAuxb]));
end;

function fDigDadosTintometricos(qryCadAdv: TUniClientDataSet; strTabPre: String; var strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
  var
    objComponente: TComponenteIndustrial;
    objFormula: TFormulaAdvance;
    intContador: Integer;
begin
  objFormula := nil;
  frmDigTintaIndustrial := nil;
  Result := False;
  Try
    Try
      objFormula := TFormulaAdvance.Create(strTabPre);
      objFormula.fltFatorEstoque := 1;

      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadAdv.FieldByName('ADV_BASE01').AsString,
                                    qryCadAdv.FieldByName('ADV_UNIDAD').AsString);

      objFormula.strIteBas := objFormula.strIteBasOri;
      objFormula.strUnidad := qryCadAdv.FieldByName('ADV_UNIDAD').AsString;

      objFormula.strDescri := fRetornaDescricaoAdvanceDinamica('%s', qryCadAdv);

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');

      For intContador := 1 To 12 Do
      Begin
        If fEmptyStr(qryCadAdv.FieldByName('ADV_CODC' + fStrZero(intContador, 2)).AsString) Then
          Break;

        objComponente := TComponenteIndustrial(objFormula.Add);
        objComponente.strTipComp := 'C';
        objComponente.strCodCol := qryCadAdv.FieldByName('ADV_CODC' + fStrZero(intContador, 2)).AsString;
        objComponente.fltQtdCol := qryCadAdv.FieldByName('ADV_QTDC' + fStrZero(intContador, 2)).AsFloat;
      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      pCriarFormularios(TfrmDigTintaIndustrial  , frmDigTintaIndustrial );
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaIndustrial.Caption := frmDigTintaIndustrial.Caption + 'Advance';
      frmDigTintaIndustrial.objFormula := objFormula;
      Result := (frmDigTintaIndustrial.ShowModal = mrOk);

      If Result Then
      Begin
        strNovBas := frmDigTintaIndustrial.strNovBas;
        strDesBas := frmDigTintaIndustrial.strDesBas;
        strRefere := frmDigTintaIndustrial.strRefere;
        strUniBas := frmDigTintaIndustrial.strUniBas;
        strDesCor := frmDigTintaIndustrial.strDesCor;
        fltPreCus := frmDigTintaIndustrial.fltPreCus;
        fltPreVen := frmDigTintaIndustrial.fltPreVen;
        strCodBas := frmDigTintaIndustrial.objFormula.strIteBasOri;

        dicRetorno['maximoqtdbase'] := frmDigTintaIndustrial.fltQtdMaximo;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaIndustrial.matrizSaldosColorantes);
        dicRetorno['complementob'] := frmDigTintaIndustrial.objFormula.strCompB;
        dicRetorno['promoc'] := frmDigTintaIndustrial.objFormula.strPromoc;

        AcertaImpostos(fltPreCus, objFormula.fltPreCu2,
          objFormula.fltOutVal + objFormula.fltOutValBas,
          objFormula.fltIcmsai + objFormula.fltIcmsaiBas,
          objFormula.fltImpFed + objFormula.fltImpFedBas,
          objFormula.fltDesOpe + objFormula.fltDesOpeBas,
          dicRetorno);
      
        If Result And Assigned(dicRetorno) Then
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
    if Assigned(frmDigTintaIndustrial) then FreeAndNil(frmDigTintaIndustrial);
  End;

end;


function fRetornaProdutoBase(strCodBas, strCodUni: String): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Add(' SELECT ');
      qryGen.SQL.Add('   BAS_CODITE ');
      qryGen.SQL.Add(' FROM ADV_CADBAS ');
      qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
      qryGen.SQL.Add('     AND BAS_UNIDAD = :UNIDAD ');

      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.ParamByName('UNIDAD').AsString := strCodUni;

      Result := TClientDataSetFactory.GetClientDataSet(qryGen).FieldByName('BAS_CODITE').AsString;
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

function fGTinForAdvanceDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;
var
  qryGen: TUniQuery;
  dicComponentes: TDicionario;

  strComponentes: String;
  strSql: String;
  intCont: Integer;
  cdsGen: TUniClientDataSet;
begin
  Result := False;
  qryGen := nil;
  dicComponentes := nil;
  Try
    Try
      dicComponentes := TDicionario.Create;
      strComponentes := '';

      Result := TMultiSelectLocalizadorFactory.GetLocalizador('ADV').Localizar(cdsGen, ['ITETIN'], [strIteTin]);
      if not Result then
        Exit;

      For intCont := 1 To 12 Do
      Begin
        arrFormul[intCont].strFormul :=
          cdsGen.FieldByName('ADV_CODC' + fStrZero(IntToStr(intCont), 2)).AsString;

        If fEmptyStr(arrFormul[intCont].strFormul) Then
          Break;

        arrFormul[intCont].fltQtdbas :=
          cdsGen.FieldByName('ADV_QTDC' + fStrZero(IntToStr(intCont), 2)).AsFloat;

        dicComponentes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        strComponentes := strComponentes + ',' + QuotedStr(arrFormul[intCont].strFormul);
      End;

      strComponentes := Trim(strComponentes);
      strComponentes := Copy(strComponentes, 2, Length(strComponentes));

      strSql := '';
      strSql := strSql + ' SELECT "C" TIPO, ';
      strSql := strSql + '   COL_CODCOL, ';
      strSql := strSql + '   COL_CODITE ';
      strSql := strSql + ' FROM ADV_CADCOL ';
      strSql := strSql + ' WHERE ' + GetInToOr('COL_CODCOL', strComponentes) ;

      qryGen := fCriaQuery();
      qryGen.Close;
      qryGen.SQL.Text := strSql;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      SetLength(arrBaixaPigmentos, cdsGen.RecordCount);

      While Not cdsGen.Eof Do
      Begin
        stlItensTraMl.Add(cdsGen.FieldByName('COL_CODITE').AsString);

        arrBaixaPigmentos[cdsGen.RecNo - 1].strCodIte := cdsGen.FieldByName('COL_CODITE').AsString;
        arrBaixaPigmentos[cdsGen.RecNo - 1].fltQtdBaixa := dicComponentes[cdsGen.FieldByName('COL_CODCOL').AsString];
        arrBaixaPigmentos[cdsGen.RecNo - 1].strTipComp := cdsGen.FieldByName('TIPO').AsString;
        cdsGen.Next;
      End;

      {**************************************************************************************************}
      {* CASO VENHA ALGUM ITEM EM STRITECOB, QUER DIZER QUE O USUARIO SELECIONOU UM COMPLEMENTO DE BASE *}
      {***********************************************************************************************PH*}
      If Not fEmptyStr(strIteCob) Then
      Begin
        stlItensTraMl.Add(strIteCob);
        SetLength(arrBaixaPigmentos, Length(arrBaixaPigmentos) + 1);
        arrBaixaPigmentos[Length(arrBaixaPigmentos) - 1].strCodIte := strIteCob;
        arrBaixaPigmentos[Length(arrBaixaPigmentos) - 1].fltQtdBaixa := 1;
        arrBaixaPigmentos[Length(arrBaixaPigmentos) - 1].strTipComp := 'B';
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(dicComponentes) then FreeAndNil(dicComponentes);
  End;
end;

function fConsultaAdvanceDinamica(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      Result := fConsultaAdvanceDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
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

function fConsultaAdvanceDinamicaGeral(Sender: TForm): String; stdcall;
begin
  Result := fConsultaAdvanceDinamica(Sender);
end;

function fConsultaAdvanceDinamicaVenda(Sender: TForm; qryCadAdv: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaAdvanceDinamicaInterna(Sender, qryCadAdv, strTabPre, tpcVenda,
    blnFaturamento, dicRetorno, sltItems);
end;

function fConsultaAdvanceDinamicaInterna(Sender: TForm;  qryCadAdv: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TAdvanceIndustrialConsulta.Create).fExecutarConsulta(Sender,
    qryCadAdv, tipoConsulta, strTabPre, TfrmConsultaCompAdvance,
    '', blnFaturamento, dicRetorno, sltItems);
end;

procedure pRetornaDadosAdvanceDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  cdsGen: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('ADV').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
  begin
    dicRetorno['codtin'] := cdsGen.FieldByName('ADV_FORMUL').AsString + ' ' + cdsGen.FieldByName('ADV_FORMUL').AsString;
  end;
end;

procedure pRetornaTabelaPrecoAdvance(dicRetorno: TDicionario);
var
  objFormula: TFormulaAdvance;
begin
  objFormula := nil;
  Try
    Try
      objFormula := TFormulaAdvance.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fGetItemBaseOri(dicRetorno['itetin']);
      objFormula.strIteBas    := objFormula.strIteBasOri;
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


procedure TFormulaAdvance.SetstrCompB(const Value: String);
var
  qryAux: TUniQuery;
  cdsAux: TUniClientDataSet;
  fltPreCusPro,
  fltPreVenPro : Double;
begin
  inherited;
  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Clear;
      If Value = strIteBas Then
      Begin
        {******************************************************}
        {* CASO SEJA O MESMO ITEM DA BASE, CONSIDERAR O PRECO *}
        {* COMO ZERO, POIS QUANDO O USUARIO ESCOLHER O MESMO  *}
        {* ITEM DA BASE, SIGNIFICA QUE A PARTE B JA FAZ PARTE *}
        {* DO ITEM DA BASE                                    *}
        {***************************************************PH*}
        fltCusBasB := 0;
        fltVenBasB := 0;

        FOutValBas := 0;
        FIcmsaiBas := 0;
        FImpFedBas := 0;
        FDesOpeBas := 0;
      End
      Else
      Begin
        FIteBas := Value;
        qryAux.SQL.Add('SELECT ');
        qryAux.SQL.Add('  G.ITE_PRECUS, ');
        qryAux.SQL.Add('  G.ITE_CODITE, ');

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

        qryAux.SQL.Add('  G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ');

        qryAux.SQL.Add('FROM ');
        qryAux.SQL.Add('  ITEGER G ');
        qryAux.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  G.ITE_CODITE = :CODITE AND ');
        qryAux.SQL.Add('  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
        qryAux.ParamByName('CODITE').AsString := strIteBas;
        cdsAux := TClientDataSetFactory.GetClientDataSet(qryAux);


        If fCarregaPromocao(cdsAux.FieldByName('ITE_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro) Then
        Begin
          fltCusBasB := fltPreCusPro;
          fltVenBasB := fltPreVenPro;
          FPromoc    := 'S';

          If fltCusBasB = 0 Then
            fltCusBasB := cdsAux.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          fltCusBasB := cdsAux.FieldByName('ITE_PRECUS').AsFloat;
          fltVenBasB := cdsAux.FieldByName('ITE_PREVEN').AsFloat;
        End;

        FOutValBas := cdsAux.FieldByName('ITE_OUTVAL').AsFloat;
        FIcmsaiBas := cdsAux.FieldByName('ITE_ICMSAI').AsFloat * FVenBas;
        FImpFedBas := cdsAux.FieldByName('ITE_IMPFED').AsFloat * FVenBas;
        FDesOpeBas := cdsAux.FieldByName('ITE_DESOPE').AsFloat * FVenBas;
      End;
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

function fGetItemBaseOri(const strIteTin: String): string;
var
  cdsGen: TUniClientDataSet;
begin
  Result := '';
  if TMultiSelectLocalizadorFactory.GetLocalizador('ADVBAS').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
    Result := cdsGen.FieldByName('BAS_CODITE').AsString;
  
end;  

end.
