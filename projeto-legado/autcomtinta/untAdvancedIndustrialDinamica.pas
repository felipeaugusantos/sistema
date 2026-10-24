unit untAdvancedIndustrialDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, SysUtils, Controls,
  Math, Dialogs, untConsultaCompTinta, Variants;

Type
  TfrmConsultaCompAdvanced = class(TfrmConsultaCompTinta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaAdvanced = class(TFormulaIndustrial)  
  private
  protected
    procedure pCarregarBases; override;
    procedure pCarregarColorantes; override;
    procedure SetIteBas(const Value: String); override;
    procedure SetstrCompB(const Value: String); override;
  public
    procedure pCalculaPreco; override;
    procedure pCarregaPrecosColorantes; override;
    constructor Create(strTabPrePar: String); override;
    destructor Destroy; override;
  End;

  function fRetornaPrecoAdvancedDinamica(Sender: TForm; qryCadAdv: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  function fRetornaUniTraProAdvancedDinamica(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaDescricaoAdvancedDinamica(strDesCor: String; qryCadAdv: TUniQuery): String;

  function fDigDadosTintometricos(qryCadAdv: TUniQuery; strTabPre: String; var strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strCodUni: String): String;
  function fGTinForAdvancedDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;

  function fConsultaAdvancedDinamica(Sender: TForm): String; stdcall;
  function fConsultaAdvancedDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaAdvancedDinamicaVenda(Sender: TForm; qryCadAdv: TUniQuery; strTabPre: String): String; stdcall;

  function fConsultaAdvancedDinamicaInterna(Sender: TForm;  qryCadAdv: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;

  procedure pRetornaDadosAdvancedDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pAtualizaFatorTintometrico;
  procedure pRetornaTabelaPrecoAdvanced(dicRetorno: TDicionario);

implementation

uses DB, untDigTintaImobiliaria, untDigTintaIndustrial, untFuncoes;

{ TfrmConsultaCompAdvanced }

procedure TfrmConsultaCompAdvanced.pTarefaFormulacao(Sender: TObject);
  Var
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
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT * FROM ADV_CADADV WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre, strCodBas, strCodIte, strDesBas,
    strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create);

  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompAdvanced.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompAdvanced.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadAdvNovasFormulas', False);
end;

{ TFormulaAdvanced }

constructor TFormulaAdvanced.Create(strTabPrePar: String);
begin
  inherited Create(strTabPrePar, TComponenteIndustrial);
  qryCadBas := fCriaQuery();
  pCarregarBases;
end;

destructor TFormulaAdvanced.Destroy;
begin
  FreeAndNil(qryCadBas);
  inherited;
end;


procedure TFormulaAdvanced.pCalculaPreco;
  Var
    objComponente: TComponenteIndustrial;
    intIndex: Integer;

  procedure pZerarPrecos;
  begin
    FPreCus := 0.0;
    FPreVen := 0.0;
    FCusCol := 0.0;
    FVenCol := 0.0;
  End;
begin
  inherited;

  pZerarPrecos;

  For intIndex := 0 To Count -1 Do
  Begin

    objComponente := TComponenteIndustrial(Items[intIndex]);

    if objComponente.strTipComp = 'C' then
    begin
      If (Not qryCadCol.Locate('COL_CODCOL', objComponente.strCodcol, [])) Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não cadastrado. Favor verificar.');
        Exit;
      End;

      If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
      Begin
        pZerarPrecos;     
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
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

      If fEmptyStr(qryCadCol.FieldByName('COL_PESESP').AsString) Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não está com o peso específico cadastrado.' + #13#10 +
                               'Favor verificar.');
        Exit;
      End;

      If qryCadCol.FieldByName('COL_PESESP').AsFloat <= 0 Then
      Begin
        pZerarPrecos;
        Raise Exception.Create('Componente ' + objComponente.strCodCol + ' deve ter o peso específico maior que zero!' + #13#10 +
                               'Favor verificar.');
        Exit;
      End;
    End;

    FCusCol := FCusCol + objComponente.fltQtdCol * objComponente.fltPreCus / 3600;
    FVenCol := FVenCol + objComponente.fltQtdCol * objComponente.fltPreVen / 3600;
  End;


  FPreCus := FCusBas + FCusCol + IfThen(strCompB <> '', fltCusBasB, 0);
  FPreVen := FVenBas + FVenCol + IfThen(strCompB <> '', fltVenBasB, 0);;

  pCarregaPrecosColorantes;
end;

procedure TFormulaAdvanced.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objComponente: TComponenteIndustrial;
begin

  pAtualizaFatorTintometrico;

  For intContador := 0 To Self.Count-1 Do
  Begin
    objComponente := TComponenteIndustrial(Self.Items[intContador]);
    qryCadCol.Locate('COL_CODCOL', objComponente.strCodCol, []);
    objComponente.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
    objComponente.fltPreVen := qryCadCol.FieldByName('ITE_PREVEN').AsFloat;
    objComponente.fltPesEsp := qryCadCol.FieldByName('COL_PESESP').AsFloat;
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Parte B = ' + IfThen(strCompB <> '', FormatCurr('0.00', fltVenBasB), 'Incluso no valor da base'));
  FCalculo.Add('Valor do Componente = (Quantidade) * (Preço / 3600)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Volor do Componente de todos os Componentes)');
end;

procedure TFormulaAdvanced.pCarregarBases;
begin
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
  Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') Then
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

  Try
    qryCadBas.Open;
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

procedure TFormulaAdvanced.pCarregarColorantes;
begin
  inherited;
  qryCadCol.SQL.Clear;
  qryCadCol.SQL.Add('SELECT ');
  qryCadCol.SQL.Add('  COL_CODCOL, ');
  qryCadCol.SQL.Add('  COL_CODITE, ');
  qryCadCol.SQL.Add('  ITE_CNV_ML, ');
  qryCadCol.SQL.Add('  COL_PESESP, ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadCol.SQL.Add('  COL_PRECUS AS ITE_PRECUS, ');
    qryCadCol.SQL.Add('  COL_PREVEN AS ITE_PREVEN ');
  End
  Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') Then
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

  Try
    qryCadCol.Open;
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

procedure TFormulaAdvanced.SetIteBas(const Value: String);
  Var
    qryAux: TUniQuery;
begin
  inherited;
  pAtualizaFatorTintometrico;

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
        qryAux.SQL.Add('  BAS_PREVEN AS ITE_PREVEN ');
      End
      Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') Then
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
      qryAux.SQL.Add('  ADV_CADBAS ');
      qryAux.SQL.Add('  JOIN ITEGER ON ITE_CODITE = BAS_CODITE AND ');
      qryAux.SQL.Add('                 ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  ITE_CODITE = :CODITE ');

      qryAux.ParamByName('CODITE').AsString := FIteBas;
      qryAux.Open;

      FCusBasOri := qryAux.FieldByName('ITE_PRECUS').AsFloat;
      FVenBasOri := qryAux.FieldByName('ITE_PREVEN').AsFloat;

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

    Try
      qryAux.Open;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'');
      End;
    End;

    FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
    FVenBas := qryAux.FieldByName('ITE_PREVEN').AsFloat;

  End;
  qryAux.Close;
  FreeAndNil(qryAux);
end;


function fRetornaPrecoAdvancedDinamica(Sender: TForm; qryCadAdv: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  Var
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
begin
    strCodEmp    := dicRetorno['codemp'];
    strOpcDoc    := dicRetorno['opcdoc'];
    blnUsaPreCus := dicRetorno['usaprecus'];
    strTabPre    := dicRetorno['tabpre'];

    Result := False;

    If (fConsultaAdvancedDinamicaVenda(Sender, qryCadAdv, strTabPre) = '-1') Then
    Begin
      Exit;
    End;

    If Not fDigDadosTintometricos(qryCadAdv, strTabPre, strCodBas,
        strNovBas, strDesBas, strRefere, strUniBas, strDesCor, fltPreCus,
        fltPreVen, dicRetorno) Then
    Begin
      Exit;
    End;

    strIteTin := qryCadAdv.FieldByName('ADV_CARTA_').AsString +
      qryCadAdv.FieldByName('ADV_PRODUT').AsString +
      qryCadAdv.FieldByName('ADV_FORMUL').AsString +
      qryCadAdv.FieldByName('ADV_UNIDAD').AsString;

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

function fRetornaUniTraProAdvancedDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
begin
  strSiglaTrava := fArqIniTinta(0, 'ADVANCED', 'ADVTRA', '');
  fltFatTrava   := fStrToFloat(fArqIniTinta(0, 'ADVANCED', 'FATADV', ''));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoAdvancedDinamica(strDesCor: String; qryCadAdv: TUniQuery): String;
  Var
    strAux: String;
    strAuxb: String;
begin
  strAux := qryCadAdv.FieldByName('ADV_FORMUL').AsString;
  strAuxb := qryCadAdv.FieldByName('ADV_UNIDAD').AsString;

  Result := Trim(Format(strDesCor, [strAux, strAuxb]));
end;

function fDigDadosTintometricos(qryCadAdv: TUniQuery; strTabPre: String; var strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
  Var
    objComponente: TComponenteIndustrial;
    objFormula: TFormulaAdvanced;
    intContador: Integer;
begin
  Result := False;
  objFormula := TFormulaAdvanced.Create(strTabPre);
  objFormula.fltFatorEstoque := 1;
  objFormula.strIteBasOri := fRetornaProdutoBase(qryCadAdv.FieldByName('ADV_BASE01').AsString,
                                qryCadAdv.FieldByName('ADV_UNIDAD').AsString);

  objFormula.strIteBas := objFormula.strIteBasOri;
  objFormula.strUnidad := qryCadAdv.FieldByName('ADV_UNIDAD').AsString;

  objFormula.strDescri := fRetornaDescricaoAdvancedDinamica('%s', qryCadAdv);

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

  pAtualizaFatorTintometrico;
  objFormula.pCarregaPrecosColorantes;
  objFormula.pCalculaPreco;

  Try
    Application.CreateForm(TfrmDigTintaIndustrial  , frmDigTintaIndustrial );
    objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
    frmDigTintaIndustrial.Caption := frmDigTintaIndustrial.Caption + 'Advanced';
    frmDigTintaIndustrial.objFormula := objFormula;
    If frmDigTintaIndustrial.ShowModal = mrOk Then
      Result := True;
  Finally
    If Result Then
    Begin
      strNovBas := frmDigTintaIndustrial.strNovBas;
      strDesBas := frmDigTintaIndustrial.strDesBas;
      strRefere := frmDigTintaIndustrial.strRefere;
      strUniBas := frmDigTintaIndustrial.strUniBas;
      strDesCor := frmDigTintaIndustrial.strDesCor + ' %s ' + frmDigTintaIndustrial.strDesBas + ' %s ';
      fltPreCus := frmDigTintaIndustrial.fltPreCus;
      fltPreVen := frmDigTintaIndustrial.fltPreVen;
      strCodBas := frmDigTintaIndustrial.objFormula.strIteBasOri;
    End;

    dicRetorno['maximoqtdbase'] := frmDigTintaIndustrial.fltQtdMaximo;
    dicRetorno.AdicionarObjeto('formul', frmDigTintaIndustrial.matrizSaldosColorantes);
    dicRetorno['complementob'] := frmDigTintaIndustrial.objFormula.strCompB;

    FreeAndNil(frmDigTintaIndustrial);
  End;

  If Result And Assigned(dicRetorno) Then
    objFormula.pRecalculaTabelas(dicRetorno);

end;


function fRetornaProdutoBase(strCodBas, strCodUni: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   BAS_CODITE ');
  qryGen.SQL.Add(' FROM ADV_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_UNIDAD = :UNIDAD ');

  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('UNIDAD').AsString := strCodUni;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_CODITE').AsString;
  qryGen.Close;
end;

function fGTinForAdvancedDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;
  Var
    qryGen: TUniQuery;
    dicComponentes: TDicionario;

    strComponentes: String;
    strSql: String;
    intCont: Integer;
begin
  qryGen := fCriaQuery();
  dicComponentes := TDicionario.Create;
  strComponentes := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM ADV_CADADV ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + ' 	CONCAT( ';
  strSQL := strSQL + ' 	IFNULL(ADV_CARTA_, ""),  ';
  strSQL := strSQL + ' 	IFNULL(ADV_PRODUT, ""),  ';
  strSQL := strSQL + ' 	IFNULL(ADV_FORMUL, ""),  ';
  strSQL := strSQL + ' 	IFNULL(ADV_UNIDAD, "")) = :ITETIN ';

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Text := strSql;
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  If qryGen.IsEmpty Then
  Begin
    Result := False;
    Exit;
  End;

  For intCont := 1 To 12 Do
  Begin
    arrFormul[intCont].strFormul :=
      qryGen.FieldByName('ADV_CODC' + fStrZero(IntToStr(intCont), 2)).AsString;

    If fEmptyStr(arrFormul[intCont].strFormul) Then
      Break;

    arrFormul[intCont].fltQtdbas :=
      qryGen.FieldByName('ADV_QTDC' + fStrZero(IntToStr(intCont), 2)).AsFloat;

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
  strSql := strSql + ' WHERE COL_CODCOL IN(' + strComponentes + ') ';

  qryGen.Close;
  qryGen.SQL.Text := strSql;
  qryGen.Open;

  SetLength(arrBaixaPigmentos, qryGen.RecordCount);

  While Not qryGen.Eof Do
  Begin
    stlItensTraMl.Add(qryGen.FieldByName('COL_CODITE').AsString);

    arrBaixaPigmentos[qryGen.RecNo - 1].strCodIte := qryGen.FieldByName('COL_CODITE').AsString;
    arrBaixaPigmentos[qryGen.RecNo - 1].fltQtdBaixa := dicComponentes[qryGen.FieldByName('COL_CODCOL').AsString];
    arrBaixaPigmentos[qryGen.RecNo - 1].strTipComp := qryGen.FieldByName('TIPO').AsString;
    qryGen.Next;
  End;

  qryGen.Close;

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


  FreeAndNil(dicComponentes);
  FreeAndNil(qryGen);
end;

function fConsultaAdvancedDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  Result := fConsultaAdvancedDinamicaInterna(Sender, qryGen, '1', tpcGeral);
  FreeAndNil(qryGen);
end;

function fConsultaAdvancedDinamicaGeral(Sender: TForm): String; stdcall;
begin
  Result := fConsultaAdvancedDinamica(Sender);
end;

function fConsultaAdvancedDinamicaVenda(Sender: TForm; qryCadAdv: TUniQuery; strTabPre: String): String; stdcall;
begin
  Result := fConsultaAdvancedDinamicaInterna(Sender, qryCadAdv, strTabPre, tpcVenda);
end;

function fConsultaAdvancedDinamicaInterna(Sender: TForm;  qryCadAdv: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;
  Var
    strSql: String;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    frmConsulta: TfrmConsultaCompAdvanced;
begin
  Result := '-1';

  If Not Assigned(qryCadAdv) Then
    Exit;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('ADV_FORMUL+ADV_CARTA_+ADV_PRODUT');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Fórmula/Catalogo/Produto');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição/Referência');

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ADV_CARTA_    "Catalogo", ';
  strSQL := strSQL + '   ADV_PRODUT    "Produto", ';
  strSQL := strSQL + '   ADV_FORMUL    "Fórmula", ';
  strSQL := strSQL + '   ADV_UNIDAD    "Unidade", ';
  strSQL := strSQL + '   ITE_CODITE    "Código do Item", ';
  strSQL := strSQL + '   ITE_DESITE    "Descrição", ';
  strSQL := strSQL + '   ITE_REFERE    "Referência", ';
  strSQL := strSQL + '   ADV_CADADV.AUTOINCREM ';
  strSQL := strSQL + ' FROM ADV_CADADV ';
  strSQL := strSQL + '   INNER JOIN ADV_CADBAS ';
  strSQL := strSQL + '     ON ADV_BASE01 = BAS_CODBAS ';
  strSQL := strSQL + '       AND ADV_UNIDAD = BAS_UNIDAD ';
  strSQL := strSQL + '   INNER JOIN CADITE ';
  strSQL := strSQL + '     ON BAS_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE TRUE ';

  frmConsulta := TfrmConsultaCompAdvanced.Create(Sender, tipoConsulta, strTabPre);
  frmConsulta.Caption := 'Conmsulta Advanced';

  If pConsultaEspecifica(sender, frmConsulta, qryCadAdv, 'ADV_CADADV',
    strSql, stlCamInd, stlDesInd, '', False, True, 5, True) Then
  Begin
    If Not qryCadAdv.IsEmpty Then
      Result := qryCadAdv.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
  FreeAndNil(frmConsulta);
end;

procedure pRetornaDadosAdvancedDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryGen: TUniQuery;
    strSql: String;
begin
  qryGen := fCriaQuery();

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   * ';
  strSQL := strSQL + ' FROM ADV_CADADV ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + ' 	CONCAT( ';
  strSQL := strSQL + ' 	IFNULL(ADV_CARTA_,""),  ';
  strSQL := strSQL + ' 	IFNULL(ADV_PRODUT, ""),  ';
  strSQL := strSQL + ' 	IFNULL(ADV_FORMUL, ""),  ';
  strSQL := strSQL + ' 	IFNULL(ADV_UNIDAD, "")) = :ITETIN ';

  qryGen.Close;
  qryGen.SQL.Text := strSql;
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;
  dicRetorno['codtin'] := qryGen.FieldByName('ADV_FORMUL').AsString + ' ' + qryGen.FieldByName('ADV_FORMUL').AsString;
end;

procedure pAtualizaFatorTintometrico;
//  Var
//    qryGen: TUniQuery;
begin
//  qryGen := fCriaQuery();
//  qryGen.SQL.Text := 'UPDATE CADITE CADITE INNER JOIN ADV_CADCOL ON ITE_CODITE = COL_CODITE SET ITE_CNV_ML = ITE_EMBALA;';
//  qryGen.ExecSQL;
//  FreeAndNil(qryGen);
end;

procedure pRetornaTabelaPrecoAdvanced(dicRetorno: TDicionario);
  Var
    objFormula: TFormulaAdvanced;
begin
  objFormula := TFormulaAdvanced.Create('1');
  pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, 1);
end;


procedure TFormulaAdvanced.SetstrCompB(const Value: String);
  Var
    qryAux: TUniQuery;
begin
  inherited;
  pAtualizaFatorTintometrico;

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

    Try
      qryAux.Open;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'');
      End;
    End;

    fltCusBasB := qryAux.FieldByName('ITE_PRECUS').AsFloat;
    fltVenBasB := qryAux.FieldByName('ITE_PREVEN').AsFloat;

  End;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

end.
